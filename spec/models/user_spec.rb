require 'rails_helper'

RSpec.describe User, type: :model do
  let(:valid_attributes) {
    {
      first_name: 'John',
      last_name: 'Doe',
      email: 'john@doe.com',
      password: '12345',
      password_confirmation: '12345'
    }
  }

  context 'relationships' do
    it { should have_and_belong_to_many(:movies) }
    it { should have_many(:providers) }
  end

  context 'validations' do
    let(:user) { User.new(valid_attributes) }

    before do
      User.create(valid_attributes)
    end

    it 'requires an email' do
      expect(user).to validate_presence_of(:email)
    end
  end

  context '#downcase_email' do
    it 'makes the email attribute lower case' do
      user = User.new(valid_attributes.merge(email: 'JOHN@DOE.COM'))
      expect { user.downcase_email }.to change{ user.email }.
        from('JOHN@DOE.COM').
        to('john@doe.com')
    end

    # it 'downcases an email before saving' do
    #   user = User.new(valid_attributes)
    #   user.email = 'JOHN@DOE.COM'
    #   expect(user.save).to be_truthy
    #   expect(user.email).to eq('john@doe.com')
    # end
  end
end
