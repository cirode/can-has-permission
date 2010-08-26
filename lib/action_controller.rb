module ActionController
  module Filters
    module ClassMethods
      def requires_permission(permission)
        before_filter lambda { |instance| 
          unless instance.send(:current_user).can?(permission)
            instance.send(:permission_denied, permission)
            return false
          end
        } 
      end
    end
  end
end