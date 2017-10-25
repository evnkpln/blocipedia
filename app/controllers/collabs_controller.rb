class CollabsController < ApplicationController
  def new
    @wiki = Wiki.find(params[:wiki_id])
    @collab = Collab.new
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collab = Collab.new
    @collab.wiki = @wiki
    @collab.user = User.find_by_email(params[:collab][:user])

    if @collab.save
      flash[:notice] = "#{@collab.user.email} was added as a collaborator"
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error. Please try again."
      render :new
    end
  end

  def destroy
    @collab = Collab.find(params[:id])
    @wiki = @collab.wiki
    # authorize @collab

    if @collab.destroy
      flash[:notice] = "User removed as collaborator."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error. Please try again or check your permissions."
      render :show
    end
  end
end
