class StoresController < ApplicationController
  
  before_filter :authenticate ,   :only => [:index, :show]
  before_filter :access_to_file,  :only => [:show]
  def index
    @store = Store.new
  end

  def show
    @store = Store.find(params[:id])
    @user  = User.find(@store.user_id)
  end

  def upload

    Store.save(params[:store])
    @store = Store.new(:name        => params[:store]['file'].original_filename.downcase, 
                       :user_id     => params[:store]['user_id'],
                       :private     => params[:store]['private'])
    @store.save
    flash[:success] = "File has been uploaded"
    redirect_to upload_path
  end

  private

  def access_to_file
    store = Store.find(params[:id])
    if store.private && current_user.id != store.user_id
      redirect_to current_user, :flash => { :notice => "sorry, that was a private file"}
    end
  end

end
