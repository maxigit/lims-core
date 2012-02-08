# vi: ts=2 sts=2 et sw=2 spell spelllang=en  
require 'common'

module Lims::Core
  module Labware
    # A Receptacle has a chemical content which is a set of {Labware::Aliquot aliquots}.
    # {include:Labware::Aliquot}
    module Receptacle
      # Return the chemical content of the receptacle
      # @todo implemte or remove
      # @param
      # @return [Array<Labware::Aliquot>]
      def content
        raise NotImplementedError
      end
    end
  end
end

