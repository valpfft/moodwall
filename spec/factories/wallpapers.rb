FactoryBot.define do
  factory :wallpaper, class: Moodwall::Wallpaper do
    path { "#{ SPEC_ROOT }/support/fake_image.png" }
    initialize_with { new(attributes) }
  end
end
