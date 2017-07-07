class User < ActiveRecord::Base

  has_one :stat, dependent: :destroy
  has_many :log, -> { order(created_at: :desc) }, dependent: :destroy
  before_create :create_stat
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :confirmable,
         :authentication_keys => [:email]

  email_regex = /\A[^@ \t\n]+@[^@\.]+(\.[^@ \t\n\.]+)*\.[^@ \t\n\.]+\z/
  validates_presence_of    	:password,  :username, :firstname, :lastname, :college, :gender, 	:on=>[:create]
  validates_uniqueness_of	:username, 	:case_sensitive => false, :allow_blank => false
  validates_uniqueness_of	:email, 	:case_sensitive => false, :allow_blank => false
  validates_format_of    	:email,    	:with  => email_regex, :allow_blank => false
  validates_confirmation_of	:password, 	:on=>[:create, :update]
  validates_length_of    	:password, 	:within => Devise.password_length, :allow_blank => false, :on => [:create]
  validates_length_of    	:password, 	:within => Devise.password_length, :allow_blank => true, :on => [:update]


  def confirm(args={})
    pending_any_confirmation do
      if confirmation_period_expired?
        self.errors.add(:email, :confirmation_period_expired,
          period: Devise::TimeInflector.time_ago_in_words(self.class.confirm_within.ago))
        return false
      end

      self.confirmed_at = Time.now.utc
      self.active = true
      require 'digest/md5'
      if unconfirmed_email.present?
        self.encrypted_email = Digest::MD5.hexdigest(unconfirmed_email)
      else
        self.encrypted_email = Digest::MD5.hexdigest(self.email)
      end
      saved = if self.class.reconfirmable && unconfirmed_email.present?
        skip_reconfirmation!
        self.email = unconfirmed_email
        self.unconfirmed_email = nil
        #self.encrypted_email = Digest::MD5.hexdigest(self.email)
        # We need to validate in such cases to enforce e-mail uniqueness
        save(validate: true)
      else
        save(validate: args[:ensure_valid] == true)
      end

      after_confirmation if saved
      saved
    end
  end

  private
  def create_stat
    build_stat(origin_time: Time.now.in_time_zone("Eastern Time (US & Canada)"))
  end

end
