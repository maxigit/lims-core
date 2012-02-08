#vi: ts=2 sw=2 et
require 'lims/core/labware/plate.rb'
require 'lims/core/labware/tube.rb'
require 'lims/core/labware/flowcell.rb'

require 'lims/core/labware/aliquot'
require 'lims/core/labware/sample'
require 'lims/core/labware/tag'

module Lims::Core
  # Things used/found in the lab. Includes pure labware (inert things as {Plate plates}, {Tube tubes})
  # and chemical one (as {Aliquot aliquots}, {Sample samples}).
  module Labware
  end
end
