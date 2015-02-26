class Attachment < ActiveRecord::Base

   belongs_to :attachable, :polymorphic => true

   mount_uploader :file, FileUploader

   rails_admin do

    	list do
      		field :name
      		field :file
      		field :created_at
    	end

    	edit do  
      		field :name do
      			optional false
            default_value do
              'Вложение'
            end
      		end
      		field :file, :carrierwave do
      			optional false
      		end
    	end
	end

end
