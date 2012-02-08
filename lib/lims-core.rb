# vi: spell:spelllang=en ts=2:sts=2:sw=2:et
require "lims-core/version"

require 'lims/core/action'
require 'lims/core/labware'
require 'lims/core/data_release'
require 'lims/core/funding'
require 'lims/core/ordering'


# LIMS stands for Laboratory Information Management System.
# A namespace.
module Lims
  # The Core of the {Lims LIM S}ystem.
  # Includes the basic classes corresponding to the :  
  # 1. domain(s)
  # 2. Persistance Layer
  # 3. Business Logic layer (extension ?)
  #
  # The Core is split in the following submodule/namespace :
  # 1. {Labware} :
  #    Things used/found in the lab. Includes pure labware (inert things as {Plate plates}, {Tube tubes})
  #    and chemical one (as {Aliquot aliquots}, {Sample samples}.
  # 3. {LabProcess}
  #    Related to the work people/robot do in the laboratories.
  # 4. {Ordering} :
  #    What people do to ask something to be done.
  # 5. {Auditing?} _*to validate*_ :
  #    What changed in the database  (low level).
  # 6. {Tracking} :
  #    What happenened in the lab.
  # 7. {DataRelease}
  #    Releasing data to the outside world.
  # 9. {Funding}
  #    Related to billing and cost.
  # 10. {Action}
  #    What people can do on things.
  #
  # This partition is more for clarity/documentation purposes and it's not meant to be really tight. 
  # However it's more likely than the submodules dependency will be a tree than a graph, (but it's not a necessity).   
  module Core
    # Your code goes here...
  end
end
