# == Schema Information
#
# Table name: contents
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  intro        :text
#  content      :text
#  type         :string(255)
#  home_page    :boolean
#  tpl          :string(255)
#  contact      :boolean
#  active       :boolean          default(TRUE)
#  lang_id      :integer
#  gallery_type :string(255)
#  editable     :boolean          default(TRUE)
#  deletable    :boolean          default(TRUE)
#  display_from :date
#  display_to   :date
#  created_at   :datetime
#  updated_at   :datetime
#  meta_id      :integer
#  gmap_id      :integer
#

class Content < ActiveRecord::Base
  include Mokio::Common::Model
  
  has_many :content_links
  has_many :data_files, :dependent => :destroy
  has_many :menus, :through => :content_links

  belongs_to :gmap, :dependent => :destroy  # Relation with gmap isn't necessary !
  belongs_to :meta, :dependent => :destroy

  mount_uploader :main_pic, Mokio::MainPicUploader

  accepts_nested_attributes_for :meta,       :allow_destroy => true
  accepts_nested_attributes_for :gmap,       :allow_destroy => true, :reject_if => lambda { |g| g[:full_address].blank? }
  accepts_nested_attributes_for :data_files, :allow_destroy => true, :reject_if => lambda { |d| d[:data_file].blank? }
  
  validates :title, presence: true
  validate :compare_dates  

  scope :lang,          -> (lang_id) { where('lang_id = ? or lang_id is null', lang_id) }
  scope :order_default, -> { order("seq asc") }
  scope :active,        -> { where(active: true) }
  scope :order_created, -> { reorder(nil).order('created_at DESC') }

  after_save :update_etag

  self.per_page = 15

  def update_etag
    self.touch(:etag)
  end

  def self.columns_for_table 
    %w(title active type updated_at lang_id)
  end

  def title_view
    html = ""
    html << "<span class=\"icon12 icomoon-icon-home home_page\"></span>" if self[:home_page]
    html << (ActionController::Base.helpers.link_to self[:title], ApplicationController.helpers.edit_url(self.class.base_class, self))
    html.html_safe
  end

  # @TODO - use gem for this
  def compare_dates
    if self[:display_from] && self[:display_to]
      if self[:display_from] > self[:display_to]
        errors.add(:display_from)
      end
    end
  end

  def type_view
    I18n.t("contents.types.#{self[:type]}")
  end
end
