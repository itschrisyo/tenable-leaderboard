#!/bin/bash
# Generate PowerPoint presentation from Tenable Leaderboard data

cd "$(dirname "$0")"

# Create virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
fi

# Activate virtual environment
source venv/bin/activate

# Install dependencies
echo "Installing python-pptx..."
pip install python-pptx --quiet

# Run the PowerPoint generator
echo "Generating PowerPoint..."
python3 << 'PYTHON_SCRIPT'
import json
from pptx import Presentation
from pptx.util import Inches, Pt
from pptx.enum.text import PP_ALIGN
from pptx.dml.color import RGBColor
from datetime import datetime

# Load data
with open("/tmp/leaderboard_top10.json") as f:
    data = json.load(f)

# Create presentation
prs = Presentation()
prs.slide_width = Inches(13.333)
prs.slide_height = Inches(7.5)

# Define colors (dark theme)
BG_COLOR = RGBColor(10, 10, 15)
SURFACE_COLOR = RGBColor(19, 19, 24)
TEXT_PRIMARY = RGBColor(245, 245, 247)
TEXT_SECONDARY = RGBColor(160, 160, 171)
ACCENT_COLOR = RGBColor(212, 165, 116)
CRITICAL_COLOR = RGBColor(244, 67, 54)
WARNING_COLOR = RGBColor(255, 152, 0)

def add_slide_with_dark_bg(prs):
    slide = prs.slides.add_slide(prs.slide_layouts[6])  # Blank layout
    background = slide.background
    fill = background.fill
    fill.solid()
    fill.fore_color.rgb = BG_COLOR
    return slide

# SLIDE 1: Title Slide
slide = add_slide_with_dark_bg(prs)

title_box = slide.shapes.add_textbox(Inches(0.5), Inches(2.5), Inches(12), Inches(1))
title_frame = title_box.text_frame
title_frame.text = "Tenable Exposure Management Leaderboard"
title_para = title_frame.paragraphs[0]
title_para.font.size = Pt(54)
title_para.font.bold = False
title_para.font.color.rgb = TEXT_PRIMARY
title_para.alignment = PP_ALIGN.CENTER

subtitle_box = slide.shapes.add_textbox(Inches(0.5), Inches(3.8), Inches(12), Inches(0.5))
subtitle_frame = subtitle_box.text_frame
subtitle_frame.text = f"Generated {datetime.now().strftime('%B %d, %Y')} | {data['metrics']['total_teams']} Teams · {data['metrics']['total_assets']:,} Assets"
subtitle_para = subtitle_frame.paragraphs[0]
subtitle_para.font.size = Pt(18)
subtitle_para.font.color.rgb = TEXT_SECONDARY
subtitle_para.alignment = PP_ALIGN.CENTER

# SLIDE 2: Executive Summary
slide = add_slide_with_dark_bg(prs)

title_box = slide.shapes.add_textbox(Inches(0.75), Inches(0.5), Inches(11.5), Inches(0.6))
title_frame = title_box.text_frame
title_frame.text = "Executive Summary"
title_para = title_frame.paragraphs[0]
title_para.font.size = Pt(36)
title_para.font.color.rgb = TEXT_PRIMARY

# Stats boxes
stats = [
    ("Total Assets", f"{data['metrics']['total_assets']:,}", "Across top 10 teams"),
    ("Critical Findings", f"{data['metrics']['critical']:,}", "Immediate action required"),
    ("High Severity", f"{data['metrics']['high']:,}", "High-priority vulns"),
    ("Assets With Scores", f"{data['metrics']['assets_with_scores']}", "Real Tenable AES")
]

x_start = 0.75
y_pos = 1.8
box_width = 2.8
box_height = 1.5
gap = 0.2

for i, (label, value, detail) in enumerate(stats):
    x_pos = x_start + (i * (box_width + gap))

    # Box background
    box = slide.shapes.add_shape(1, Inches(x_pos), Inches(y_pos), Inches(box_width), Inches(box_height))
    box.fill.solid()
    box.fill.fore_color.rgb = SURFACE_COLOR
    box.line.color.rgb = RGBColor(40, 40, 48)

    # Label
    label_box = slide.shapes.add_textbox(Inches(x_pos + 0.2), Inches(y_pos + 0.2), Inches(box_width - 0.4), Inches(0.3))
    label_frame = label_box.text_frame
    label_frame.text = label.upper()
    label_para = label_frame.paragraphs[0]
    label_para.font.size = Pt(10)
    label_para.font.bold = True
    label_para.font.color.rgb = TEXT_SECONDARY

    # Value
    value_box = slide.shapes.add_textbox(Inches(x_pos + 0.2), Inches(y_pos + 0.55), Inches(box_width - 0.4), Inches(0.5))
    value_frame = value_box.text_frame
    value_frame.text = value
    value_para = value_frame.paragraphs[0]
    value_para.font.size = Pt(32)
    value_para.font.bold = False
    value_para.font.color.rgb = TEXT_PRIMARY

    # Detail
    detail_box = slide.shapes.add_textbox(Inches(x_pos + 0.2), Inches(y_pos + 1.1), Inches(box_width - 0.4), Inches(0.3))
    detail_frame = detail_box.text_frame
    detail_frame.text = detail
    detail_para = detail_frame.paragraphs[0]
    detail_para.font.size = Pt(10)
    detail_para.font.color.rgb = TEXT_SECONDARY

# SLIDE 3: Team Rankings
slide = add_slide_with_dark_bg(prs)

title_box = slide.shapes.add_textbox(Inches(0.75), Inches(0.5), Inches(11.5), Inches(0.6))
title_frame = title_box.text_frame
title_frame.text = "Team Performance Rankings (Top 10)"
title_para = title_frame.paragraphs[0]
title_para.font.size = Pt(36)
title_para.font.color.rgb = TEXT_PRIMARY

# Table
rows = 11  # Header + 10 teams
cols = 6
left = Inches(0.75)
top = Inches(1.5)
width = Inches(11.5)
height = Inches(5.5)

table = slide.shapes.add_table(rows, cols, left, top, width, height).table

# Set column widths
table.columns[0].width = Inches(0.8)  # Rank
table.columns[1].width = Inches(3.5)  # Team
table.columns[2].width = Inches(1.5)  # Assets
table.columns[3].width = Inches(1.5)  # Critical
table.columns[4].width = Inches(1.5)  # High
table.columns[5].width = Inches(2.7)  # Exposure Score

# Header row
headers = ["Rank", "Team", "Assets", "Critical", "High", "Exposure Score"]
for col_idx, header_text in enumerate(headers):
    cell = table.cell(0, col_idx)
    cell.text = header_text
    cell.fill.solid()
    cell.fill.fore_color.rgb = SURFACE_COLOR
    para = cell.text_frame.paragraphs[0]
    para.font.size = Pt(11)
    para.font.bold = True
    para.font.color.rgb = TEXT_SECONDARY
    para.alignment = PP_ALIGN.CENTER

# Data rows
for row_idx, entry in enumerate(data['leaderboard'], 1):
    # Rank
    cell = table.cell(row_idx, 0)
    cell.text = f"#{entry['rank']}"
    para = cell.text_frame.paragraphs[0]
    para.font.size = Pt(14)
    para.font.color.rgb = ACCENT_COLOR if entry['rank'] <= 3 else TEXT_PRIMARY
    para.alignment = PP_ALIGN.CENTER

    # Team
    cell = table.cell(row_idx, 1)
    cell.text = f"{entry['team']}\n{entry['type']}"
    para = cell.text_frame.paragraphs[0]
    para.font.size = Pt(12)
    para.font.color.rgb = TEXT_PRIMARY

    # Assets
    cell = table.cell(row_idx, 2)
    cell.text = str(entry['assets'])
    para = cell.text_frame.paragraphs[0]
    para.font.size = Pt(12)
    para.font.color.rgb = TEXT_SECONDARY
    para.alignment = PP_ALIGN.CENTER

    # Critical
    cell = table.cell(row_idx, 3)
    cell.text = str(entry['critical'])
    para = cell.text_frame.paragraphs[0]
    para.font.size = Pt(12)
    para.font.color.rgb = CRITICAL_COLOR if entry['critical'] > 0 else TEXT_SECONDARY
    para.alignment = PP_ALIGN.CENTER

    # High
    cell = table.cell(row_idx, 4)
    cell.text = str(entry['high'])
    para = cell.text_frame.paragraphs[0]
    para.font.size = Pt(12)
    para.font.color.rgb = WARNING_COLOR if entry['high'] > 0 else TEXT_SECONDARY
    para.alignment = PP_ALIGN.CENTER

    # Exposure Score
    cell = table.cell(row_idx, 5)
    cell.text = f"{entry['exposure_score']:.1f}"
    para = cell.text_frame.paragraphs[0]
    para.font.size = Pt(14)
    para.font.bold = True
    para.font.color.rgb = TEXT_PRIMARY
    para.alignment = PP_ALIGN.CENTER

# SLIDE 4: Quick Wins
slide = add_slide_with_dark_bg(prs)

title_box = slide.shapes.add_textbox(Inches(0.75), Inches(0.5), Inches(11.5), Inches(0.6))
title_frame = title_box.text_frame
title_frame.text = "If you only have 5 minutes..."
title_para = title_frame.paragraphs[0]
title_para.font.size = Pt(36)
title_para.font.color.rgb = TEXT_PRIMARY

subtitle_box = slide.shapes.add_textbox(Inches(0.75), Inches(1.1), Inches(11.5), Inches(0.3))
subtitle_frame = subtitle_box.text_frame
subtitle_frame.text = "High-impact vulnerabilities to meaningfully reduce risk"
subtitle_para = subtitle_frame.paragraphs[0]
subtitle_para.font.size = Pt(14)
subtitle_para.font.color.rgb = TEXT_SECONDARY

quick_wins = [
    ("SSL Medium Strength Cipher Suites (SWEET32)", "HIGH", 26, 3),
    ("WinVerifyTrust Signature Validation CVE-2013-3900", "HIGH", 20, 1),
    ("OpenSSH < 9.3p2 Vulnerability", "CRITICAL", 11, 4),
    ("Microsoft .NET Framework Updates (Aug 2023)", "HIGH", 10, 1),
    ("Microsoft .NET Framework Updates (Jan 2024)", "CRITICAL", 10, 1),
]

y_start = 1.8
card_height = 1.0
gap = 0.1

for i, (name, severity, assets, teams) in enumerate(quick_wins):
    y_pos = y_start + (i * (card_height + gap))

    # Card background
    card = slide.shapes.add_shape(1, Inches(0.75), Inches(y_pos), Inches(11.5), Inches(card_height))
    card.fill.solid()
    card.fill.fore_color.rgb = SURFACE_COLOR
    card.line.color.rgb = RGBColor(40, 40, 48)

    # Rank
    rank_box = slide.shapes.add_textbox(Inches(1.0), Inches(y_pos + 0.15), Inches(0.5), Inches(0.7))
    rank_frame = rank_box.text_frame
    rank_frame.text = f"#{i+1}"
    rank_para = rank_frame.paragraphs[0]
    rank_para.font.size = Pt(32)
    rank_para.font.color.rgb = ACCENT_COLOR
    rank_para.alignment = PP_ALIGN.CENTER

    # Vulnerability name
    name_box = slide.shapes.add_textbox(Inches(1.8), Inches(y_pos + 0.25), Inches(6.5), Inches(0.5))
    name_frame = name_box.text_frame
    name_frame.text = name
    name_para = name_frame.paragraphs[0]
    name_para.font.size = Pt(14)
    name_para.font.bold = True
    name_para.font.color.rgb = TEXT_PRIMARY

    # Severity badge
    severity_box = slide.shapes.add_textbox(Inches(8.5), Inches(y_pos + 0.25), Inches(1.2), Inches(0.4))
    severity_frame = severity_box.text_frame
    severity_frame.text = severity
    severity_para = severity_frame.paragraphs[0]
    severity_para.font.size = Pt(11)
    severity_para.font.bold = True
    severity_para.font.color.rgb = CRITICAL_COLOR if severity == "CRITICAL" else WARNING_COLOR
    severity_para.alignment = PP_ALIGN.CENTER

    # Assets count
    assets_box = slide.shapes.add_textbox(Inches(10.0), Inches(y_pos + 0.15), Inches(0.8), Inches(0.7))
    assets_frame = assets_box.text_frame
    assets_frame.text = f"{assets}\nAssets"
    for para in assets_frame.paragraphs:
        para.font.size = Pt(16) if "Assets" not in para.text else Pt(9)
        para.font.color.rgb = TEXT_PRIMARY if "Assets" not in para.text else TEXT_SECONDARY
        para.alignment = PP_ALIGN.CENTER

    # Teams count
    teams_box = slide.shapes.add_textbox(Inches(11.0), Inches(y_pos + 0.15), Inches(0.8), Inches(0.7))
    teams_frame = teams_box.text_frame
    teams_frame.text = f"{teams}\nTeams"
    for para in teams_frame.paragraphs:
        para.font.size = Pt(16) if "Teams" not in para.text else Pt(9)
        para.font.color.rgb = TEXT_PRIMARY if "Teams" not in para.text else TEXT_SECONDARY
        para.alignment = PP_ALIGN.CENTER

# Save
output_path = "/Users/cedson/Documents/GitHub/tenable-leaderboard/Tenable_Exposure_Leaderboard.pptx"
prs.save(output_path)
print(f"✅ PowerPoint generated: {output_path}")

PYTHON_SCRIPT

deactivate
PYTHON_SCRIPT