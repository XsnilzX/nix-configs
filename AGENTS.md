# AGENTS.md
# Guidance for coding agents working in this repo.

## Scope and layout
- This is a Nix flake repo for NixOS + Home Manager configuration.
- Key paths:
  - flake: `flake.nix`, `flake.lock`
  - machines: `machines/<name>/configuration.nix`
  - shared modules: `modules/`
  - home-manager: `home/` (including `home/home.nix` and program modules)
  - secrets: `secrets/` (SOPS-managed)

## Build / lint / test commands
- There are no explicit test suites in this repo; prefer `nix flake check`.

### Build
- Build a NixOS system (no switch):
  - `nix build .#nixosConfigurations.<machine>.config.system.build.toplevel`
  - Example: `nix build .#nixosConfigurations.nixspo.config.system.build.toplevel`
- Switch on a target host (requires sudo and correct hostname):
  - `sudo nixos-rebuild switch --flake .#<machine>`

### Lint / format
- Nix formatting uses Alejandra (configured in editor settings).
  - Format a file or repo: `alejandra path/to/file.nix` or `alejandra .`
- No linting tools (statix/deadnix) are configured in this repo.

### Tests / checks
- Run all flake checks:
  - `nix flake check -L --show-trace`
- Single check (only if checks are later added):
  - `nix build .#checks.x86_64-linux.<check-name>`

## Code style and conventions

### Formatting
- 2-space indent; align with existing files (no tabs).
- One attribute per line in attribute sets and lists.
- Use `let ... in` for helper values that are reused.
- Keep trailing commas out of Nix lists/attrs (match existing style).

### Imports and module structure
- `imports = [ ... ];` with relative paths.
- Keep machine-specific config in `machines/<name>/`.
- Keep shared config in `modules/` or `home/programs/`.
- Prefer `lib.optionals` for conditional lists.

### Naming
- Files and directories: lowercase names, hyphen-separated when needed.
- Nix attributes: lowerCamelCase for option names; keep consistent with NixOS
  option names.
- Machine selectors use `machine == "nixspo"` / `"nixhael"`.

### Strings and paths
- Use double quotes for strings.
- Prefer interpolated paths like "${config.home.homeDirectory}".
- Keep paths relative when possible inside modules.

### Packages and programs
- Use `with pkgs; [ ... ]` in package lists, matching current style.
- Keep package lists grouped by purpose with short comments.
- Avoid unnecessary reordering; preserve existing grouping.

### Types and Nix idioms
- Use `lib.mkForce` or `lib.mkDefault` when overriding behavior.
- Use `lib.optionals` instead of `if` where you are building lists.
- For machine-specific values, prefer `lib.optionals` and `machine` arg.

### Error handling and safety
- Avoid hardcoding secrets or tokens in Nix files.
- Never commit plaintext secrets; use SOPS-managed files in `secrets/`.
- When touching `secrets/`, use `sops` for edits and keep `.sops.yaml` in sync
  with any new keys.

## Secrets (SOPS)
- Secrets live in `secrets/*.yaml` and are managed by `sops-nix`.
- The key file is configured at `/var/lib/sops-nix/key.txt`.
- Do not add unencrypted secrets to the repo.

## Editor/formatting hints found in repo
- Alejandra is the configured Nix formatter (see `home/programs/editor.nix`).
- Format-on-save is enabled in editor profiles; keep code formatted.

## Cursor/Copilot rules
- No `.cursor/rules/`, `.cursorrules`, or `.github/copilot-instructions.md`
  files are present in this repo at this time.

## Practical workflow for agents
- Start by identifying the target machine: `nixspo` or `nixhael`.
- Update the relevant module file and keep changes scoped.
- Format Nix files with Alejandra.
- Run `nix flake check` before suggesting a rebuild.

## Notes about this repo
- `home/home.nix` is shared and conditionally imports modules based on
  `machine`.
- `machines/share.nix` and `modules/*` are used by both machines.
- Some options are set in Home Manager (programs) rather than NixOS.

## Things to avoid
- Do not reformat unrelated files.
- Do not remove machine-specific settings unless requested.
- Do not rewrite `secrets/` files without using `sops`.
