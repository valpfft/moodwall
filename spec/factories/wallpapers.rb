FactoryBot.define do
  factory :wallpaper, class: Moodwall::Wallpaper do
    path { "~/Pictures/wallpaper.png" }
    initialize_with { new(attributes) }
  end
end
