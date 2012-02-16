require 'lims/core/labware/container'
require 'lims/core/labware/lane'

require 'forwardable'

module Lims::Core
  module Labware
    # A flowcell with some lanes.
    # readable labels on it.
    # TODO add label behavior
    class Flowcell
     #include Container
     #contains Lane

     include Virtus
          extend Forwardable
     attribute :content, Array[Lane], :default => lambda { |f,a| 8.times.map { l=a.member_type.new; l.send(:flowcell=, f); l }}, :writer => :protected
     def_delegators :content, :each, :size , :each_with_index

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
       content.each do |content|
         yield content if content
       end
     end
    end
  end
end
