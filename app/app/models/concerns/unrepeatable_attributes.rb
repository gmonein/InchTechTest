module UnrepeatableAttributes
  extend ActiveSupport::Concern

  included do
    cattr_reader :unrepeatable_attributes
    cattr_reader :archive_relations

    after_save :fill_archives
    scope :include_attributes_archives, -> { includes(archive_relations) }

    def self.set_unrepeatable_attributes(attributes)
      @@unrepeatable_attributes = attributes.map(&:to_sym)
      create_archives_classes
      create_relations
    end

    def no_repeat_update(new_hash)
      new_hash.symbolize_keys!
      @@unrepeatable_attributes.each do |attr|
        if self.send(:"person_#{attr}_archives").any? { |archive| archive.send(attr) == new_hash[attr] }
          new_hash[attr] = self.send(attr)
        end
      end
      return self.update!(new_hash) if new_hash != self.attributes.except('id', 'created_at', 'updated_at')
      true
    end


    private

    def fill_archives
      @@unrepeatable_attributes.each do |attr|
        archives = self.send(:"person_#{attr}_archives")
        unless archives.where({attr => self.send(attr)}).exists?
          archives.create!(attr => self.send(attr))
        end
      end

      true
    end

    def self.create_relations
      @@unrepeatable_attributes.each do |attr|
        rel_name = :"person_#{attr}_archives"
        self.has_many rel_name, dependent: :destroy
        @@archive_relations ||= []
        @@archive_relations << rel_name
      end

      true
    end

    def self.create_archives_classes
      @@unrepeatable_attributes.each do |attr|
        new_class = Class.new(ActiveRecord::Base)
        class_name = "#{self.to_s.underscore}_#{attr}_archive".camelize
        Object.const_set(class_name, new_class)
      end
    end
  end
end
