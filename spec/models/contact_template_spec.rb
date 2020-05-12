# frozen_string_literal: true

require 'spec_helper'

module Mokio
  RSpec.describe ContactTemplate, type: :model do
    it 'is valid with a contact' do
      contact = Contact.create!(title: 'test contact')
      contact_template = ContactTemplate.new(
        contact_id: contact.id
      )
      contact_template.valid?
      expect(contact_template).to be_valid
    end

    it 'returns an array of attributes' do
      attributes = ContactTemplate.contact_template_attributes
      expect(attributes).to eq([:tpl])
    end
  end
end
