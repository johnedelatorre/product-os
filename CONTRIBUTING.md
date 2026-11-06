# Contributing to Product OS

Thank you for your interest in contributing to Product OS!

## How to Contribute

### Reporting Issues

1. Check existing issues to avoid duplicates
2. Use a clear, descriptive title
3. Include steps to reproduce
4. Describe expected vs actual behavior
5. Include relevant configuration details

### Suggesting Enhancements

1. Check if the enhancement has been suggested
2. Explain the use case clearly
3. Describe the expected behavior
4. Consider how it fits with existing agents

### Pull Requests

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/my-feature`)
3. Make your changes
4. Update documentation
5. Submit a pull request

## Development Guidelines

### Adding a New Agent

1. Create agent file in `.claude/agents/`
2. Create corresponding command in `.claude/commands/`
3. Create template in `templates/` if needed
4. Add documentation in `docs/guides/`
5. Update AGENTS.md with agent specification
6. Update command reference in docs
7. Add tests/examples if applicable

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

## [Domain-specific sections]

## Quality Checklist
[Checklist items for the agent's output]

## Process
[Step-by-step process the agent follows]

## Handoff
[What happens after this agent completes]
```

### Code Style

- Use clear, descriptive names
- Include comments for non-obvious logic
- Follow existing patterns in the codebase
- Keep files focused on single responsibility

### Documentation Requirements

All changes must include:

1. Updated README if user-facing
2. Updated relevant guide in `docs/guides/`
3. Updated command reference if adding commands
4. Updated CHANGELOG.md

## Testing

### Manual Testing

1. Test the full pipeline with `/product-os:new-project`
2. Test individual commands in isolation
3. Test with and without Atlassian MCP
4. Test with and without Figma MCP

### Example Project

Update `examples/acme-dashboard/` if your changes affect output format.

## Commit Messages

Use clear, descriptive commit messages:

```
Add [agent/feature]: Brief description

- Detail 1
- Detail 2
```

## Questions?

Open an issue with the "question" label.

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
