require 'lims/core/labware/receptacle.rb'

class Flowcell
end
module Lims::Core

  module Labware
    # A lane on a {Flowcell flowcell}.
    # Contains some chemical substances.
    class Lane
      include Receptacle
      include Virtus
      attribute :flowcell, Flowcell, :writer => :protected
    end
  end
end
