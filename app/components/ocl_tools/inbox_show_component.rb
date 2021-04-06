module OclTools
  class InboxShowComponent < ViewComponent::Base
    delegate :icon, to: :helpers
    with_content_areas :body, :right_aligned_actions

    def initialize(current_index:, total:, back_path:, prev_path:, next_path:)
      @current_index = current_index
      @total = total
      @back_path = back_path
      @prev_path = prev_path
      @next_path = next_path
    end

    attr_reader :current_index, :total, :back_path, :prev_path, :next_path
  end
end
