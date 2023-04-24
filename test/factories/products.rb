FactoryBot.define do
  factory :product do
    name {"Skateboard"}
    category {"Outdoors"}
    price_per_day {3.5}
    year_of_purchase {2022}
    condition {"Good"}
    latitude {12.1}
    longitude {24.6}
    address {"3 rue de Paris"}
    sport {"Skateboarding"}
    user_id {5}
    admin {false}

    factory :invalid_product do
      name {3}
      category {true}
      price_per_day {"hello"}
      year_of_purchase {"2022"}
      condition {false}
      latitude {"yes"}
      longitude {"no"}
      address {2}
      sport {true}
      user_id {false}
      admin {true}
    end
  end
end
