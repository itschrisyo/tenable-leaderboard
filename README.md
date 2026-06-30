# Tenable Exposure Management Leaderboard

A Claude Code SKILL agent that transforms Tenable One exposure data into leadership-ready dashboards for tracking organizational risk reduction progress.

## Overview

This agent connects to Tenable One via API or MCP to generate executive-level exposure management dashboards. It maps assets to business owners through tag analysis, tracks remediation velocity and SLA compliance, identifies systemic risk patterns, and surfaces organizational gaps — all with complete traceability to source data.

**Core principle:** Accuracy over completeness. Every metric is verified against live API data. No estimations, no fabrications, no hallucinations.

## What It Does

### Executive Summary Layer
- Organization-wide exposure score with trend analysis
- SLA compliance rates for Critical/High findings
- Active risk movers (teams improving vs. teams needing support)
- Top organizational risks requiring policy attention

### Ownership Leaderboard
- Per-owner exposure scores with historical deltas
- Remediation velocity by severity
- SLA compliance tracking
- Performance trend indicators

### Gap Analysis
- Untagged/unowned assets with exposure context
- Tagging coverage quality metrics
- Ownership assignment recommendations

### Systemic Risk Detection
- Clusters of persistent findings across teams
- Network segments with tagging gaps
- Organization-wide velocity declines
- Shared dependency blockers

## Requirements

- **Tenable One Access**: API credentials or MCP connection
- **Asset Tagging**: Ownership metadata via tags (`owner:`, `team:`, `bu:`, `department:`)
- **Historical Data**: Exposure score history for trend analysis
- **Claude Code**: The SKILL framework for agent execution

## Installation

### 1. Clone this repository
```bash
git clone https://github.com/itschrisyo/tenable-leaderboard.git
cd tenable-leaderboard
```

### 2. Install the SKILL file
Copy `tenable-exposure-leaderboard.skill` to your Claude Code skills directory:
```bash
cp tenable-exposure-leaderboard.skill ~/.claude/skills/
```

### 3. Configure Tenable One MCP (if using MCP)
Follow the [Tenable MCP setup guide](https://github.com/tenable/tenable-mcp) to configure your MCP server with appropriate credentials.

Alternatively, ensure your Tenable One API credentials are available for direct API access.

## Usage

### Basic Invocation
From Claude Code CLI or IDE:
```
/tenable-exposure-leaderboard
```

The agent will:
1. Verify Tenable One connectivity
2. Pull all required data sets (exposures, assets, tags, historical scores, remediation metrics)
3. Process ownership tags and calculate metrics
4. Generate the four-layer dashboard
5. Present results with full source attribution

### Example Output Structure

```
═══════════════════════════════════════════════════════════════
TENABLE EXPOSURE MANAGEMENT DASHBOARD
Data Retrieved: 2026-06-30 14:23:15 UTC
Source: Tenable One API v1 | MCP: tenable-lab
═══════════════════════════════════════════════════════════════

📊 EXECUTIVE SUMMARY

Organization-wide Exposure Score: 782 ↓ (-14 vs. prior period)
  → Risk is improving across the organization

Critical/High Findings Remediated Within SLA: 87.3%
  → 13 of 15 critical findings closed on time this period

Assets with Active Critical Exposures: 42
  → Down from 58 last period (-27.6%)

Performance Movers:
  ✅ 12 teams actively reducing risk
  ⚠️  5 teams need support (stalled or increasing risk)

Top 3 Organizational Risks:
  1. 127 untagged assets across production network segments
  2. 8 Critical findings open >60 days across multiple teams (shared dependency)
  3. Database asset class remediation velocity declined 31% this period

─────────────────────────────────────────────────────────────

📈 OWNERSHIP LEADERBOARD
[... detailed per-owner metrics table ...]
```

## Data Source Attribution

Every metric in the dashboard includes API source citation:
- Exposure scores → `GET /api/v1/exposures`
- Asset tags → `GET /api/v1/assets/{uuid}/tags`
- Remediation velocity → `GET /api/v1/findings/stats`
- Historical trends → `GET /api/v1/exposures/history`

Unavailable data is explicitly flagged as `[Data Unavailable]` rather than estimated.

## Ownership Tag Resolution Logic

Assets are mapped to owners via the following tag hierarchy (most specific wins):

1. `owner:` tags (explicit individual/team assignment)
2. `team:` tags (team-level ownership)
3. `bu:` tags (business unit ownership)
4. `department:` tags (departmental ownership)

Assets with no matching tags are flagged as **Untagged/Unowned** and reported separately as an organizational gap.

## Output Format

The dashboard is optimized for multiple audiences:
- **Board/eStaff**: Executive summary with plain-language context
- **Security Leadership**: Ownership leaderboard with actionable metrics
- **Operations Teams**: Gap analysis and systemic risk signals
- **Policy/Governance**: Tagging coverage and organizational patterns

All sections use tables for structured data, trend arrows for direction, and severity labels for findings.

## Design Principles

1. **Accuracy First**: Never fabricate data. If it's not in the API, it's not in the dashboard.
2. **Source Attribution**: Every metric cites its API endpoint and retrieval timestamp.
3. **Opportunity Framing**: "Needs Support" not "Failing" — focus on improvement, not blame.
4. **Gap Visibility**: Surface negative signals (untagged assets, stalled remediations) rather than hiding them.
5. **Executive Clarity**: Lead with metrics non-technical leaders care about, explain before showing numbers.

## Contributing

This agent is submitted to the [Tenable CyberAgents Exchange](https://github.com/tenable/cyberagents-exchange). Contributions, improvements, and feedback are welcome via pull requests.

## License

MIT License - see [LICENSE](LICENSE) for details.

## Author

Created by [@itschrisyo](https://github.com/itschrisyo)

## Related Resources

- [Tenable One API Documentation](https://developer.tenable.com/reference/navigate)
- [Tenable MCP Server](https://github.com/tenable/tenable-mcp)
- [Claude Code SKILL Framework](https://claude.ai/code)
- [CyberAgents Exchange](https://github.com/tenable/cyberagents-exchange)
