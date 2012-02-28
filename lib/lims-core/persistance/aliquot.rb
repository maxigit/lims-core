# vi: ts=2:sts=2:et:sw=2 spell:spelllang=en


require 'lims/core/labware/aliquot'

module Lims::Core
  module Persistance
    # @abstract
    # Base for all Aliquot persistor.
    # Real implementation classes (e.g. Sequel::Aliquot) should
    # include the suitable persistor.
    class Aliquot
      Model = Labware::Aliquot
      end
  end
end