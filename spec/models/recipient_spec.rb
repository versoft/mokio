# frozen_string_literal: true

require 'spec_helper'

module Mokio
  RSpec.describe Recipient, type: :model do
    before do
      @contact = Contact.create!(title: 'test contact')
      @recipient = Recipient.new(
        email: 'recipient@example.com',
        contact_id: @contact.id
      )
    end

    it 'is valid with and email and a contact' do
      @recipient.valid?
      expect(@recipient).to be_valid
    end

    it 'is invalid without an email' do
      @recipient.email = nil
      @recipient.valid?
      expect(@recipient.errors[:email]).to include(
        'Proszę podać adres e-mail w poprawnym formacie'
      )
    end

    it 'is invalid in email in a wrong format' do
      @recipient.email = 'wrong format'
      @recipient.valid?
      expect(@recipient.errors[:email]).to include(
        'Proszę podać adres e-mail w poprawnym formacie'
      )
    end
  end
end
