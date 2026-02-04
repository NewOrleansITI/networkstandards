# Design Document: Wireless Client Requirements

**Date:** 2026-02-04
**Status:** Approved
**Author:** Christopher J. Wolff

## Summary

New standards document establishing mandatory requirements for all wireless client devices on City of New Orleans networks. Consolidates client compatibility, procurement standards, and onboarding procedures into a single authoritative reference.

## Design Decisions

### 1. WPA3 Hard Cutoff (No Exceptions)

Devices without WPA3 are not permitted on any City SSID. No exception process, no waiver path, no tiered access for non-WPA3 devices. This is the strongest possible security posture and simplifies policy enforcement.

**Rationale:** A hard cutoff eliminates ambiguity and prevents security policy erosion through accumulated exceptions. Devices that cannot meet the requirement should use wired Ethernet as an alternative.

### 2. WiFi 7 Required for New Procurements

All newly purchased City wireless devices must support IEEE 802.11be (WiFi 7). Existing WPA3-capable devices with older WiFi generations remain permitted until end-of-life. BYOD devices are exempt from WiFi 7 requirement but must still support WPA3.

**Rationale:** Mirrors the AP-side WiFi 7 mandate. Ensures the City's device fleet can take full advantage of MLO, 320 MHz channels, and other WiFi 7 capabilities as the infrastructure matures.

### 3. Dual Audience Document

The document serves both technical IT staff (detailed compatibility tables, configuration checklists) and non-technical stakeholders (executive summary, procurement checklist). The executive summary answers "will my device work?" in plain language.

### 4. IoT Coverage by Device Category

IoT/embedded devices organized by function (printers, cameras, building automation, etc.) with WPA3-capable chipset/protocol guidance per category. This maps to how procurement decisions are made.

### 5. Consolidated Client Configuration

All client-side settings (PMF, EAP-TLS, roaming, band preferences) consolidated into a single section with per-SSID onboarding checklists. Eliminates cross-referencing between 802.1X, WPA3, and deployment docs.

### 6. Procurement Pass/Fail Checklist

Binary pass/fail checklist with 9 items. All Required items must pass for procurement approval. Designed to be usable by non-technical procurement staff and printable for vendor discussions.

### 7. TLS 1.3 Minimum Standard

All EAP-TLS sessions require TLS 1.3 (RFC 8446) minimum. TLS 1.2 references corrected across existing documentation (802.1x-implementation.md, wpa3-enterprise.md).

## Document Structure

1. Executive Summary
2. Mandatory Requirements (with Mermaid decision flowchart)
3. Supported Operating Systems & Minimum Versions
4. Supported IoT/Embedded Device Categories
5. Client Configuration Requirements (consolidated onboarding reference)
6. Procurement Pass/Fail Checklist
7. NIST Alignment
8. Troubleshooting Guide
9. Industry Adoption Data
10. Cross-References, Document History, References

## Related Changes

| File | Change |
|------|--------|
| `docs/wifi/wireless-client-requirements.md` | New document |
| `docs/security/802.1x-implementation.md` | TLS 1.2 → TLS 1.3 minimum |
| `docs/security/wpa3-enterprise.md` | TLS 1.2 → TLS 1.3 minimum (3 instances) |
| `docs/index.md` | Added new document to WiFi section |
| `CLAUDE.md` | Added TLS 1.3 policy, WPA3 hard requirement, WiFi 7 procurement, standards currency rules |
| `/opt/networkdocumentation/scripts/standards-monitor.sh` | Daily standards monitoring script |
| Cron job | Daily 7:00 AM execution of monitoring script |

## Standards Compliance

All content references public standards bodies only (IEEE, Wi-Fi Alliance, IETF, NIST, NSA CNSA). No vendor-specific recommendations. Priority order maintained: security > reliability > cost-effectiveness > features.
