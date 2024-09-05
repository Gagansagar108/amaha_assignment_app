describe User do
  describe '#speak' do
    usr = User.new
    expect(usr.speak).to eql?('user speak')
  end
end
