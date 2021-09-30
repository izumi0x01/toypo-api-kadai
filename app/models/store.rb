# frozen_string_literal: true

class Store < ActiveRecord::Base
  has_many :connections, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  def is_token_match?(token, client)
    
    self.valid_token?(token, client)
    
  end
  
end
