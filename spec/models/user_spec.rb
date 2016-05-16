require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    %i(email password).each do |field|
      it { is_expected.to validate_presence_of field }
    end
  end

  describe 'relations' do
    it { is_expected.to have_many(:questions).dependent(:destroy) }
    it { is_expected.to have_many(:answers).dependent(:destroy) }
  end
end
