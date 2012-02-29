require 'lims/core/labware/container'
require 'lims/core/labware/lane'
require 'lims/core/resource'

module Lims::Core
  module Labware
    # A flowcell with some lanes.
    # readable labels on it.
    # TODO add label behavior
    class Flowcell
     #include Container
     #contains Lane
      include Resource
      is_array_of Lane do |f,t|
        8.times.map { l=t.new; l.send(:flowcell=, f); l }
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
