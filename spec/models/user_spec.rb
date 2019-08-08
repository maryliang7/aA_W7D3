require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:username)}
    it { should validate_presence_of(:password_digest)}
    it { should validate_presence_of(:session_token)}
    it { should validate_uniqueness_of(:session_token)}
    it { should validate_uniqueness_of(:username)}
    it { should validate_length_of(:password).is_at_least(5)}
  end

  describe 'class methods' do
    describe '::find_by_credentials' do
      person = User.create(username: 'jon', password_digest: '123456', session_token: 'adf')
      it 'finds user by their username and password' do  
        expect(User.find_by_credentials('jon', '123456')).to be(person)
      end
      it 'does not return user with incorrect creds' do
        expect(User.find_by_credentials('joon', '123456')).not_to eq(person)
      end
    end
    
  end

  describe 'instance methods' do 
    describe '#password=' do 
      person = User.create(username: 'jon', password: '123456')
      it 'sets the password and password digest' do
        # expect(User.create(username: 'jon', password: '123456')).to receive(:password=).with('123456')
        expect(BCrypt::Password).to receive(:create)
      end
    end

    describe '#is_password?' do
      it 'checks if password is the correct password for user' do
      expect(BCrypt::Password).to receive(:new)
        person = User.create(username: 'jon', password: '123456')

        # expect(person.password_digest).to receive(:is_password?)
      end
    end

    describe '#reset_session_token!' do
      it 'resets the session token' do
        person = User.create(username: 'jon', password_digest: '123456', session_token: 'asd')
        person2 = person.reset_session_token!
        expect(person.session_token).not_to eq(person2.session_token)
      end
    end

    describe '#ensure_session_token' do
      it 'creates session token if there is none' do 
        p3 = User.create(username: 'jon', password_digest: '123456' )
        expect(p3.session_token).not_to be_falsey
      end
    end

  end
end
