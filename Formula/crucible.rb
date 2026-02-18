# typed: false
# frozen_string_literal: true

class Crucible < Formula
  desc "Pipeline execution engine for Claude Code (MCP server)"
  homepage "https://github.com/centient-labs/crucible"
  version "0.8.0"
  # license - TBD

  # Currently only macOS ARM64 (Apple Silicon) is supported
  depends_on :macos
  depends_on arch: :arm64

  url "https://github.com/centient-labs/homebrew-crucible/releases/download/v#{version}/crucible-macos-arm64.tar.gz"
  # SHA256 is injected by .github/workflows/release.yml at release time.
  # The placeholder value causes Homebrew to reject pre-release installs.
  sha256 "ecb9d7c3d2726f487e4c8d3dffb2da9e5b459e0b0c59c80d1d32e630d4062e45"

  def install
    bin.install "crucible"

    # Install command templates to share directory
    # setup.ts searches: /opt/homebrew/share/crucible/templates/commands
    if File.directory?("templates/commands")
      (share/"crucible"/"templates"/"commands").install Dir["templates/commands/*.md"]
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
