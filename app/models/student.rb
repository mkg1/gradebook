class Student < ActiveRecord::Base
  has_secure_password
  has_many :parents
  belongs_to :teacher
end
