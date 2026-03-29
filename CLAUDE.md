# homebrew-crucible

Official Homebrew tap for crucible pipeline engine distribution.

## Critical Rules

1. Never commit secrets
2. Always replace SHA256 placeholder with actual checksum before release
3. Test formula locally before pushing
4. Verify command templates install to share directory

## Formula

- `Formula/crucible.rb` — Installs crucible binary and command templates
- **Platform**: macOS ARM64 only (Apple Silicon)
- **Post-install**: Suggests running `crucible setup`
- **Templates**: Installed to `share/crucible/` (searched by setup.ts)

## Common Commands

```bash
# Install
brew tap centient-labs/crucible
brew install crucible

# Test formula locally
brew install --build-from-source ./Formula/crucible.rb
brew test crucible

# Audit formula
brew audit --strict Formula/crucible.rb
```

## Release Workflow

1. Update version and URL in `Formula/crucible.rb`
2. Replace SHA256 placeholder with actual tarball checksum
3. Test locally with `brew install --build-from-source`
4. Verify `crucible setup` works post-install
5. Push to main
