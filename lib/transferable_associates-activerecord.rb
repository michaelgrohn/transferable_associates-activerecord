require "transferable_associates-activerecord/version"

module TransferableAssociates
  
  module Activerecord

    VERSION = "0.0.1"

    def self.included(base)
      class << base
        alias_method :original_belongs_to, :belongs_to
        #alias_method :original_has_one, :has_one
        alias_method :original_has_many, :has_many
        #alias_method :original_has_and_belongs_to_many, :has_and_belongs_to_many
        #alias_method :original_initialize, :initialize
      end
      base.send :extend,  ClassMethods
      #base.send :include, InstanceMethods
    end

    module ClassMethods

      def belongs_to(associate, options = {})

        original_belongs_to(associate, options)

        define_method :belongs_to? do |owner|
          associate = owner.class.to_s.downcase.to_sym # <Cache: "super-cache"> => :cache
          self.send(associate) == owner
        end

        define_method :assign_to do |owner|
          set_associate = (owner.class.to_s.downcase + '=').to_sym # <Cache: "super-cache"> => :cache=
          self.send(set_associate, owner)
        end
      end

      def has_many(associate, options = {}, &extension)

        original_has_many(associate, options, &extension)

        define_method :has? do |obj|
          obj.belongs_to?(self)
        end

        define_method :can_take? do |obj|
          associate.to_s.singularize == obj.class.to_s.downcase
        end

        define_method :give, ->(obj, opts = {}) do
          if has? obj
            obj.assign_to opts[:to]
          end
        end

        define_method :give!, ->(object, options = {}) do
          self.give(object, options) && object.save
        end

        define_method :take do |obj|
          #if can_take?(obj)
            obj.assign_to self
          #end
        end
      end
    end

    #module InstanceMethods
      def belongs_to? (obj)
        false
      end

      def has? (obj)
        false
      end
    #end

  end
end

ActiveRecord::Base.send(:include, TransferableAssociates)
