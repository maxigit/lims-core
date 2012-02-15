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
     attribute :content, Array[Lane], :default => lambda { |c,a| 8.times.map { a.member_type.new }}, :writer => :protected
     def_delegators :content, :each, :[], :size 

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
