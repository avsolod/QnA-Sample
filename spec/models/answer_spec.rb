require 'rails_helper'

RSpec.describe Answer, type: :model do

  describe 'validations' do
    %i(title body question_id).each do |field|
      it { is_expected.to validate_presence_of field }
    end
  end

  describe 'relations' do
    it { is_expected.to belong_to :question }
  end
end
