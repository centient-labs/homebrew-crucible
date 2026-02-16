# typed: false
# frozen_string_literal: true

class Crucible < Formula
  desc "Pipeline execution engine for Claude Code (MCP server)"
  homepage "https://github.com/centient-labs/crucible"
  version "0.7.0"
  # license - TBD

  # Currently only macOS ARM64 (Apple Silicon) is supported
  depends_on :macos
  depends_on arch: :arm64

  url "https://github.com/centient-labs/homebrew-crucible/releases/download/v#{version}/crucible-macos-arm64.tar.gz"
  sha256 "abfa9b60f33ace8a3c365c5bbdab2126ebd02f55cc2a3b11e6fc305dce63d8f3"

  def install
    bin.install "crucible"

    # Install command templates to share directory
    # setup.ts searches: /opt/homebrew/share/crucible/templates/commands
    if File.directory?("templates/commands")
      (share/"crucible"/"templates"/"commands").install Dir["templates/commands/*.md"]
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
  end
end
