require 'lims/core/labware/receptacle.rb'
require 'lims/core/resource'

class Flowcell
end
module Lims::Core

  module Labware
    # A lane on a {Flowcell flowcell}.
    # Contains some chemical substances.
    class Lane
      include Resource
      include Receptacle
      attribute :flowcell, Flowcell, :writer => :protected
    end
  end
end
