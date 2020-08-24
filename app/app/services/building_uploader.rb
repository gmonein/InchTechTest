class BuildingUploader
  extend ActiveModel::Naming
  attr_reader :errors

  MANDATORY_KEYS = %w[reference address zip_code city country manager_name]

  def initialize
    @errors = ActiveModel::Errors.new(self)
  end

  def upload_csv(parsed_csv)
    keys = parsed_csv.delete_at(0)
    if keys.sort != MANDATORY_KEYS.sort
      self.errors.add(:csv, "Invalid keys, must be #{MANDATORY_KEYS.join(', ')}")
      return false
    end
    csv_hash = parsed_csv.map { |s| Hash[ keys.zip(a) ] }
    csv_hash.in_group_of(100) { |chunk| upload_persons_hash(chunk) }

    return true
  end

  def upload_persons_hash(person_hashes)
    person_hashes.map(&:symbolize_keys!)
    old_references = Building.where(reference: person_hashes.map { |s| s[:reference] }).pluck(:reference)

    # Separate new reference from old reference
    is_old_group = person_hashes.group_by do |person_hash|
      person_hash[:reference].in?(old_references)
    end
    
    # insert new references
    Building.create(is_old_group[false])
    return true unless is_old_group[true]

    old_hash_by_refs = is_old_group[true].group_by { |s| s[:reference] }
    # Load all updated people with all their archives
    olds = Building.where(reference: old_hash_by_refs.keys).include_attributes_archives
    olds.each do |old|
      old.no_repeat_update(old_hash_by_refs[old.reference].last) #assume that there is no reference duplication in csv
    end
  end
end
