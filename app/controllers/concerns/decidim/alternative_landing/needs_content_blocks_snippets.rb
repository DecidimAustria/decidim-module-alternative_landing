# frozen_string_literal: true

require "active_support/concern"

module Decidim
  module AlternativeLanding
    module NeedsContentBlocksSnippets
      extend ActiveSupport::Concern

      included do
        helper_method :snippets
      end

      def snippets
        return @snippets if @snippets

        @snippets = Decidim::Snippets.new

        @snippets.add(:head, @snippets.for(:alternative_landing))

        @snippets
      end
    end
  end
end
