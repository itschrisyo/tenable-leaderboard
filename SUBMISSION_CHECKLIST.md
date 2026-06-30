# CyberAgents Exchange Submission Checklist

Use this checklist to ensure your submission meets all requirements for the [Tenable CyberAgents Exchange](https://github.com/tenable/cyberagents-exchange).

## ✅ Pre-Submission Checklist

### Repository Setup
- [x] Repository created: `https://github.com/itschrisyo/tenable-leaderboard`
- [x] LICENSE file added (MIT)
- [x] README.md with comprehensive documentation
- [x] CONTRIBUTING.md for collaboration guidelines
- [x] SKILL file created: `tenable-exposure-leaderboard.skill`
- [x] Agent listing created: `agents/tenable-exposure-management-leaderboard.md`

### Agent Listing Requirements (agents/tenable-exposure-management-leaderboard.md)
- [x] **name**: "Tenable Exposure Management Leaderboard"
- [x] **author**: "itschrisyo"
- [x] **github_url**: "https://github.com/itschrisyo/tenable-leaderboard"
- [x] **description**: One-line summary (under 120 characters)
- [x] **license**: "MIT"
- [x] **category**: "agent"
- [x] **tier**: "unreviewed" (will be updated after review)
- [x] **tags**: Relevant tags for discovery
- [x] **framework**: "Claude Code SKILL"
- [x] **integrations**: ["Tenable"]
- [x] **date_added**: 2026-06-30
- [x] Extended description with "What it does" and "How it works" sections

### SKILL File Requirements (tenable-exposure-leaderboard.skill)
- [x] Frontmatter with name and description
- [x] Clear agent directives
- [x] Execution flow documented
- [x] Core principles defined
- [x] Data retrieval logic specified
- [x] Output formatting guidelines

### Documentation Requirements
- [x] README with installation instructions
- [x] Usage examples
- [x] Requirements section
- [x] Output format documentation
- [x] Design principles explained

## 📤 Submission Process

### Step 1: Prepare Your Repository
```bash
# Ensure all files are committed
git add .
git commit -m "Initial commit: Tenable Exposure Management Leaderboard agent"
git push origin main
```

### Step 2: Fork CyberAgents Exchange
1. Go to https://github.com/tenable/cyberagents-exchange
2. Click "Fork" to create your fork
3. Clone your fork:
   ```bash
   git clone https://github.com/YOUR-USERNAME/cyberagents-exchange.git
   cd cyberagents-exchange
   ```

### Step 3: Create Your Branch
```bash
git checkout -b add-exposure-management-leaderboard
```

### Step 4: Copy Your Agent Listing
```bash
# Copy the agent listing file to the exchange repository
cp /path/to/tenable-leaderboard/agents/tenable-exposure-management-leaderboard.md \
   ./agents/tenable-exposure-management-leaderboard.md
```

### Step 5: Validate Your Listing

Ensure your listing file matches the template format:
- [ ] Valid YAML frontmatter (no syntax errors)
- [ ] All required fields present
- [ ] `github_url` points to your repository (not a fork)
- [ ] `date_added` is today's date in YYYY-MM-DD format
- [ ] Tags are relevant and help with discovery
- [ ] Description is concise and accurate

### Step 6: Commit and Push
```bash
git add agents/tenable-exposure-management-leaderboard.md
git commit -m "Add Tenable Exposure Management Leaderboard agent

Security intelligence agent for exposure management reporting.
Generates leadership-ready dashboards from Tenable One API/MCP data
with complete source attribution and zero fabricated metrics.

- Maps assets to owners via tag analysis
- Tracks remediation velocity and SLA compliance
- Surfaces systemic risk patterns
- Executive summary + ownership leaderboard + gap analysis"

git push origin add-exposure-management-leaderboard
```

### Step 7: Open Pull Request
1. Go to https://github.com/tenable/cyberagents-exchange
2. Click "Pull requests" → "New pull request"
3. Click "compare across forks"
4. Select your fork and branch: `YOUR-USERNAME:add-exposure-management-leaderboard`
5. Title: "Add Tenable Exposure Management Leaderboard agent"
6. Description:
   ```markdown
   ## Agent Submission

   **Name**: Tenable Exposure Management Leaderboard
   **Type**: Agent (Claude Code SKILL)
   **Category**: Exposure Management, Reporting, Risk Tracking

   ### What it does
   Security intelligence agent that pulls verified Tenable One data and generates
   executive-ready exposure management dashboards tracking organizational risk
   reduction progress.

   ### Key Features
   - Live API/MCP data retrieval with source attribution
   - Asset-to-owner mapping via tag analysis
   - Four-layer dashboard (executive summary, ownership leaderboard, gap analysis, systemic risks)
   - Remediation velocity and SLA compliance tracking
   - Zero fabricated data guarantee

   ### Integration
   - Framework: Claude Code SKILL
   - Integrations: Tenable One API, Tenable One MCP
   - License: MIT

   ### Repository
   https://github.com/itschrisyo/tenable-leaderboard

   ### Checklist
   - [x] Agent listing follows template format
   - [x] Repository includes LICENSE, README, CONTRIBUTING
   - [x] SKILL file with complete agent directives
   - [x] Tested against Tenable One API/MCP
   - [x] Documentation includes usage examples
   ```

7. Submit the pull request

## 🔍 Post-Submission

### What Happens Next
1. **Automated validation**: CI checks will verify your listing format
2. **Community review**: Maintainers and community members will review
3. **Feedback cycle**: Address any requested changes
4. **Merge**: Once approved, your listing goes live
5. **Trust tier**: Starts as "unreviewed", can be promoted to "community-reviewed" or "certified" after testing

### Promoting Trust Tier
- **COMMUNITY-REVIEWED**: Get community members to test and vouch for your agent
- **CERTIFIED**: Work with Tenable maintainers for official verification

### Maintaining Your Listing
After acceptance:
- Keep your agent repository up to date
- Respond to issues and PRs
- Update the exchange listing for major changes
- Follow semantic versioning if applicable

## 📝 Final Verification

Before submitting, verify:
- [ ] Repository is public and accessible
- [ ] All links in documentation work
- [ ] SKILL file has been tested with Claude Code
- [ ] Agent produces expected output against Tenable One
- [ ] No sensitive data (API keys, credentials) in any files
- [ ] License is appropriate for open source
- [ ] Contact information is correct

## 🎯 Success Criteria

Your submission is ready when:
1. All checklist items above are complete
2. Repository has clear documentation
3. Agent listing follows exact template format
4. You've tested the agent against live or mock data
5. No fabricated or placeholder data in examples

## 🚀 Optional Enhancements

Consider adding:
- Example output screenshots (sanitized)
- Video demo of the agent in action
- Test suite for validation
- Mock data for testing without API access
- GitHub Actions for automated testing

## Questions?

- Review the [CyberAgents Exchange repository](https://github.com/tenable/cyberagents-exchange)
- Check existing agent submissions for examples
- Open an issue in your repository for community help
- Reach out to Tenable CyberAgents team

---

**Created**: 2026-06-30
**Last Updated**: 2026-06-30
