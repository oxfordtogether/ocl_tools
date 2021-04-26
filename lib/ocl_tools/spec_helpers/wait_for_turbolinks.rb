module OclTools
  module WaitForTurbolinks
    # https://stackoverflow.com/a/59938460
    def wait_for_turbolinks(timeout = nil)
      has_no_css?(".turbolinks-progress-bar", wait: timeout.presence || 5.seconds) if has_css?(".turbolinks-progress-bar", visible: true, wait: 0.25.seconds)
    end
  end
end
