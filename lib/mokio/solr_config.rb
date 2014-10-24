module Mokio
  module SolrConfig #:nodoc:
    #
    # Enable/Disable using solr
    #
    mattr_accessor :enabled
    self.enabled = false

    def self.all_exceptions
      self.mokio_exceptions + self.exceptions
    end

    #
    # Application classes which are excluded from indexing or have own searchable method
    #
    mattr_accessor :exceptions

    private
    #
    # Mokio classes which are excluded from indexing or have own searchable method
    #
    def self.mokio_exceptions
      [
          :menu, :user, :externalscript, :lang
      ]
    end

  end
end