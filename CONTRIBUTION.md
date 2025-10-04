# Contribution Guide

**Contributions are very welcome!** Whether it's a small typo fix, a new operator label, a better example, or a larger refactor — your help makes this gem better. If you're unsure where to start, open an issue and we can figure it out together.

## Setup
- Ruby 2.7+
- No runtime dependencies

## How to contribute
1. Fork the repo and create a branch from `main`
2. Make your change (code, docs, or tests)
3. Include examples for any new operators or pretty mappings
4. Update `README.md` if public behavior changes
5. Run your tests
6. Open a Pull Request and describe:
   - What changed and why
   - Any breaking impacts
   - Before/after output if applicable

## Code style
- Plain Ruby
- Public API stays stable:
  - `JsonLogic::Rule.new(logic).humanize`
  - `JsonLogic::Humanizable` mixin + `humanize_json_logic`

## Releases
- Bump `lib/json_logic/version.rb` using SemVer
- Update `CHANGELOG.md`
