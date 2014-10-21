class Questionnaire < ActiveRecord::Base
  has_and_belongs_to_many :programs
  has_many :questions, dependent: :destroy
  has_many :questionnaire_completenesses, dependent: :destroy
  has_many :people, through: :questionnaire_completenesses

  accepts_nested_attributes_for :questions

  validates :title_ru, :title_uk, presence: true

  def complete!(person_id)
    QuestionnaireCompleteness.find_by(person_id: person_id, questionnaire_id: id).update_column(:completed, true)
  end
end
