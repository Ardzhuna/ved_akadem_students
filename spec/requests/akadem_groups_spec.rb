require 'spec_helper'

describe "AkademGroups" do
  after(:all) { AkademGroup.destroy_all }

  it_behaves_like "renders _form on New and Edit pages" do
    let(:new_path) { new_akadem_group_path }
    let(:edit_path) { edit_akadem_group_path(create_akadem_group) }
  end
end
