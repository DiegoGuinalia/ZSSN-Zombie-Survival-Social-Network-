FactoryBot.define do
  factory :item do
    id { 1 }
    name { "water" }
    price { "4" }

    trait :food do
      id { 2 }
      name { "food" }
      price { "3" }  
    end

    trait :medicine do
      id { 3 }
      name { "medicine" }
      price { "2" }  
    end

    trait :ammunition do
      id { 4 }
      name { "ammunition" }
      price { "1" }
    end
  end
end
