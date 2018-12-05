FactoryBot.define do
  factory :mood, class: Moodwall::Mood do
    name { "Winter" }
    current { false }

    initialize_with { new(name: name, current: current) }

    trait :current do
      current { true }
    end
  end
end
