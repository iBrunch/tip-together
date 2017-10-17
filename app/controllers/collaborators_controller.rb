class CollaboratorsController < ApplicationController
  before_action :set_wiki

  def new
    @collaborator = Collaborator.new
  end
  
  def create
       @wiki = Wiki.find(params[:wiki_id])
       @user = User.find_by_email(params[:collaborator][:user])
       
      if @user.nil?
        flash[:alert] = "Collaborator must be an active user."
        redirect_to edit_wiki_path(@wiki)
        
      elsif @user.id === current_user.id
        flash[:alert] = "You are the owner of this wiki."
        redirect_to edit_wiki_path(@wiki)

      elsif @wiki.collaborators.where(user_id: @user.id).first != nil
        flash[:alert] = "User is already collaborating with you."
        redirect_to edit_wiki_path(@wiki)
      else
       @collaborator = @wiki.collaborators.new(wiki_id: @wiki.id, user_id: @user.id)
       if @collaborator.save
         flash[:notice] = "Collaborator has been added."
         redirect_to edit_wiki_path(@wiki)
       else
         flash[:alert] = "Unable to save collaborator, please try again."
         redirect_to edit_wiki_path(@wiki)
       end
      end
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.find(params[:id])

    if @collaborator.destroy
      flash[:notice] = "This collaborator has been removed."
      redirect_to edit_wiki_path(@wiki)
    else
      flash[:alert] = "Collaborator was not removed. Please try again."
      redirect_to edit_wiki_path(@wiki)
    end
  end

  private
  def set_wiki
    @wiki = Wiki.find(params[:wiki_id])
  end
end
