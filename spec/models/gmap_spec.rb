# frozen_string_literal: true

require 'spec_helper'

module Mokio
  RSpec.describe Gmap, type: :model do
    before do
      @gmap = Gmap.new(
        full_address: 'Plaża Miejska Olsztyn',
        lat: 53.7767345,
        lng: 20.4456407
      )
    end

    it 'is valid with address, latitude and longitude' do
      expect(@gmap).to be_valid
    end

    it 'is invalid without address' do
      @gmap.full_address = nil
      @gmap.valid?
      expect(@gmap.errors[:full_address]).to(
        include 'Adres nie może byc pusty'
      )
    end

    it 'is invalid without latitude' do
      @gmap.lat = nil
      @gmap.valid?
      expect(@gmap.errors[:lat]).to(
        include 'Szerokość geograficzna nie może byc pusta'
      )
    end

    it 'is invalid without longitude' do
      @gmap.lng = nil
      @gmap.valid?
      expect(@gmap.errors[:lng]).to(
        include 'Długość geograficzna nie może byc pusta'
      )
    end
  end
end
