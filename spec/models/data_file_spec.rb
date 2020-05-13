# frozen_string_literal: true

require 'spec_helper'

module Mokio
  describe DataFile do
    it 'is valid' do
      datafile = DataFile.create!
      datafile.valid?
      expect(data_file).to be_valid
    end
  end
end
