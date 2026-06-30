# Contributing to Tenable Exposure Management Leaderboard

Thank you for your interest in improving this agent! This project follows the contribution guidelines of the [Tenable CyberAgents Exchange](https://github.com/tenable/cyberagents-exchange).

## How to Contribute

### Reporting Issues
- Check existing issues before creating a new one
- Provide clear reproduction steps
- Include relevant environment details (Claude Code version, Tenable One API version, MCP server version)
- Share sanitized output/error messages

### Suggesting Enhancements
- Open an issue describing the enhancement
- Explain the use case and expected behavior
- Consider whether it maintains the "accuracy over completeness" principle

### Submitting Pull Requests

1. **Fork the repository**
   ```bash
   git clone https://github.com/itschrisyo/tenable-leaderboard.git
   cd tenable-leaderboard
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes**
   - Follow the existing code style and structure
   - Maintain the SKILL file format and agent directives
   - Update documentation if adding new features
   - Test your changes against a live Tenable One instance (or mock data)

3. **Commit your changes**
   ```bash
   git add .
   git commit -m "Add feature: brief description"
   ```

4. **Push and create a PR**
   ```bash
   git push origin feature/your-feature-name
   ```
   Then open a pull request on GitHub with a clear description of your changes.

## Development Guidelines

### Core Principles
All contributions must maintain these core principles:
- **Accuracy First**: Never fabricate, estimate, or infer data
- **Source Attribution**: Every metric must cite its API source
- **Gap Transparency**: Surface unavailable data rather than hiding it
- **Executive Clarity**: Optimize for non-technical leadership consumption

### Code Style
- Keep SKILL directives clear and actionable
- Use plain language for executive-facing content
- Maintain consistent formatting (tables for data, arrows for trends)
- Document any new API endpoints or MCP calls

### Testing
Before submitting:
- Test against a live Tenable One instance or realistic mock data
- Verify all ownership tag resolution logic
- Confirm output formatting for all four dashboard layers
- Check that unavailable data is properly flagged

## Submitting to CyberAgents Exchange

This agent is listed in the Tenable CyberAgents Exchange. To contribute updates to the exchange listing:

1. Update `agents/tenable-exposure-management-leaderboard.md` with changes
2. Ensure the listing metadata matches the current implementation:
   - `name`, `author`, `github_url`, `description`
   - `tags`, `framework`, `integrations`
   - `date_added` (update if major changes)
3. Submit a PR to this repository
4. Once merged, submit a PR to [tenable/cyberagents-exchange](https://github.com/tenable/cyberagents-exchange) with the updated listing

## Questions?

Open an issue or reach out to [@itschrisyo](https://github.com/itschrisyo).
