module Mokio
	module Exceptions
    #
    # Mokio standard error class
    #
		class MokioError < StandardError
			#
			# Exception message
			#
			attr_accessor :message

      #
      # Constructs default MokioError
      #
      # ==== Attributes
      #
      # * +message+ - Message to display in exception
      #
			def initialize(message = nil)
				@message = message
			end

      #
      # Ruby uses to_s method to display exception object's message
      #
			def to_s
				"[Mokio Exception] " + @message
			end
		end

    #
    # Exception used when specified menu object wasn't root
    #
		class IsNotMenuRootError < Exceptions::MokioError
			# Given id if type == :id
			attr_accessor :id 

			# Given name if type == :name
			attr_accessor :name

			# How you search for root
			attr_accessor :type

      #
      # Constructs a IsNotMenuRootError exception
      #
      # ==== Attributes
      #
      # * +type+ - How you search for root
      # * +arg+  - Searching argument
      #
			def initialize(type = :id, arg = nil)
				@type    = type
				@message = "Cannot find Menu root for #{type.to_s} = #{arg}"

				@id   = arg if type == :id
				@name = arg if type == :name
			end

      #
      # Retruns Mokio::Menu object for id or name given to exception
      #
			def obj
				@id ? Mokio::Menu.find(@id) : Mokio::Menu.find_by_name(@name)
			end
		end

    #
    # "Abstract" class, just for inheritance
    #
		class IsNotObj < Exceptions::MokioError
			# Object passed to exception
			attr_accessor :obj

      def initialize #:nodoc:
        raise NotImplementedError.new "Constructor must be implemented!"
      end
		end

    #
    # Exception used when given object was not Mokio::Content type
    #
		class IsNotAMokioContentError < Exceptions::IsNotObj
      #
      # Constructs a IsNotAMokioContentError exception
      #
      # ==== Attributes
      #
      # * +obj+ - Some obj you are checking
      #
			def initialize(obj)
				@message = "#{obj} is not a Mokio::Content object"
				@obj 		 = obj
			end
		end

    #
    # Exception used when given object was not Mokio::Menu type
    #
		class IsNotAMokioMenuError < Exceptions::IsNotObj
      #
      # Constructs a IsNotAMokioMenuError exception
      #
      # ==== Attributes
      #
      # * +obj+ - Some obj you are checking
      #
			def initialize(obj)
				@message = "#{obj} is not a Mokio::Menu object"	
				@obj 		 = obj
			end		
		end
	end
end