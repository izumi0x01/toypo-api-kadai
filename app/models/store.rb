# frozen_string_literal: true

class Store < ActiveRecord::Base

  #connectionの関連付け
  has_many :connections, dependent: :destroy

  #stampcard_contentの関連付け
  has_many :stampcard_contents, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User



  

end
