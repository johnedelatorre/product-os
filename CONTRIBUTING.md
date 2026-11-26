# Contributing to Product OS

Thank you for your interest in contributing to Product OS!

## How to Contribute

### Reporting Issues

1. Check existing issues to avoid duplicates
2. Use a clear, descriptive title
3. Include steps to reproduce
4. Describe expected vs actual behavior

### Suggesting Enhancements

1. Check if the enhancement has been suggested
2. Explain the use case clearly
3. Describe the expected behavior
4. Consider how it fits with existing agents

### Pull Requests

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Update documentation
5. Submit a pull request

## Adding Content

### Adding a New Agent

1. Create agent file in `.claude/agents/`
2. Create corresponding command in `.claude/commands/`
3. Create skill in `.claude/skills/` if needed
4. Add documentation in `docs/guides/agents/`
5. Update AGENTS.md roster
6. Update command reference

### Agent Structure

Every agent must include:

```markdown
# [Agent Name] Agent

> [One-line description]

## Role
[Clear statement of the agent's single responsibility]

## Single Responsibility
[What this agent does and does NOT do]

## Inputs
[Table of required and optional inputs]

## Outputs
[Table of outputs with format]

## Quality Checklist
[Checklist items for the agent's output]

## Process
[Step-by-step process the agent follows]

## Handoff
[What happens after this agent completes]
```

### Documentation Style

- Write for PMs and designers, not engineers
- Avoid jargon and acronyms without explanation
- Use tables for structured information
- Include examples for every concept
- Keep sentences short and clear

## Testing Changes

1. Test the full pipeline with `/product-os:new-project`
2. Test individual commands in isolation
3. Test with and without Atlassian/Figma MCP
4. Update `examples/acme-dashboard/` if output format changes

## Releasing a Version

1. Change `"version"` under `"metadata"` in `.claude-plugin/marketplace.json`. It is the only place the version is set.
2. Run `python3 scripts/build-plugin-skill.py`. It writes the version into the marketplace entry, the board and the README.
3. Run `python3 scripts/build-directory-plugin.py`. It rebuilds the two plugin folders: `marketplace/product-os/`, which people add from this repo, and `plugin/`, which Claude's plugin directory reads.
4. Add the version and date as a heading in `CHANGELOG.md`.
5. Run `bash scripts/validate.sh`.

## Commit Messages

Use clear, descriptive messages:

```
Add [agent/feature]: Brief description

- Detail 1
- Detail 2
```

## Questions?

Open an issue with the "question" label.

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
