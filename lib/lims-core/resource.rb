# vi: ts=2 sts=2 et sw=2 spell spelllang=en  
require 'common'

module Lims::Core
  module Resource
    def self.included(klass)
      klass.class_eval do
        include Virtus
        extend Forwardable

        def self.is_array_of(child_klass, options = {},  &initializer)
            define_method :initialize do |*args, &block|
              @content = initializer ? initializer[self, child_klass] : []
              super(*args, &block)
            end

          class_eval do

            # Add content to compare
            def ==(other)
              super(other) && other.respond_to?(:content) && content == other.content
            end

            def content
              @content 
            end

            def_delegators :@content, :each, :size , :each_with_index, :map, :zip
            def [](i)
              case i
              when Integer then self.content[i]
              else super(i)
              end
            end

            # iterate only between non empty lanes.
            # @yield [content]
            # @return itself
            def each_content
              @content.each do |content|
                yield content if content
              end
            end
          end 
        end
      end
    end

    # Compare 2 resources.
    # They are == if they have the same values (attributes),
    # regardless they are the same ruby object or not.
    # @param other
    # @return [Boolean]
    def ==(other)
      self.attributes == other.attributes
    end
  end
end
