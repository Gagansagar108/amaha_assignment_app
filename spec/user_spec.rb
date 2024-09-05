require 'rails_helper'



describe User do
  describe '#speak' do
    it do
      user = User.new
      expect(user.speak).to eql?('user speak')
    end
  end
end
