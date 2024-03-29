#
# From Rails documentation:
#
# Engine model and controller classes can be extended by open classing them in the main Rails application
# (since model and controller classes are just Ruby classes that inherit Rails specific functionality).
# Open classing an Engine class redefines it for use in the main application. This is usually implemented by using the decorator pattern.
# For simple class modifications, use Class#class_eval. For complex class modifications, consider using ActiveSupport::Concern.
#
# ActiveSupport::Concern manages load order of interlinked dependent modules and classes at run time allowing you to significantly modularize your code.
#
# http://guides.rubyonrails.org/engines.html#overriding-models-and-controllers
#
# ==============================================================================

#
# Models
#
require "mokio/concerns/models/common"
require "mokio/concerns/models/content"
require "mokio/concerns/models/menu"
require "mokio/concerns/models/article"
require "mokio/concerns/models/available_module"
require "mokio/concerns/models/contact"
require "mokio/concerns/models/contact_template"
require "mokio/concerns/models/content_link"
require "mokio/concerns/models/data_file"
require "mokio/concerns/models/gmap"
require "mokio/concerns/models/lang"
require "mokio/concerns/models/mailer"
require "mokio/concerns/models/module_position"
require "mokio/concerns/models/mov_gallery"
require "mokio/concerns/models/photo"
require "mokio/concerns/models/pic_gallery"
require "mokio/concerns/models/recipient"
require "mokio/concerns/models/selected_module"
require "mokio/concerns/models/static_module"
require "mokio/concerns/models/user"
require "mokio/concerns/models/youtube"
require "mokio/concerns/models/external_script"
require "mokio/concerns/models/seo_tag"
require "mokio/concerns/models/history"
require "mokio/concerns/models/backend_search"
require "mokio/concerns/models/static_page"
require "mokio/concerns/models/editable_block"
require "mokio/concerns/models/application_setting"
require "mokio/concerns/models/application_settings_group"

#
# CommonController extensions
#
require "mokio/concerns/common/controller_object"
require "mokio/concerns/common/controller_functions"
require "mokio/concerns/common/controller_translations"
require "mokio/concerns/common/seo_tags"
require "mokio/concerns/common/services/sitemap_service"
require "mokio/concerns/common/services/get_cke_files"
require "mokio/concerns/common/history"

#Helpers:
require "mokio/headers_helper"
require "mokio/sluglize"

# Uploader
require "mokio/uploader/cke_uploader"

#
# Services
require "mokio/services/recaptcha_service"
require "mokio/services/static_page_service"
require "mokio/services/find_app_setting"
#

require "mokio/frontend_editor/editor_panel"
require "mokio/frontend_editor/edit_panel"
require "mokio/frontend_editor/editor_field"

#
# Controllers
#
require "mokio/concerns/controllers/application"
require "mokio/concerns/controllers/articles"
require "mokio/concerns/controllers/base"
require "mokio/concerns/controllers/common"
require "mokio/concerns/controllers/contacts"
require "mokio/concerns/controllers/contents"
require "mokio/concerns/controllers/dashboard"
require "mokio/concerns/controllers/data_files"
require "mokio/concerns/controllers/menus"
require "mokio/concerns/controllers/mov_galleries"
require "mokio/concerns/controllers/photos"
require "mokio/concerns/controllers/pic_galleries"
require "mokio/concerns/controllers/static_modules"
require "mokio/concerns/controllers/users"
require "mokio/concerns/controllers/youtubes"
require "mokio/concerns/controllers/external_scripts"
require "mokio/concerns/controllers/module_positions"
require "mokio/concerns/controllers/langs"
require "mokio/concerns/controllers/main_pics"
require "mokio/concerns/controllers/sessions"
require "mokio/concerns/controllers/histories"
require "mokio/concerns/controllers/backend_search"
require "mokio/concerns/controllers/static_pages"
require "mokio/concerns/controllers/editable_blocks"
require "mokio/concerns/controllers/cke_file_browser"
