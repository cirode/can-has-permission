class CanHasPermission::Role < ActiveRecord::Base
  include CanHasPermission
  validates_presence_of :name
  validates_uniqueness_of :name
end