require 'rails_helper'

RSpec.describe Question, type: :model do

  describe 'validations' do
    %i(title body user_id).each do |field|
      it { is_expected.to validate_presence_of field }
    end
  end

  describe 'relations' do
    it { is_expected.to have_many(:answers).dependent(:destroy) }
    it { is_expected.to belong_to(:user) }
  end
end