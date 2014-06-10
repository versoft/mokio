# == Schema Information
#
# Table name: content_links
#
#  content_id :integer
#  menu_id    :integer
#  seq        :integer
#  id         :integer          not null, primary key
#

class ContentLink < ActiveRecord::Base
  default_scope { order('seq') }
  belongs_to :menu, :touch => true
  belongs_to :content, :touch => :etag
  acts_as_list :column => :seq, :scope => :menu_id
end
