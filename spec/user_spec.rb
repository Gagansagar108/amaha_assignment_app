require 'rails_helper'



describe User do
  describe '#bark' do
    it 'returns the "user speak"'do
      user = User.speak
      expect(user).to eql('user speak self method')
    end
  end
end








  #https://amahastorage.s3.ap-south-1.amazonaws.com/tq0jdn2wj30j8336p89gj7epltwa
#customers/get_nearest_customers
