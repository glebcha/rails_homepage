RailsAdmin.config do |config|
	
  require 'i18n'
  I18n.default_locale = :ru
  config.main_app_name = Proc.new { |controller| [ "Glebcha", "Слабоумие и отвага - #{controller.params[:action].try(:titleize)}" ] }
  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  config.authorize_with :cancan
  config.current_user_method &:current_user

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'Post', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ## == Tags ==
  config.model ActsAsTaggableOn::Tag do
    navigation_label ''
    label 'Тег'
    label_plural 'Теги'
    list do
      field :name do
        label "Имя"
      end
      field :taggings_count do
        label "Использовано раз"
      end
    end
    edit do
      field :name do
        label "Имя"
      end 
      exclude_fields :taggings_count
      exclude_fields :taggings
    end
  end

  config.included_models = ['User', 'Post', 'Attachment', 'ActsAsTaggableOn::Tag']


  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     
    index                         
    new
    # export
    bulk_delete
    # show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
