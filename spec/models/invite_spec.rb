require 'spec_helper'

describe Invite do
    let(:ada) { User.create(first_name: "Ada", last_name: "Lovelace", email: "ada@wwwww.com", password: "programingrocks1")}
    let(:bob) { User.create(first_name: "Bob", last_name: "Lovelace", email: "b@yyyyy.com", password: "programingrocks1")}
    let(:pantry) { Pantry.create(name: "Pantry!", creator: bob)}
    let(:invite) { Invite.create(email: ada.email, pantry_id: pantry.id, sender: bob, recipient: ada, token: "asdf")}
    
    context 'validations' do
      it "should have a name" do
        expect(invite).to have_db_column :email
        expect(invite).to have_db_column :pantry_id
        expect(invite).to have_db_column :sender_id
        expect(invite).to have_db_column :recipient_id
        expect(invite).to have_db_column :token
      end

    it 'should validate presence of email' do
        expect(invite).to validate_presence_of :email
    end

    it 'should validate presence of pantry id' do
        expect(invite).to validate_presence_of :pantry
    end

    it 'should validate presence of sender id' do
        expect(invite).to validate_presence_of :sender
    end


    context 'associations' do
      it { should belong_to(:pantry) }
      it { should belong_to(:sender) }
      it { should belong_to(:recipient) }
    end

    describe ".set_recipient_id" do
      it "if users with the invite's email already exits, it should set the recipient id to that user id" do
        invite.set_recipient_id
        expect(invite.recipient_id).to be(ada.id)
      end
    end

    describe ".is_a_user?" do
      it "should return true if the recipient already exits" do
        expect(invite.is_a_user?).to be_true
      end
    end

    describe ".sort_n_send" do
      it "if the user exists to send an email" do
        expect(invite.sort_n_send).to be_true
      end
    end
  end

end
