# == Schema Information
#
# Table name: content_links
#
#  content_id :integer
#  menu_id    :integer
#  seq        :integer
#  id         :integer          not null, primary key
#
module Mokio
  class ContentLink < ActiveRecord::Base
    include Mokio::Concerns::Models::ContentLink
  end
end