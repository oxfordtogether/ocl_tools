module OclTools
  class SearchGenerator < Rails::Generators::NamedBase
    source_root File.expand_path("templates", __dir__)

    def create
      copy_file "search_reflex.rb", "app/reflexes/search_reflex.rb"
      copy_file "application_reflex.rb", "app/reflexes/application_reflex.rb"

      copy_file "search_cache.rb", "app/interactors/search_cache.rb"
      copy_file "search_cache_refresh.rb", "app/workers/search_cache_refresh.rb"
    end
  end
end
