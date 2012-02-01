require 'common'
require 'lims/core/labware/receptacle.rb'

module Lims::Core
  module Labware
    # Piece of labware. 
    # Can have something in it and probably a label or something to identifiy it.
    class Tube
      include Receptacle
    end
  end
end
