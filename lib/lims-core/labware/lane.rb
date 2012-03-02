require 'lims/core/labware/receptacle.rb'
require 'lims/core/resource'

module Lims::Core
  module Labware
    # A lane on a {Flowcell flowcell}.
    # Contains some chemical substances.
    class Lane
      include Receptacle

      def to_s()
        content.to_s
      end
    end
  end
end
