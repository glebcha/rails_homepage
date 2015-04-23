class Post < ActiveRecord::Base

  belongs_to :user, :inverse_of => :posts

  has_many :attachments, :as => :attachable, dependent: :destroy, class_name: 'Attachment'

  accepts_nested_attributes_for :attachments, :allow_destroy => true

  default_scope { order('created_at DESC') }

  mount_uploader :background, BackgroundUploader

  acts_as_punchable

  acts_as_taggable_on :tags

  acts_as_url :name, :sync_url => true, :limit => 50

  def to_param
    url
  end

  def status_enum
    all_status = {1 => 'Опубликована', 0 => 'Черновик', 2 => 'Забанена'}
    all_status.map{|key, val| [val, key]}
  end

  def previous
    Post.where(["id < ?", id]).last
  end

  def next
    Post.where(["id > ?", id]).first
  end

  rails_admin do

    list do
      field :name do
        pretty_value do
          %{<a href="}.html_safe + bindings[:view].rails_admin.edit_path('post', bindings[:object].id) + %{" class="label label-default">#{value}</span>}.html_safe
        end
      end
      field :tags do
        pretty_value do
         bindings[:object].tag_list.map do |tag|
            %{<span class="label label-info pull-left" style="margin: 0 2px;">#{tag}</span>}
          end.join("").html_safe
        end
      end
      field :hits
      field :status
      field :updated_at
      field :user
    end

    edit do  
      field :name do
      	optional false
      end
      field :body, :ck_editor do
	      help ''
      end
      field :background do
        help ''
      end
      field :tags do
        help 'Выберите или создайте теги'
      end
      field :attachments do
        help ''
      end
      field :status do
        visible do
          true if bindings[:view]._current_user.role.admin? || bindings[:view]._current_user.role.editor?
        end
        help ''
      end
      field :user do
        inline_add do
          true if bindings[:view]._current_user.role.admin?
        end
        inline_edit do
          true if bindings[:view]._current_user.role.admin?
        end
        default_value do
          bindings[:view]._current_user.id
        end 
        help ''
      end
      field :created_at do
        visible do
          true if bindings[:view]._current_user.role.admin?
        end
        help ''
      end      
    end

  end
end
