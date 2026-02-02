# RFC-NNNN: [Title]

**RFC Number:** RFC-NNNN (assigned by maintainer)  
**Title:** [Descriptive title]  
**Author(s):** [Name(s) and GitHub handle(s)]  
**Status:** Draft | Discussion | Review | Accepted | Rejected | Implemented  
**Created:** YYYY-MM-DD  
**Discussion Period Ends:** YYYY-MM-DD (30 days from Discussion start)  
**Last Updated:** YYYY-MM-DD

---

## Abstract

[2-3 sentence summary of what this RFC proposes]

---

## Motivation

[Why is this change needed? What problem does it solve?]

---

## Standards Reference

| Attribute | Value |
|-----------|-------|
| **Governing Body** | [IEEE / ANSI / TIA / IETF / ISO / NIST] |
| **Standard Number** | [e.g., IEEE 802.3bt-2018] |
| **Standard Title** | [Official title] |
| **Ratification Date** | [YYYY-MM-DD] |
| **Supersedes** | [Previous standard, if any] |
| **Superseded By** | [Newer standard, if any — N/A if current] |

---

## Industry Adoption

[Provide statistics on current industry adoption]

| Source | Statistic | Date |
|--------|-----------|------|
| [Survey/Report name] | [X% adoption] | [YYYY] |
| [Survey/Report name] | [X% adoption] | [YYYY] |

### Adoption Trend

```mermaid
xychart-beta
    title "Industry Adoption Over Time"
    x-axis [2020, 2021, 2022, 2023, 2024, 2025]
    y-axis "Adoption %" 0 --> 100
    line [10, 25, 40, 55, 67, 75]
```

---

## Cost-Performance Analysis

### Assumptions

- Deployment size: [X] units
- Lifecycle period: [X] years
- Labor rate: [Municipal average or specific rate]
- Power cost: [$X.XX/kWh]

### Comparison

| Cost Category | Current Standard | Proposed Standard | Difference |
|---------------|------------------|-------------------|------------|
| Equipment cost | $X | $X | +/-X% |
| Installation | $X | $X | +/-X% |
| Annual power | $X | $X | +/-X% |
| Annual maintenance | $X | $X | +/-X% |
| Refresh cycle (year) | X | X | +/-X years |
| **15-Year TCO** | **$X** | **$X** | **+/-X%** |
| **TCO/unit/year** | **$X** | **$X** | **+/-X%** |

### TCO Visualization

```mermaid
pie title 15-Year TCO Breakdown (Proposed Standard)
    "Equipment" : 35
    "Installation" : 15
    "Power" : 25
    "Maintenance" : 20
    "Refresh" : 5
```

---

## Security Implications

### Security Comparison

| Security Feature | Current Standard | Proposed Standard |
|------------------|------------------|-------------------|
| [Feature 1] | [Yes/No/Level] | [Yes/No/Level] |
| [Feature 2] | [Yes/No/Level] | [Yes/No/Level] |
| [Feature 3] | [Yes/No/Level] | [Yes/No/Level] |

### NIST Alignment

[Describe how this standard aligns with relevant NIST guidelines]

| NIST Reference | Requirement | Compliance |
|----------------|-------------|------------|
| [SP 800-XX] | [Requirement] | ✅ / ⚠️ / ❌ |

### Known Vulnerabilities

[List any known vulnerabilities in the proposed standard and mitigations]

---

## Reliability Considerations

| Metric | Current Standard | Proposed Standard |
|--------|------------------|-------------------|
| Expected MTBF | [X hours] | [X hours] |
| Failure rate | [X%/year] | [X%/year] |
| Redundancy support | [Yes/No] | [Yes/No] |
| Failover time | [Xms] | [Xms] |

---

## Backwards Compatibility

[Describe compatibility with existing infrastructure]

### Migration Path

```mermaid
flowchart LR
    A[Current State] --> B[Phase 1:<br/>Assessment]
    B --> C[Phase 2:<br/>Pilot Deployment]
    C --> D[Phase 3:<br/>Gradual Rollout]
    D --> E[Phase 4:<br/>Full Adoption]
    E --> F[Legacy<br/>Decommission]
```

### Coexistence Period

[How long can current and proposed standards coexist?]

---

## Implementation Plan

### Timeline

```mermaid
gantt
    title Implementation Timeline
    dateFormat  YYYY-MM-DD
    section Preparation
    Documentation update    :a1, 2026-01-01, 14d
    Training materials      :a2, after a1, 14d
    section Deployment
    Pilot sites            :b1, after a2, 30d
    Evaluation             :b2, after b1, 14d
    Full rollout           :b3, after b2, 60d
```

### Resource Requirements

| Resource | Quantity | Notes |
|----------|----------|-------|
| Staff training hours | X | [Details] |
| Documentation updates | X pages | [Details] |
| Testing equipment | X | [Details] |

---

## Diagrams

### Architecture Diagram

```mermaid
graph TB
    subgraph CURRENT["Current Architecture"]
        %% Add current state diagram
    end
    
    subgraph PROPOSED["Proposed Architecture"]
        %% Add proposed state diagram
    end
```

### [Additional Diagrams as Needed]

[Add any other diagrams that help explain the proposal]

---

## References

1. [Standard body], "[Standard title]," [Standard number], [Year]. [URL if available]
2. [Author], "[Article/Report title]," [Publication], [Year]. [URL if available]
3. [Organization], "[Survey/Report title]," [Year]. [URL if available]

---

## Changelog

| Date | Author | Changes |
|------|--------|---------|
| YYYY-MM-DD | [Author] | Initial draft |

---

## Discussion

[This section will be populated during the Discussion phase with community feedback summaries]

### Community Feedback Summary

| Feedback Theme | Count | Resolution |
|----------------|-------|------------|
| [Theme 1] | X | [How addressed] |
| [Theme 2] | X | [How addressed] |

---

## Decision

**Status:** [Accepted / Rejected]  
**Decision Date:** YYYY-MM-DD  
**Decision Maker:** [Maintainer name]

### Rationale

[Explanation of why the RFC was accepted or rejected]

### Conditions (if any)

[Any conditions or modifications required for acceptance]

---

*RFC template version 1.0.0 — City of New Orleans Network Standards*
