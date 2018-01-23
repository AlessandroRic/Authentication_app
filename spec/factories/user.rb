FactoryGirl.define do
  factory :user do
    first_name 'John'
    last_name 'Carter'
    email 'john@example.com'
    password 'foobar'
    password_confirmation 'foobar'

    factory :other_user do
      first_name 'Flash'
      last_name 'Gordon'
      email 'flash@example.com'
      password 'foobar'
      password_confirmation 'foobar'

      factory :invalid_user do
    first_name 'J'
    last_name 'Carter'
    email 'john_at_example'
    password 'foo'
    password_confirmation 'bar'
    end
    end
  end
end