require 'lims/core/labware/container'
require 'lims/core/labware/well'

module Lims::Core
  module Labware
    class Plate 
     include Container
     contains Well
    end
  end
end
