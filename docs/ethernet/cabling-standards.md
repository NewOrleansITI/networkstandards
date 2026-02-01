# Cabling Standards

*Last Updated: February 2026*

## Overview

This document defines the cabling standards for all wired network infrastructure in City of New Orleans facilities.

## Approved Cable Types

### Horizontal Cabling (Workstation to IDF)

| Category | Use Case | Maximum Distance | Required For |
|----------|----------|------------------|--------------|
| Cat6A | Standard deployments | 100 meters | New installations |
| Cat6 | Legacy/budget-constrained | 100 meters | Existing infrastructure only |

**Note:** Cat5e is no longer approved for new installations.

### Backbone Cabling (IDF to MDF)

| Type | Use Case | Maximum Distance |
|------|----------|------------------|
| Single-mode fiber (OS2) | Between buildings | Up to 10 km |
| Multi-mode fiber (OM4) | Within building | Up to 400 meters |

## Installation Requirements

### Cable Routing
- Maintain minimum bend radius per manufacturer specifications
- Separate from electrical cables by minimum 12 inches
- Use cable management in all telecommunications rooms
- Label both ends of every cable run

### Termination Standards
- All jacks: T568B wiring standard
- Patch panels: 110-style punch-down or tool-less keystone
- Test all runs with cable certifier before acceptance

### Labeling Convention

```
[Building Code]-[Floor]-[Room]-[Jack Number]
Example: CH-02-205-04
```

| Component | Format | Example |
|-----------|--------|---------|
| Building Code | 2-4 characters | CH (City Hall) |
| Floor | 2 digits | 02 |
| Room | 3-4 digits | 205 |
| Jack Number | 2 digits | 04 |

## Testing Requirements

All cable runs must pass the following tests before acceptance:

- [ ] Wire map (correct pin-to-pin connectivity)
- [ ] Length verification (within maximum distance)
- [ ] Insertion loss (attenuation)
- [ ] NEXT (Near-End Crosstalk)
- [ ] Return loss

**Certification:** Provide Fluke or equivalent test results for all runs.

## References

- TIA-568-C.2 Commercial Building Telecommunications Cabling Standard
- TIA-569-D Telecommunications Pathways and Spaces
- BICSI TDMM (Telecommunications Distribution Methods Manual)

---

*For questions about these standards, open an issue or contact the ITI Networking Team.*
