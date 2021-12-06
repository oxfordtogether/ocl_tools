require "webpacker/helper"

module OclTools
  module ApplicationHelper
    include ::Webpacker::Helper

    def current_webpacker_instance
      OclTools.webpacker
    end

  end
end
