---
name: "Tenable Exposure Management Leaderboard"
author: "itschrisyo"
github_url: "https://github.com/itschrisyo/tenable-leaderboard"
description: "Leadership-ready exposure management dashboard that tracks risk reduction progress across asset owners with zero fabricated data."
license: "MIT"
category: "agent"
tier: "unreviewed"
tags: ["exposure-management", "reporting", "dashboard", "risk-tracking", "metrics", "remediation", "sla-compliance"]
framework: "Claude Code SKILL"
integrations: ["Tenable"]
date_added: 2026-06-30
---

A security intelligence agent specialized in exposure management reporting for Tenable One. Transforms live Tenable One API or MCP data into executive-ready leaderboard dashboards that track risk reduction across the organization with complete traceability to source data.

## What it does

This agent connects to Tenable One API or MCP to pull verified exposure data and builds a multi-layered dashboard designed for both executive leadership and security teams. It maps assets to business owners via tag analysis, calculates risk reduction trends, tracks remediation velocity, measures SLA compliance, and surfaces systemic risk patterns — all without estimating or fabricating data.

**Key capabilities:**

- **Data Retrieval**: Pulls active exposures (ACR, AES scores), asset inventory with tags, historical exposure scores, remediation velocity metrics, SLA compliance rates, and vulnerability counts by severity
- **Ownership Identification**: Maps assets to business owners via Tenable asset tags with explicit hierarchy resolution (team > department), flags untagged assets as organizational gaps
- **Four-Layer Dashboard**:
  - **Executive Summary**: Org-wide exposure score with trend, SLA compliance %, critical exposure count, performance movers
  - **Ownership Leaderboard**: Per-owner exposure scores, finding counts, remediation velocity, SLA compliance with trend indicators
  - **Unowned Asset Report**: Assets without resolvable ownership tags with exposure context
  - **Systemic Risk Signals**: Patterns indicating policy-level issues (clusters of untagged assets, blocked remediation paths, declining velocity)

## How it works

The agent operates on a strict **accuracy-over-completeness** principle:

1. **Authentication & Connection**: Establishes live connection to Tenable One API or MCP, timestamps all data pulls
2. **Data Extraction**: Retrieves multiple datasets in parallel (exposures, assets, tags, historical scores, remediation metrics)
3. **Ownership Resolution**: Processes asset tags to map ownership using explicit logic (owner:, team:, bu:, department: tags), with clear hierarchy and no assumptions
4. **Metric Calculation**: Computes exposure deltas, remediation velocity, SLA compliance rates, trend direction
5. **Dashboard Generation**: Builds layered output with executive summary first, detailed leaderboard second, gaps third, systemic patterns fourth
6. **Verification**: Cites API source and timestamp for every metric, flags any unavailable data explicitly rather than filling gaps

**Design principles:**
- Never estimates, infers, or generates placeholder data
- Every metric cites its source endpoint or MCP call
- Frames findings as "opportunity identification" not performance shaming
- Surfaces negative signals (gaps, stalled remediations, unowned assets) rather than suppressing them
- Uses tables for data, trend arrows for directionality, plain language for executive context

## Requirements

- Tenable One API access or Tenable One MCP connection
- Asset tagging with ownership metadata (owner:, team:, bu:, department: tags recommended)
- Historical exposure score data for trend analysis

## Output

A timestamped, multi-section dashboard with:
- Executive summary suitable for board/eStaff presentation
- Ranked ownership leaderboard with performance indicators
- Unowned asset gap analysis
- Systemic risk pattern detection
- Full API source attribution for all metrics
- Explicit marking of unavailable data points
