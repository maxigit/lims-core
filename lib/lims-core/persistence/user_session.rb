# vi: ts=2:sts=2:et:sw=2 spell:spelllang=en
require 'common'

require 'lims-core/resource'
require 'lims-core/persistence/resource_state'

module Lims::Core
  module Persistence
    # This should be a read-only class used
    # to retrieve information related to specific
    # session. Each time a user creates a writable session
    # The `session` table is updated (via trigger).
    # This class is to read this table.
    # It also allows the user to load an object
    # as it was at a specific time (through the underlying session)
    # In the contrary of other resource, the session id
    # is part of a UserSession attribute. That is required
    # by the underlying session.
    class UserSession
      include Resource
      attribute :id, Object
      attribute :user, String
      attribute :backend_application_id, String
      attribute :parameters, Object
      attribute :success, Boolean
      attribute :start_time, Time
      attribute :end_time, Time
      attribute :parent_session, Session, :writer => :private, :initializable => true

      def session
        return parent_session
        raise NotImplementedError, "session method not implemented for #{self.class}"
      end

      # Returns a list of ResourceState corresponding to all the
      # resources directly modified by this session.
      # Resources depending on a modified resource
      # which haven't been modified themself won't be return.
      # For this see @collect_related_states
      # For example if an aliquot of a plate has been modified,
      # only this aliquot will be returned. The plate won't be returned
      # even though it has been modified indirectly
      # @return [StateList]
      def collect_direct_states()
        session.user_session.collect_direct_states
        raise NotImplementedError, "collect_direct_states method not implemented for #{self.class}"
      end

      # Returns a list of ResourceState corresponding to all
      # resources directly or indirectly modified by this session.
      # Example, if an aliquot of a plate has been modified by this session
      # The plate, and the aliquot will be returned.
      def collect_related_states()
        session.user_session.collect_related_states
        raise NotImplementedError, "collect_all_states method not implemented for #{self.class}"
      end

      def method_missing(*args, &block)
        session.public_send(*args, &block)
      end
    end
  end
end

