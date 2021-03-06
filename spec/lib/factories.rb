require 'faker'
require_relative '../models/user_model'

FactoryBot.define do
  factory :user, class: UserModel do
    full_name { 'Katia Kurenai' }
    email { 'katia@kurenai.com' }
    password { '123katia' }

    # Depois que criar o usuario, deleta.
    after(:build) do |user|
      Database.new.delete_user(user.email)
    end
  end

  factory :registered_user, class: UserModel do
    id {0}
    full_name { Faker::Movies::HarryPotter.character }
    email { Faker::Internet.free_email(name: full_name) }
    password { '1234katia' }

    after(:build) do |user|
      Database.new.delete_user(user.email)
      result = ApiUser.save(user.to_hash)
      user.id = result.parsed_response['id']
    end
  end

  factory :user_wrong_email, class: UserModel do
      full_name { 'Katia Kurenai' }
      email { 'katia#kurenai.com' }
      password { '123katia' }
  end

  factory :empty_name_user, class: UserModel do
    full_name { '' }
    email { 'katia@kurenai.com' }
    password { '123katia' }
  end

  factory :empty_email_user, class: UserModel do
    full_name { 'Katia Kurenai' }
      email { '' }
      password { '123katia' }
  end

  factory :empty_password_user, class: UserModel do
    full_name { 'Katia Kurenai' }
    email { 'katia@kurenai.com' }
    password { '' }
  end

  factory :null_name_user, class: UserModel do
    email { 'katia@kurenai.com' }
    password { '123katia' }
  end

  factory :null_email_user, class: UserModel do
    full_name { 'Katia Kurenai' }
    password { '123katia' }
  end

  factory :null_password_user, class: UserModel do
    full_name { 'Katia Kurenai' }
    email { 'katia@kurenai.com' }
  end
end
