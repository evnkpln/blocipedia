class ChargesController < ApplicationController
  def create
    # Creates a Stripe Customer object, for associating
    # with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    # Where the real magic happens
    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- this is NOT the user_id in your app
      amount: 10_00,
      description: "Premium Blocipedia Membership - #{current_user.email}",
      currency: 'usd'
    )
    current_user.role = :premium
    current_user.save!
    flash[:notice] = "You've been upgraded to premium. Enjoy your #{current_user.role} service!"
    redirect_to welcome_index_path

    # Stripe will send back CardErrors, with friendly messages
    # when something goes wrong.
    # This `rescue block` catches and displays those errors.
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end
  def new
   @stripe_btn_data = {
     key: "#{ Rails.configuration.stripe[:publishable_key] }",
     description: "Premium Blocipedia Membership - #{current_user.email}",
     amount: 10_00
   }
  end

  def downgrade
  end

  def demote
    current_user.role = :free
    current_user.wikis.each do |wiki|
      wiki.private = false
      wiki.save!
    end
    current_user.save!
    flash[:notice] = "You've been downgraded to free. Enjoy your #{current_user.role} service!"
    redirect_to welcome_index_path
  end
end
