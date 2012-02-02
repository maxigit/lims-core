require 'lims/core/labware/receptacle.rb'
module Lims::Core

  module Labware
    # The well of a {Plate}. 
    # Contains some chemical substances.
    class Well
      include Receptacle
    end
  end
end
