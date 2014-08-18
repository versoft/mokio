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
module Mokio
  class Youtube < DataFile
    include Mokio::Concerns::Models::Youtube
  end
end