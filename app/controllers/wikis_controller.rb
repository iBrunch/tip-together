class WikisController < ApplicationController
  before_action :authorize_user, except: [:index, :show, :new, :create]
  before_action :authorize_new, except: [:index, :show, :edit, :update, :destroy]
  
  def index
    @user = current_user
    @wikis = policy_scope(Wiki)
  end
  
  def show
    @user = current_user
    @wiki = Wiki.find(params[:id])
  end

  def new
    @user = current_user
    @wiki = Wiki.new
  end
  
  def create
    @user = current_user
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user
    
    if @wiki.save
      flash[:notice] = "Tip was saved."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the Tip. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    @users = User.all
    @collaborator = Collaborator.new
  end
  
  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)
    if @wiki.save
      flash[:notice] = "Tip was updated."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the tip. Please try again."
      render :edit
    end
  end
  
  def destroy
    @wiki = Wiki.find(params[:id])
    @wiki.destroy!
    
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the tip."
      render :show
    end
  end
  
  def downgrade
    current_user.member!
  end
  
 private
 
  def authorize_user
    @wiki = Wiki.find(params[:id])
    @user = current_user
    unless current_user.admin? || current_user.premium? || @wiki.collaborators.exists?('user_id' => @user.id)
      flash[:alert] = "You must be a premium member to do that."
      redirect_to wikis_path
    end
  end
  
  def authorize_new
    unless current_user.admin? || current_user.premium?
      flash[:alert] = "You must be a premium member to do that."
      redirect_to wikis_path
    end
  end
 
  def wiki_params
    params.require(:wiki).permit(:title, :body, :private, :user, :user_ids)
  end
end
