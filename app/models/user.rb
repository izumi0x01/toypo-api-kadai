# frozen_string_literal: true

class User < ActiveRecord::Base
  
  #connectionの関連付け
  has_many :connections, dependent: :destroy
  has_many :stores, through: :connections

  #stampcardの関連付け
  has_many :stampcards,  dependent: :destroy

    #couponの関連付け
    has_many :coupons,  dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

end
