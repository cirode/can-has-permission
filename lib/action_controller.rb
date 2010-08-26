module ActionController
  module Filters
    module ClassMethods
      def requires_permission(permission)
        before_filter lambda { |instance| 
          instance.send(:permission_denied, permission) unless instance.send(:current_user).can?(permission)
        }
      end
    end
  end
end