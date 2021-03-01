class SearchResult
  include Enumerable
  def initialize(records, total_count = nil)
    @records = records
    @total_count = total_count
  end

  attr_reader :records, :total_count

  delegate :each, to: :records
  delegate :length, to: :records
end

class SearchCache
  KEY = "search_cache_#{Rails.env}".freeze

  def self.redis
    @@redis ||= Redis.new
  end

  def self.refresh
    value = Person.all.sort_by(&:name).map { |p| [p.id, to_searchable_string(p)] }.to_json
    redis.set(KEY, value)
    value
  end

  def self.get_people_ids(query, limit: nil)
    people = JSON.parse(redis.get(KEY) || refresh)
    people_ids = people.filter { |_id, details| /#{normalize(query)}/i =~ details }.map { |id, _details| id }
    SearchResult.new(limit ? people_ids[0...limit] : people_ids, people_ids.length)
  end

  # TODO: limit/total_count is a bit broken, as it's a limit/total_count on the people not the roles
  def self.get_roles(query, limit: nil)
    people_ids = get_people_ids(query, limit: limit)
    roles = Person.where(id: people_ids.to_a).with_roles.flat_map(&:roles)
    SearchResult.new(roles, people_ids.total_count)
  end

  def self.get_people(query, limit: nil)
    result = get_people_ids(query, limit: limit)
    SearchResult.new(Person.where(id: result.to_a).all, result.total_count)
  end

  def self.to_searchable_string(person)
    # configure, e.g. if you want to be able to search by DoB as well
    normalize(person.name)
  end

  def self.normalize(string)
    string.gsub(/\s+/, "").downcase
  end
end
