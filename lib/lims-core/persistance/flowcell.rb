# vi: ts=2:sts=2:et:sw=2 spell:spelllang=en


require 'lims/core/labware/flowcell'

module Lims::Core
  module Persistance
    # @abstract
    # Base for all Flowcell persistor.
    # Real implementation classes (e.g. Sequel::Flowcell) should
    # include the suitable persistor.
    class Flowcell
      Model = Labware::Flowcell

      # @abstract
      # Base for all Lane persistor.
      # Real implementation classes (e.g. Sequel::Lane) should
      # include the suitable persistor.
      class Lane
        Model = Labware::Flowcell::Lane
      end
    end
  end
end
