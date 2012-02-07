require 'lims/core/labware/receptacle.rb'
module Lims::Core

  module Labware
    # A lane on a {Flowcell flowcell}.
    # Contains some chemical substances.
    class Lane
      include Receptacle
    end
  end
end
