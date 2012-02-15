# vi: ts=2 sts=2 et sw=2 spell spelllang=en  
require 'common'
require 'lims/core/labware/aliquot'

require 'forwardable'

module Lims::Core
  module Labware
    # A Receptacle has a chemical content which is a set of {Labware::Aliquot aliquots}.
    # It can be seen (and used) as a Array of Aliquots (until a certain extend).
    # {include:Labware::Aliquot}
    module Receptacle

      def self.included(klass)
        klass.class_eval do
          include Virtus
          extend Forwardable
          # Return the chemical content of the receptacle
          # Ideally, it should be a set. However for performance reason
          # a simple array is enough (no hash to compute)
          # @return [Array<Labware::Aliquot>]
          attribute :content, Array[Aliquot], :default => [], :writer => :protected
          def_delegators :content, :each, :[], :<<, :size, :empty?, :include?

          def add(aliquots)
            #todo merge identical aliquots
            content.concat(aliquots)
          end

          # returns the total quantity of liquid present in the receptacle.
          # for liquid, this is the sum  of each aliquot.
          # @todo to be correct we need the actual quantity of water AND of chemical substance.
          # @return Float
          def quantity
            content.inject(0) { |q, a| q+a.quantity }
          end

          # Takes (removes) a specified amount of each aliquots (proportionally)
          # @param amount
          # @return [Array<Labware::Aliquot>]
          def take(amount=nil)
            # @todo : implement
            # take_fraction
            take_fraction(amount ? amount/quantity : 1.0)
          end

          # Takes (removes) a specified amount of each aliquots (proportionally)
          # @param [Float] f the fraction (between 0.0 and 1.0) of each aliquots to take.
          # @return [Array<Labware::Aliquot>]
          def take_fraction(f)
            content.map {|a| a.take_fraction(f) }
          end
        end
      end
    end
  end
end

