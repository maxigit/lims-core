module Lims::Core
  module Labware
    # A Receptacle has a chemical content. 
    module Receptacle
      # Return the chemical content of the receptacle
      # @todo implemte or remove
      # @param
      # @return Content
      def content
        raise NotImplementedError
      end
    end
  end
end

