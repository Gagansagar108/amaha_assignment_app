require 'rails_helper'



describe User do
  describe '#bark' do
    it 'returns the "user speak"'do
      user = User.speak
      expect(user).to eql('user speak self method')
    end
  end
end








