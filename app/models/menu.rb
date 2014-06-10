# == Schema Information
#
# Table name: menus
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  active           :boolean          default(TRUE)
#  seq              :integer
#  target           :string(255)
#  external_link    :string(255)
#  lang_id          :integer
#  editable         :boolean          default(TRUE)
#  deletable        :boolean          default(TRUE)
#  visible          :boolean          default(TRUE)
#  position_id      :integer
#  ancestry         :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  description      :string(255)
#  content_editable :boolean          default(TRUE)
#  modules_editable :boolean          default(TRUE)
#  fake             :boolean          default(FALSE)
#  meta_id          :integer
#  slug             :string(255)
#

class Menu < ActiveRecord::Base
  include Mokio::SolrConfig
  include Mokio::Common::Model
  
  extend FriendlyId
  
  friendly_id :slug_candidates, use: :slugged

  has_ancestry :orphan_strategy => :adopt

  validates :name, presence: true
  validates :lang_id, presence: true
  validates_uniqueness_of :slug
  # before_validation :lang_matches_parent

  belongs_to :lang
  belongs_to :meta
  
  has_many :content_links,     -> {order('content_links.seq')}
  has_many :contents,          -> {order('content_links.seq')},    :through => :content_links
  has_many :selected_modules,  -> {order('selected_modules.seq')}
  has_many :available_modules, -> {order('selected_modules.seq')}, :through => :selected_modules

  accepts_nested_attributes_for :contents, :available_modules
  accepts_nested_attributes_for :meta

  before_save :seq_and_lang_update

  after_save :touch_content
  after_destroy :touch_content

  scope :order_default, -> { order("seq asc") }
  scope :active,        -> { where(active: true) }

  def slug_candidates
    [:name]
  end

  def seq_and_lang_update
    self.seq = sequence_number
    if self.lang_id.nil?
       self.lang_id = root.lang_id
    else
      self.lang_id = self.root.lang_id
    end
  end

  #
  # returns list of contents available for assignment to given menu element (based on lang_id)
  #
  def available_contents
    if (lang_id.nil? || lang_id == 0) 
      Content.lang(Lang.default.id) - contents
    else
      Content.lang(lang_id) - contents
    end
  end

  def parent_root
    root = Menu.find(lang_id) unless lang_id.nil?
    root = Menu.find(Lang.default.id) if root.nil?
    root
  end

  def parent_tree
    tree = parent_root.subtree
    tree.to_a.delete(self)
    tree
  end

  #
  # returns list of selected modules divided by positions
  #
  def selected_modules_by_pos
    # AvailableModule.selected_for_menu(id).group_by(&:module_position_id)
    (self.available_modules + AvailableModule.always_displayed).uniq.group_by(&:module_position_id)
  end

  #
  # returns list of static modules available for assignment to given menu menu element - divided per positions
  #
  def available_modules_by_pos
    menu_id = (self.id.nil? ? -1 : self.id)
    if (lang_id.nil? || lang_id == 0)
      AvailableModule.not_selected_for_menu(menu_id).for_lang(Lang.default.id).group_by(&:module_position_id)
    else
      AvailableModule.not_selected_for_menu(menu_id).for_lang(lang_id).group_by(&:module_position_id) 
    end
  end

  def sequence_number 
    if seq.nil?
      if parent.nil?
        Menu.where('ancestry is null').count +1
      else
        max = parent.children.maximum(:seq)
        max.nil? ? 1 : max + 1
      end
    else
      seq
    end
  end

  #
  # checks if menu has any non-active or non-visible content assigned
  #
  def invisible_content
    contents.each do |content|
      if !content.active or !content.displayed?
        return true
      end
    end
    false
  end

  def content_type
    if (contents.length > 1)
      I18n.t('menus.list').titleize
    elsif (contents.length == 1)
      I18n.t(contents[0].type.underscore).titleize
    elsif (!external_link.blank?)
      I18n.t('external_link', Menu).titleize
    else
      ''
    end
  end

  def always_editable_fields
    @always = %w(active seq visible always_displayed ancestry)
    @always << 'contents' if self.content_editable
    @always << 'available_modules' if self.modules_editable
    @always
  end

  def title
    self.name
  end

  if Mokio::SolrConfig.enabled
    ## For Sunspot Solr:
      searchable do ## Columns where Sunspot knows which data use to index
        text :name
      end
    ##
  end

  def content
    self.contents.active.first
  end

  def touch_content
    Content.all.each do |c|
      c.touch(:etag)
    end
  end

  def one_content?
    self.contents.count == 1
  end

  def many_contents?
    self.contents.count > 1
  end

  def linked_content_type
    return nil unless self.contents

    type = ""
    self.contents.each_with_index do |content, i|
      if i == 0
        type = content.type
      else
        return "mixed_content" if type != content.type
        type = content.type
      end
    end

    type.tableize
  end
end

