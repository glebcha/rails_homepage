class User < ActiveRecord::Base
  
  has_many :posts, dependent: :destroy, :inverse_of => :user

  extend Enumerize
  serialize :role, Array
  enumerize :role, in: [:admin, :editor, :user], default: :user, multiple: true, predicates: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:github]

  def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid.to_s).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.name = auth.info.name if user.name.blank?
        user.password = Devise.friendly_token[0,20]
      end
  end

  before_save :set_name

  def set_name
    self.name = "Пользователь" + rand(2**256).to_s(36)[0..7] if self.name.blank?
  end

  rails_admin do

    list do
      field :name do
        pretty_value do
          %{<a href="}.html_safe + bindings[:view].rails_admin.edit_path('user', bindings[:object].id) + %{" class="label label-default">#{value}</span>}.html_safe
        end
      end
      field :role do
        pretty_value do
         bindings[:object].role.values.map do |role|
            %{<span class="label label-info">#{role}</span>&nbsp}
          end.join("").html_safe
        end
      end      
      field :last_sign_in_at
      field :last_sign_in_ip
    end

    edit do  
      field :email
      field :password do
        required false
      end
      field :password_confirmation do 
        help "Подтвердите пароль"
      end
      field :name do 
        required true
      end
      field :role do
        visible do
          true if bindings[:view].current_user.role.admin?
        end
        help ''
      end
    end

  end

end