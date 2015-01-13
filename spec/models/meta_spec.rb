# == Schema Information
#
# Table name: meta
#
#  id                 :integer          not null, primary key
#  g_title            :string(255)
#  g_desc             :string(255)
#  g_keywords         :string(255)
#  g_author           :string(255)
#  g_copyright        :string(255)
#  g_application_name :string(255)
#  f_title            :string(255)
#  f_type             :string(255)
#  f_image            :string(255)
#  f_url              :string(255)
#  f_desc             :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#

require 'spec_helper'
module Mokio
  describe Meta do
    pending "add some examples to (or delete) #{__FILE__}"
  end
end