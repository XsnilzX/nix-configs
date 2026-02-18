# AGENTS.md

Guidance for coding agents working in this repository.

## Repository scope

- This repo is a Nix flake for NixOS + Home Manager.
- Flake entry points: `flake.nix`, `flake.lock`.
- Host configs: `machines/nixspo/` and `machines/nixhael/`.
- Shared system module: `machines/share.nix`.
- Shared NixOS modules: `modules/`.
- Home Manager root: `home/home.nix`.
- Home modules: `home/programs/`, `home/niri/`, `home/hyprland/`, per-host dirs.
- Secrets are managed through sops-nix modules under `modules/sops/`.

## Environment assumptions

- Platform is Linux with flakes enabled.
- Commands are expected to run from repo root.
- This flake currently exposes only `nixosConfigurations` outputs.
- Available host names in flake outputs: `nixspo`, `nixhael`.

## Build, lint, and test commands

### Core validation commands

- Run the full flake checks (best default validation):
  - `nix flake check -L --show-trace`
- Show available flake outputs:
  - `nix flake show`

### Build commands

- Build one host system closure without switching:
  - `nix build .#nixosConfigurations.<machine>.config.system.build.toplevel`
- Build `nixspo` specifically:
  - `nix build .#nixosConfigurations.nixspo.config.system.build.toplevel`
- Build `nixhael` specifically:
  - `nix build .#nixosConfigurations.nixhael.config.system.build.toplevel`
- Rebuild/switch on a host (destructive on running system; use only when asked):
  - `sudo nixos-rebuild switch --flake .#<machine>`

### Lint/format commands

- Formatter in use: Alejandra.
- Format entire repo:
  - `alejandra .`
- Format one file:
  - `alejandra path/to/file.nix`
- Optional syntax parse for a single file:
  - `nix-instantiate --parse path/to/file.nix`
- No dedicated lint tools are configured here (no statix/deadnix config present).

### "Single test" guidance

- There is no unit-test framework in this repo.
- For agent workflows, treat a targeted single-host build as the closest
  equivalent to a single test.
- Preferred "single test" commands:
  - `nix build .#nixosConfigurations.nixspo.config.system.build.toplevel`
  - `nix build .#nixosConfigurations.nixhael.config.system.build.toplevel`
- If explicit checks are added later, run one check with:
  - `nix build .#checks.x86_64-linux.<check-name>`

## Code style and conventions

### Formatting

- Use 2-space indentation; no tabs.
- Keep attribute formatting consistent with surrounding code.
- End Nix attributes with semicolons.
- Keep lists and attrsets readable, usually one logical item per line.
- Prefer running Alejandra after edits to `.nix` files.
- Do not reformat unrelated files.

### Imports and module structure

- Keep host-specific settings in `machines/<host>/`.
- Keep cross-host settings in `machines/share.nix` or `modules/`.
- Keep user-space program config under `home/programs/`.
- Use relative paths in `imports = [ ... ];`.
- Follow existing split-by-feature module boundaries.
- In shared modules, gate host/compositor specifics with conditions.

### Nix idioms and types

- Prefer `lib.optionals` for conditional list concatenation.
- Prefer `lib.mkIf` for conditional attribute sets.
- Use `lib.mkDefault` for soft defaults.
- Use `lib.mkForce` only when intentional override is required.
- Use `let ... in` when values are reused or improve readability.
- Keep option value types aligned with NixOS/Home Manager module expectations.

### Naming conventions

- File and directory names should stay lowercase.
- Use hyphenated filenames where appropriate (existing convention).
- Keep option and local variable names descriptive and consistent.
- Preserve existing host identifiers exactly: `nixspo`, `nixhael`.
- Do not rename public module paths unless requested.

### Strings, paths, and package lists

- Use double-quoted strings.
- Prefer interpolation for derived paths, e.g.
  `${config.home.homeDirectory}/...`.
- Prefer relative import paths inside the repo.
- Use `with pkgs; [ ... ]` in package lists where already used.
- Keep package lists grouped by purpose; avoid unnecessary reordering.

### Comments and readability

- Keep existing language and comment style intact when modifying nearby code.
- Add comments only for non-obvious reasoning.
- Remove stale comments when they become incorrect.

## Error handling and safety

- Never hardcode credentials, tokens, or plaintext secrets.
- Secrets should stay in SOPS-managed files and sops-nix wiring.
- Keep sops key path assumptions intact (`/var/lib/sops-nix/key.txt`).
- Avoid changing security-sensitive settings unless requested.
- Avoid destructive system actions (switch/reboot) unless explicitly asked.

## Secrets and sensitive files

- sops-nix is integrated via `modules/sops/` and host-specific sops modules.
- If secret definitions are touched, keep ownership and paths consistent.
- Never commit decrypted secret material.
- Do not invent new secret files or keys without user request.

## Cursor and Copilot instructions

- Checked locations:
  - `.cursor/rules/`
  - `.cursorrules`
  - `.github/copilot-instructions.md`
- Result: none of these files exist in the current repository state.

## Agent workflow for this repo

- Identify target host early (`nixspo` or `nixhael`).
- Keep changes scoped to the relevant module(s).
- Prefer minimal diffs that match existing patterns.
- Run Alejandra on changed Nix files.
- Run `nix flake check -L --show-trace` when feasible.
- For quick verification, run a single-host `nix build`.
- Report exactly what was validated and what was not run.

## Things to avoid

- Do not remove machine-specific logic unless requested.
- Do not move config between NixOS and Home Manager without reason.
- Do not edit `flake.lock` unless dependency updates are requested.
- Do not add new tooling assumptions not already present in repo.
