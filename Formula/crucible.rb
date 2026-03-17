# typed: false
# frozen_string_literal: true

class Crucible < Formula
  desc "Pipeline execution engine for Claude Code (MCP server)"
  homepage "https://github.com/centient-labs/crucible"
  version "0.29.1"
  # license - TBD

  # Currently only macOS ARM64 (Apple Silicon) is supported
  depends_on :macos
  depends_on arch: :arm64

  url "https://github.com/centient-labs/homebrew-crucible/releases/download/v#{version}/crucible-macos-arm64.tar.gz"
  # SHA256 is injected by .github/workflows/release.yml at release time.
  # The placeholder value causes Homebrew to reject pre-release installs.
  sha256 "c8c1325f86583e5d69e81c36242cf70e14ee168bd692c0d498cfd768f420ad29"

  def install
    bin.install "crucible"

    # Install command templates to share directory
    # setup.ts searches: /opt/homebrew/share/crucible/templates/commands
    if File.directory?("templates/commands")
      (share/"crucible"/"templates"/"commands").install Dir["templates/commands/*.md"]
    end

    # Install includes (API reference, supervisor preamble)
    # setup.ts searches: /opt/homebrew/share/crucible/templates/includes
    if File.directory?("templates/includes")
      (share/"crucible"/"templates"/"includes").install Dir["templates/includes/*.md"]
    end

    # Install persona definitions
    # setup.ts searches: /opt/homebrew/share/crucible/templates/personas
    if File.directory?("templates/personas")
      (share/"crucible"/"templates"/"personas").install Dir["templates/personas/*.md"]
    end

    # Install project scaffold template (including dotfiles like .agent/, .gitignore)
    # scaffold.ts searches: /opt/homebrew/share/crucible/templates/project-template
    if File.directory?("templates/project-template")
      (share/"crucible"/"templates"/"project-template").install Dir.glob("templates/project-template/{*,.*}").reject { |f| %w[. ..].include?(File.basename(f)) }
    end
  end

  def caveats
    <<~EOS
      Welcome to Crucible! To get started, run:
        crucible setup

      Then restart Claude Code for changes to take effect.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/crucible --version")
    assert_match "monitor", shell_output("#{bin}/crucible --help")
    assert_match "evaluate", shell_output("#{bin}/crucible --help")
  end
end
