class Interest < ApplicationRecord
  OPERATORS = {
    match: 'match',
    range: 'range'
  }

  attribute :data, default: -> { [] }

  enum operator: OPERATORS

  has_many :user_profile_interests, dependent: :destroy
  has_many :user_profiles, through: :user_profile_interests

  scope :suggest, -> { where(suggest: true) }


  def match?(interestable)
    target_value = interestable.send(target.to_sym)

    case operator
    when OPERATORS[:range]
      target_value in data
    when OPERATORS[:match]
      if target_value != 'all'
        target_value == data
      elsif target_value.is_a? Array
        target_value.some { |value| value.data == data }
      else
        true
      end
    else
      false
    end
  end
end
