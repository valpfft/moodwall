FactoryBot.define do
  factory :executable, class: Moodwall::Executable do
    command   { "ls" }
    arguments { "-la" }

    initialize_with { new(command: command, arguments: arguments) }
  end
end
