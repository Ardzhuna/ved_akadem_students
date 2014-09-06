namespace :akadem do
  desc 'Create initial questionnaires'
  task create_questionnaires: :environment do
    puts 'Reading data...'

    psyho_test        = YAML.load_file(Rails.root.join('spec/fixtures/questionnaires/psyho_test.yml'))
    initial_questions = YAML.load_file(Rails.root.join('spec/fixtures/questionnaires/initial_questions.yml'))

    puts 'Populating...'

    psyho_questionnaire = Questionnaire.create(
                            title:        psyho_test[:title],
                            description:  psyho_test[:description],
                            questions:    psyho_test[:questions].map { |q| Question.new(format: 'boolean', data: { text: q[:question]}) })

    initial_questionnaire = Questionnaire.create(
                            title:        initial_questions[:title],
                            questions:    initial_questions[:questions].map { |q| Question.new(format: 'freeform', data: { text: q[:question]}) })

    puts 'Adding questionnaires to Study applications...'
    Program.all.each do |program|
      program.questionnaires << [psyho_questionnaire, initial_questionnaire]
    end
    puts 'Done.'
  end
end
