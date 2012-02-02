require 'lims/core/labware/container'
require 'lims/core/labware/well'

module Lims::Core
  module Labware
    # A plate is a plate as seen in a laboratory, .i.e
    # a rectangular bits of platics with wells and some 
    # readable labels on it.
    # TODO add label behavior
    class Plate 
     include Container
     contains Well
    end
  end
end
