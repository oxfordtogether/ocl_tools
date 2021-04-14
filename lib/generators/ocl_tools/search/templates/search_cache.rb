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
    value = People.all.sort_by(&:name).map { |p| [p.id, p.class.name, to_searchable_string(p)] }.to_json
    redis.set(KEY, value)
    value
  end

  def self.get_people_ids(query, limit: nil)
    people = JSON.parse(redis.get(KEY) || refresh)
    people_ids = people.filter { |_id, class_name, details| /#{normalize(query)}/i =~ details }.map { |id, class_name, _details| [id, class_name] }
    SearchResult.new(limit ? people_ids[0...limit] : people_ids, people_ids.length)
  end

  def self.get_people(query, limit: nil)
    result = get_people_ids(query, limit: limit)

    person_results = result.filter { |id, class_name| class_name == "Person" }.map { |id, class_name| id }

    SearchResult.new(
        Person.where(id: person_results.to_a ).all,
        result.total_count)
  end

  def self.to_searchable_string(person)
    normalize(person.name)
  end

  def self.normalize(string)
    string.gsub(/\s+/, "").downcase
  end
end
