require 'lims/core/labware/container'
require 'lims/core/labware/lane'

module Lims::Core
  module Labware
    # A flowcell with some lanes.
    # readable labels on it.
    # TODO add label behavior
    class Flowcell
     include Container
     contains Lane
    end
  end
end
