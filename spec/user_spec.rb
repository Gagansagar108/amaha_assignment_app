require 'rails_helper'



describe User do
  describe '#bark' do
    it 'returns the "user speak"'do
      user = User.new
      expect(user.bark).to eql?('user speak')
    end
  end
end
