require_relative 'foreigner'

module Immigrant
  TEMPLATE = 'immigration.rb.erb'
  FOREIGN_KEY = :foreign_key

  class KeyFinder
    def qualified_reflection?(reflection, klass)
      scope = reflection.scope
      if scope.nil?
        false
      else
        klass.instance_exec(*([nil]*scope.arity), &scope).where_values.present?
      end
    rescue
      # if there's an error evaluating the scope block or whatever, just
      # err on the side of caution and assume there are conditions
      true
    end
  end
end
