# vi: ts=2:sts=2:et:sw=2 spell:spelllang=en  
require 'common'

module Lims::Core
  module Labware
    # An aliquot represent the fraction of identical chemical substance inside a receptacle.
    # it should have:
    # 1. A receptacle
    # 1. A quantity  => volume, weight, moles?
    # 2. An owner (Order?)
    # 3. One or more constituents (sample, tags).
    # 4. A type/shape (gel, library, sample  etc...)
    # Constituents inside an aliquot are bound together, i.e. :
    # - "mixing" sample and tag in a tube without any processing will probably results
    # in a receptacle containing two aliquots, one representing the tag and the other
    # one the sample.
    # - "tagging" a sample with a tag will result in a receptacle containing one aliquot
    #   representing the tagged sample (the tag and the sample are bound together).
    # At the moment, rather than allowing an aliquot to have many constituents (in a free form way),
    # an aliquot can be formed of at least a {Labware::Sample sample}, a {Labware::Tag tag} and  or a {Labware::BaitLibrary bait library}.
    class Aliquot
    end
  end
end
