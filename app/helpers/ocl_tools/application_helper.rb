module OclTools
  module ApplicationHelper
    def icon(name, options = {})
      file = File.read(OclTools::Engine.root.join("app", "icons", "#{name}.svg"))
      doc = Nokogiri::HTML::DocumentFragment.parse file
      svg = doc.at_css "svg"

      options.each { |attr, value| svg[attr.to_s] = value }

      doc.to_html.html_safe
    end
  end
end
