# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

City of New Orleans Network Standards Repository - a vendor-neutral, open-source reference for municipal network infrastructure standards. All documentation uses Markdown with Mermaid diagrams.

## Critical Rules

### Absolute Requirements
1. **NO vendor names** - Never mention Cisco, Juniper, Aruba, HP, Dell, Meraki, or any manufacturer/product. Use generic terms: "enterprise-class managed switch", "Layer 3 capable switch"
2. **Public standards bodies only** - IEEE, ANSI, TIA, IETF, ISO, NIST, BICSI. No vendor whitepapers or paid analyst reports (Gartner, IDC)
3. **Prove every standard** - Every recommendation must include: ratification date, industry adoption statistics (with sources), and cost-performance/TCO analysis

### Expert Perspective
Write from the viewpoint of a 40-year networking veteran optimizing for municipal price/performance. Prioritize: security > reliability > cost-effectiveness > features. Consider 15+ year lifecycles.

## Documentation Standards

Every standards document must include:
- Standard reference (IEEE/ANSI/TIA number)
- Ratification date
- Industry adoption statistics with citations
- TCO analysis
- Security implications (NIST alignment)
- Mermaid diagrams for visualization

Document header format:
```markdown
---
title: [Title]
version: X.Y.Z
status: Supported | Legacy | Deprecated
last_updated: YYYY-MM-DD
ieee_reference: [Standard number]
---
```

## File Structure

- `rfcs/` - RFC proposals (use RFC-TEMPLATE.md)
- `docs/` - Standards documentation organized by layer/topic
- Issue templates: `standard-proposal.md`, `clarification-request.md`, `security-concern.md`

## RFC Process

New standards require an RFC before implementation:
1. Create RFC using RFC-TEMPLATE.md
2. 30-day discussion period minimum
3. Team review and maintainer approval
4. Implementation PR references the accepted RFC

## Key References

- `PRD.md` - Full project requirements, governance model, timeline
- `AI_ASSISTANT_GUIDELINES.md` - Detailed rules for AI interactions, diagrams, response templates
- `RFC-TEMPLATE.md` - Required structure for RFC proposals
- `SKILLS_AND_MCP_RECOMMENDATIONS.md` - Team skills assessment and automation recommendations
