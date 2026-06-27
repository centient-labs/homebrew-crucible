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

## Session & Knowledge Management

This project participates in the centient knowledge management system. When `mcp__centient__*` tools are available, **always initialize a session at the start of every conversation** and use knowledge tools throughout:

1. **Always start a session** — Call `start_session_coordination` with `sessionId` (format: `YYYY-MM-DD-topic`) and `projectPath` before doing any work
2. **Search first** — Call `search_crystals` with your task topic to find prior work and decisions
3. **Check duplicates** — Call `check_duplicate_work` before implementing non-trivial changes
4. **Save knowledge** — Call `save_session_note` for important decisions, findings, and blockers
5. **End** — Call `finalize_session_coordination` to persist session artifacts

See `.agent/procedures/session-management.md` for tool parameters and additional tools.
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
