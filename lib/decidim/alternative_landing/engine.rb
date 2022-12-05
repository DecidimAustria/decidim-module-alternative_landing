# frozen_string_literal: true

require "rails"
require "decidim/core"

require_relative "content_blocks/content_blocks_process_group"
require_relative "content_blocks/content_blocks_shared"

module Decidim
  module AlternativeLanding
    # This is the engine that runs on the public interface of alternative_landing.
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::AlternativeLanding

      config.to_prepare do
        Decidim::HomepageController.include(Decidim::AlternativeLanding::NeedsContentBlocksSnippets)
        Decidim::ParticipatoryProcesses::ParticipatoryProcessGroupsController.include(Decidim::AlternativeLanding::NeedsContentBlocksSnippets)
      end

      initializer "decidim_alternative_landing.snippets" do |app|
        app.config.enable_html_header_snippets = true
      end

      initializer "decidim_alternative_landing.add_cells_view_paths" do
        Cell::ViewModel.view_paths << File.expand_path("#{Decidim::AlternativeLanding::Engine.root}/app/cells")
        Cell::ViewModel.view_paths << File.expand_path("#{Decidim::AlternativeLanding::Engine.root}/app/views")
      end

      initialize_process_group_content_blocks
    end
  end
end
