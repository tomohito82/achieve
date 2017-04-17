class ContactsController < ApplicationController
  before_action :set_contact, only: [:edit, :update, :destroy]

  def index
    @contacts = Contact.all
  end
  
  def new
   if params[:back]
     @contact = Contact.new(contacts_params)
   elsif
     @contact = Contact.new
   end
  end

  def create
    @contact = Contact.new(contacts_params)
    if @contact.save
      redirect_to root_path, notice: "お問い合わせが完了しました！"
    else
      render 'new'
    end
  end

  def edit
    @contact = Contact.find(params[:id])
  end
  
  def update
    @contact = Contact.find(params[:id])
    
    if @contact.update(contacts_params)
      redirect_to contacts_path, notice: "お問い合わせを更新しました！"
    else
      render 'new'
    end
  end
  
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    redirect_to contacts_path, notice: "お問い合わせを削除しました！"
  end
  
  def confirm
    @contact = Contact.new(contacts_params)
    render :new if @contact.invalid?
  end
  
private
  def contacts_params
   params.require(:contact).permit(:name, :email, :content)
  end
   
  def set_contact
   @contact = Contact.find(params[:id])
  end
end