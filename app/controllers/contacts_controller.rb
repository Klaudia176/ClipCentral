class ContactsController < ApplicationController   

def reply
    @contact = Contact.find(params[:id])
    @contact.update(reply: params[:reply])
  
    redirect_to contacts_path, notice: 'Odpowiedź została zapisana.'
end

def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    
    redirect_to contacts_path, notice: 'Zgłoszenie zostało usunięte.'
end

end
  