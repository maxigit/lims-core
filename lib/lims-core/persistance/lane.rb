# vi: ts=2:sts=2:et:sw=2 spell:spelllang=en


require 'lims/core/labware/lane'

module Lims::Core
  module Persistance
    # @abstract
    # Base for all Lane persistor.
    # Real implementation classes (e.g. Sequel::Lane) should
    # include the suitable persistor.
    class Lane
      Model = Labware::Lane
      end
  end
end
