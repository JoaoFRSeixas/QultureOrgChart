FactoryBot.define do
  factory :employee do
    name { "MyString" }
    email { "MyString" }
    picture { "MyString" }
    company { nil }
    manager_id { 1 }
  end
end
