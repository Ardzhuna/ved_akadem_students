require 'rails_helper'

describe 'people/edit.html.erb' do
  subject { page }

  Given do
    @admin = create(
      :person,
      :admin,
      name:               'Ivan',
      work:               'никогда',
      email:              'juke@ulr.net',
      gender:             true,
      surname:            'Жук',
      birthday:           '1975-01-30'.to_date,
      education:          'где-то когда-то',
      telephones:         [build(:telephone, phone: '+380 50 111 2233')],
      middle_name:        'Petrovich',
      spiritual_name:     'Dasa Das',
      emergency_contact:  'дед Василий'
    )
  end

  Given { login_as(@admin) }

  When  { visit edit_person_path(@admin) }

  describe 'default values' do
    context 'gender is Male' do
      Then  { is_expected.to have_css('#person_gender option[selected="selected"]', text: 'Чоловіча') }
    end

    context 'gender is Female' do
      Given { @admin.update_attribute(:gender, false) }

      Then  { is_expected.to have_css('#person_gender option[selected="selected"]', text: 'Жіноча') }
    end

    context 'admin' do
      Then { is_expected.to have_title(full_title(complex_name(@admin, :t))) }
      And  { is_expected.to have_selector('h1', text: complex_name(@admin)) }
      And  { is_expected.to have_selector('#phone[value="+380501112233"]') }
      And  { is_expected.to have_selector('#person_spiritual_name[value="Dasa Das"]') }
      And  { is_expected.to have_selector('#person_name[value="Ivan"]') }
      And  { is_expected.to have_selector('#person_middle_name[value="Petrovich"]') }
      And  { is_expected.to have_selector('#person_surname[value="Жук"]') }
      And  { is_expected.to have_selector('#person_email[value="juke@ulr.net"]') }
      And  { is_expected.to have_css('#person_education', text: 'где-то когда-то') }
      And  { is_expected.to have_css('#person_work', text: 'никогда') }
      And  { is_expected.to have_selector('#person_emergency_contact[value="дед Василий"]') }
      And  { expect(find('#datepicker[name="person[birthday]"]').value).to eq('1975-01-30') }
    end
  end
end
