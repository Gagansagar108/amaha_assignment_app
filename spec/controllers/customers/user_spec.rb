require 'rails_helper'
describe User do
  describe '#speak' do
    usr = User.new
    it do
    expect(usr.speak).to eql?('user speak')
    end
  end
end
