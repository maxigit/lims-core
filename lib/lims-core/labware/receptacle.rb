# vi: ts=2 sts=2 et sw=2 spell spelllang=en  
require 'common'

module Lims::Core
  module Labware
    # A Receptacle has a chemical content which is a set of {Chemical::Aliquot aliquots}.
    # {include:Chemical::Aliquot}
    module Receptacle
      # Return the chemical content of the receptacle
      # @todo implemte or remove
      # @param
      # @return [Array<Chemical::Aliquot>]
      def content
        raise NotImplementedError
      end
    end
  end
end

