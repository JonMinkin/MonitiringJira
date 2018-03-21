FactoryGirl.define do
  factory :user do
   sequence(:email) {|i| "email#{i}@email.com"}
   password "qw12345678"
   password_confirmation {"qw12345678"}
   confirmed_at "2016-02-29 06:20:12"
   confirmation_token "xG8MvtVFfvsxycDzWDiA"
  end
end