# frozen_string_literal: true

class User < ActiveRecord::Base
  
  #connectionの関連付け
  has_many :connections, dependent: :destroy

  #stampcardの関連付け
  has_many :stampcards,  dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

end
