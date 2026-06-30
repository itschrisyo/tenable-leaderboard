# Tenable Exposure Management Leaderboard

A Claude Code SKILL agent that transforms Tenable One exposure data into leadership-ready dashboards for tracking organizational risk reduction progress.

## Overview

This agent connects to Tenable One via API to generate executive-level exposure management dashboards. It maps assets to business owners through tag analysis, tracks team performance using real Asset Exposure Scores (AES), identifies high-impact quick wins for risk reduction, and surfaces organizational gaps — all with complete traceability to source data.

**Core principle:** Accuracy over completeness. Every metric is verified against live API data. No estimations, no fabrications, no hallucinations.

**Current implementation:** HTML dashboard with dark-luxe design and PowerPoint export capability showing top 10 teams and actionable quick wins.

## What It Does

### Executive Summary Layer
- **Total Assets**: Monitored assets across all teams
- **Assets With Scores**: Number of assets with real Tenable Asset Exposure Scores
- **Critical Findings**: Vulnerabilities requiring immediate action
- **High Severity**: High-priority vulnerabilities

### Team Performance Leaderboard (Top 10)
- **Per-team exposure scores**: Real Asset Exposure Score (AES) from Tenable API (0-1000 scale)
- **Asset count**: Number of assets per team
- **Vulnerability breakdown**: Critical, High, and Total vulnerability counts
- **Performance status**: Color-coded risk indicators (Excellent, Good, Needs Focus, High Risk)
- **Ranking**: Best performers (lowest exposure) ranked #1

### Quick Wins Section ("If you only have 5 minutes...")
- **High-impact vulnerabilities**: Vulnerabilities affecting the most assets
- **Cross-team opportunities**: Vulnerabilities spanning multiple teams
- **Effort-to-impact ratio**: Maximum risk reduction with minimal remediation effort
- **Prioritized actions**: Top 5 remediation opportunities ranked by impact

### Gap Analysis
- Untagged/unowned assets with exposure context
- Team identification from OS, Asset Type, Location, and Infrastructure tags
- Ownership assignment recommendations

## Requirements

- **Tenable One Access**: API credentials (Access Key + Secret Key)
- **Asset Tagging**: Ownership metadata via tags (`OS`, `Assets`, `Locations`, `CIDR Blocks`)
- **Claude Code**: The SKILL framework for agent execution
- **Python 3**: For PowerPoint generation (optional)

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

### 3. Configure Tenable One API credentials
Set your API credentials as environment variables (they will persist across shell sessions):
```bash
export TENABLE_ACCESS_KEY="your-access-key"
export TENABLE_SECRET_KEY="your-secret-key"
```

Add these to your `~/.zshrc` or `~/.bashrc` to make them permanent:
```bash
echo 'export TENABLE_ACCESS_KEY="your-access-key"' >> ~/.zshrc
echo 'export TENABLE_SECRET_KEY="your-secret-key"' >> ~/.zshrc
```

## Usage

### Generate the Dashboard
From Claude Code CLI or IDE:
```
/tenable-exposure-leaderboard
```

The agent will:
1. Verify Tenable One connectivity
2. Export all assets and vulnerabilities via Tenable API
3. Extract team ownership from asset tags (OS, Asset Type, Infrastructure, Location)
4. Calculate real Asset Exposure Scores from the API
5. Identify high-impact quick wins (vulnerabilities affecting multiple assets/teams)
6. Generate HTML dashboard with dark-luxe design
7. Open the dashboard in your default browser

### Generate PowerPoint Presentation
After generating the dashboard data, create an executive presentation:
```bash
./generate_pptx.sh
```

This creates `Tenable_Exposure_Leaderboard.pptx` with:
- Title slide
- Executive summary with key metrics
- Top 10 team rankings table
- Quick wins opportunities slide

### Output Files
- **`index.html`**: Interactive HTML dashboard with dark theme
- **`Tenable_Exposure_Leaderboard.pptx`**: Executive PowerPoint presentation
- **`/tmp/tenable_full_dataset.json`**: Complete raw data from API
- **`/tmp/leaderboard_top10.json`**: Processed leaderboard data

## Data Source Attribution

Every metric in the dashboard is sourced from Tenable One API:
- **Asset data**: `POST /assets/export` → `GET /assets/export/{uuid}/chunks/{id}`
- **Vulnerability data**: `POST /vulns/export` → `GET /vulns/export/{uuid}/chunks/{id}`
- **Exposure scores**: `exposure_score` field from asset export (0-1000 scale)
- **Asset tags**: `tags` array from asset export (OS, Assets, Locations, CIDR Blocks)

Unavailable data is explicitly shown with fallback calculations rather than estimated.

## Team Identification Logic

Assets are mapped to teams via the following tag analysis (priority order):

1. **OS tags**: Operating system identifies teams (Windows Team, Linux Team, VMware Team, etc.)
2. **Asset Type tags**: Asset classification (Servers Team, OT Devices Team, Assets of Interest Team)
3. **Infrastructure tags**: Network location (Cloud Infrastructure Team, Office Infrastructure Team)
4. **Location tags**: Geographic/office locations (Regional teams by office location)

Assets with no matching tags are excluded from team rankings but counted in overall metrics.

## Output Format

### HTML Dashboard Features
- **Dark-luxe aesthetic**: Off-black backgrounds (#0A0A0F), amber accents (#D4A574), clean typography
- **Interactive elements**: Hover states, exposure score tooltip with AES explanation
- **Responsive design**: Works on desktop and mobile devices
- **Real-time data**: All metrics sourced directly from Tenable One API
- **Accessibility**: Semantic HTML, ARIA labels, keyboard navigation support

### PowerPoint Presentation
- **4 slides**: Title, Executive Summary, Team Rankings, Quick Wins
- **Dark theme**: Matches HTML dashboard aesthetic
- **Print-ready**: Optimized for executive presentations
- **Automated generation**: Runs via shell script with Python/python-pptx

## Design Principles

1. **Accuracy First**: Never fabricate data. If it's not in the API, it's not in the dashboard.
2. **Real Exposure Scores**: Uses actual `exposure_score` field from Tenable API (0-1000 scale), not calculated metrics.
3. **Source Attribution**: Every metric includes API endpoint and retrieval timestamp.
4. **Actionable Quick Wins**: Prioritizes high-impact, low-effort remediation opportunities.
5. **Executive Clarity**: Dark-luxe design optimized for C-suite presentations and board meetings.
6. **Complete Traceability**: All data points link back to specific API responses with full audit trail.

## Screenshots

### HTML Dashboard
![HTML Dashboard](https://via.placeholder.com/1200x800?text=Dashboard+Screenshot)
*Top 10 team leaderboard with real Asset Exposure Scores and quick wins section*

### PowerPoint Presentation
![PowerPoint Slide](https://via.placeholder.com/1200x800?text=PowerPoint+Screenshot)
*Executive-ready presentation with dark theme matching the HTML dashboard*

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
