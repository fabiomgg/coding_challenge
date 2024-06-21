class User < ApplicationRecord
  validates :name, presence: true
  validates :password, presence: true, length: { minimum: 10, maximum: 16 }
  validate :password_strength

  private 

  def password_strength
    return if password.blank?

    unless password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$/)
      errors.add :password, 'must contain at least one lowercase character, one uppercase character and one digit'
    end

    unless password.match(/^(?!.*(.)\1{2}).*$/)
      errors.add :password, 'cannot contain three repeating characters'
    end
  end
end
