# == Schema Information
#
# Table name: data_files
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  data_file          :string(255)
#  download_count     :integer          default(0)
#  seq                :integer
#  type               :string(255)
#  active             :boolean          default(TRUE)
#  movie_url          :string(255)
#  external_link      :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  content_id         :integer
#  thumb              :string(255)      default("0")
#  intro              :text
#  subtitle           :string(255)
#  thumb_external_url :string(255)
#  slug               :string(255)
#
include Mokio

class DataFile < ActiveRecord::Base
  extend FriendlyId

  friendly_id :name, use: :slugged

  belongs_to :contents, :touch => true
  
  mount_uploader :data_file, Mokio::DataFileUploader
  mount_uploader :thumb, Mokio::ThumbUploader

  scope :active,        ->     { where(active: true) }
  scope :order_default, ->     { order("seq asc") }

  #
  # For some reason touch => true does not work for DataFile :(
  #
  after_save :touch_content
  after_destroy :touch_content
  after_touch :touch_content

  before_create :default_name
  before_save :change_slug

  def change_slug
    self.slug = self.name.parameterize unless self.name.blank?
  end

  def default_name
    self.name ||= File.basename(data_file.filename, '.*').titleize if data_file.filename && !self.name
  end

  def name_underscored
    self.name.gsub(' ', '_')
  end

  def touch_content
    Content.find(self.content_id).touch(:etag)
  end

  def slide?
    false
  end
end
