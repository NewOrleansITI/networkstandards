# WiFi Design Standards - Design Document

**Date:** 2026-02-02
**Status:** Implemented
**Document:** `docs/wifi/design-standards.md`

## Summary

Created a new WiFi Design Standard document to establish mandatory requirements for wireless network design in City of New Orleans facilities. This fills a gap in the existing documentation—hardware specs, deployment procedures, and SSID standards existed, but no formal pre-design requirements.

## Key Design Decisions

### Coverage Requirements
- **-67 dBm secondary coverage**: Every location served by at least 2 APs at -67 dBm minimum
- **25 dB SNR minimum**: Ensures usable signal quality, not just signal strength
- **Uniform application**: All municipal buildings regardless of type or size

### Floor Plan Submission
- CAD (DWG/DXF) preferred for accuracy
- PDF acceptable for older buildings
- Other formats require special approval

### Design Deliverables (Minimal)
- Floor plans per floor
- Heat maps showing -67 dBm secondary coverage
- Proposed AP locations

### Review SLA
- 15 business days: Standard buildings (<50k sq ft, typical office)
- 20 business days: Complex buildings (≥50k sq ft OR high-density OR challenging RF)

### Validation Survey
- Mandatory for all deployments regardless of size
- Confirms as-built meets design requirements

### Remediation Process
- Failed areas documented with measurements
- Two paths: change order (fix it) OR formal exception (accept with IT management approval)
- Exceptions require written justification and audit trail

### High-Density Spaces (50+ concurrent users)
- 30 users/AP maximum
- 5 Mbps/user minimum bandwidth
- Capacity analysis required in addition to coverage

## Standards Referenced
- IEEE 802.11-2020, 802.11be-2024
- BICSI TDMM 14th Edition
- TIA-569-E, ANSI/TIA-1179
- NIST SP 800-153

## TCO Justification
- 31% reduction in 7-year TCO vs. ad-hoc deployments
- Payback period: 2-3 years
- Eliminates single-point-of-failure risk with secondary coverage
