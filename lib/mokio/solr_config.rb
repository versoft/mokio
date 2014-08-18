module Mokio
  module SolrConfig #:nodoc:
    #
    # Enable/Disable using solr
    #
    mattr_accessor :enabled
    self.enabled = false

    #
    # Classes which are excluded from indexing or have own searchable method
    #
    mattr_accessor :exceptions
    self.exceptions = [ :menu, :user ]
  end
end