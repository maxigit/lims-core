require 'lims-core/persistence/persistor'
require 'lims-core/persistence/persistable'
require 'modularity'

module Lims::Core
  module Persistence
    module PersistAssociationTrait
      as_trait do |parent_class=nil, args={}|
        model_name = name.split('::').last.snakecase
        session_name = "#{model_name}_persistor"
        parents = attributes.select { |a| a.options[:relation]  == :parent }
        children = attributes.select { |a| a.options[:relation]  == :child}
        parent_class.class_eval <<-EOC
          def #{model_name}
            @session.#{session_name}
          end
        EOC
        class_eval <<-EOC
        NOT_IN_ROOT = true
        SESSION_NAME = '#{session_name}'
        def initialize(*args)
          #{
            attributes.map do |att|
                "@#{att.name}=args.shift"
              end.join(';')
            }
            1
        end

        def keys
          [#{
              attributes.reject { |a| a.options[:exclude_from_key] }.map do |a|
                "@#{a.name}.object_id"
              end.join(', ')
            }]
        end

        def hash
          keys.hash
        end

        def eql?(other)
          keys == other.keys
        end

        does 'lims/core/persistence/persistable', :parents => [
          #{
            parents.map { |a| ":#{a.name}" }.join(', ')
            }
        ], :children => [
          #{
            children.map { |a| ":#{a.name}" }.join(', ')
            }
        ]

        class #{name.split('::').last}Persistor
          def new_from_attributes(attributes)
            args = [#{
              parents.map { |a| "@session.#{a.name}[attributes.delete(:#{a.name}_id)]" }.join(', ') 
            }]
          
            super(attributes) do 
              model.new(*args).tap { |m| m.on_load}
            end
          end
        end
        EOC

      end
    end
  end
end