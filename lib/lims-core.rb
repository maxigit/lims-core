# vi: spell:spelllang=en ts=2:sts=2:sw=2:et
require "lims-core/version"

require 'lims/core/action'
require 'lims/core/labware'
require 'lims/core/organization'

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
  # 5. {Organization}
  #    Related to {User users}, data release ({Study}) and ordering ({Order}) and funding ({Project}) etc.
  # 5. {Auditing?} _*to validate*_ :
  #    What changed in the database  (low level).
  # 6. {Tracking} :
  #    What happened in the lab.
  # 10. {Action}
  #    What people can do on things.
  #
  # This partition is more for clarity/documentation purposes and it's not meant to be really tight. 
  # However it's more likely than the submodules dependency will be a tree than a graph, (but it's not a necessity).   
  module Core
    # Your code goes here...
  end
end
