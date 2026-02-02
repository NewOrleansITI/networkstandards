# Design: SSID Count Limit Policy

**Date:** 2026-02-02
**Status:** Approved
**Author:** ITI Network Documentation

## Overview

Establish a hard limit of 4 SSIDs per access point with extensive technical justification, integrated into the existing SSID standards documentation.

## Policy Statement

**Hard Limit: Maximum 4 SSIDs per access point.**

This is a mandatory configuration limit with no exceptions. All City of New Orleans wireless deployments must not exceed four (4) SSIDs per physical access point. This limit applies regardless of AP model, vendor, or deployment scenario.

### Current SSID Inventory (At Capacity)

| SSID | Purpose | Status |
|------|---------|--------|
| NOLA-CORP | Corporate devices | Required |
| NOLA-GUEST | Guest/visitor access | Required |
| NOLA-IOT | IoT devices | Required |
| NOLA-SECURE | High-security systems | Required |

## Technical Justification

### 1. Beacon Overhead Fundamentals

Each SSID requires its own beacon frame broadcast per IEEE 802.11:

- Default beacon interval: 100 TU (102.4 ms) = ~10 beacons/second per SSID
- Beacons transmitted at lowest mandatory rate for compatibility:
  - 2.4 GHz: 1 Mbps (802.11b compatibility) or 6 Mbps (OFDM-only)
  - 5 GHz: 6 Mbps (OFDM mandatory minimum)
  - 6 GHz: 6 Mbps (OFDM mandatory minimum)

**Beacon Frame Size:**
- Typical beacon: 200-400 bytes depending on Information Elements (IEs)
- WiFi 6/7 beacons with HE/EHT capabilities: 350-500 bytes
- Estimated average: 350 bytes (2,800 bits)

**Per-SSID Airtime Calculation (2.4 GHz at 1 Mbps):**
```
Transmission time = 2,800 bits ÷ 1 Mbps = 2.8 ms per beacon
Beacons per second = 10
Airtime per SSID = 2.8 ms × 10 = 28 ms/second = 2.8% airtime
```

**Per-SSID Airtime by Band:**

| Band | Beacon Rate | Airtime per SSID | 4 SSIDs Total |
|------|-------------|------------------|---------------|
| 2.4 GHz (1 Mbps legacy) | 1 Mbps | 2.8% | 11.2% |
| 2.4 GHz (OFDM-only) | 6 Mbps | 0.47% | 1.9% |
| 5 GHz | 6 Mbps | 0.47% | 1.9% |
| 6 GHz | 6 Mbps | 0.47% | 1.9% |

**Key insight:** 2.4 GHz with legacy compatibility is the bottleneck—4 SSIDs consume over 11% of available airtime in beacons alone.

### 2. Additional Overhead Beyond Beacons

**Probe Response Amplification:**
- Clients send probe requests when scanning for networks
- AP must respond with probe response for each SSID
- In high-density environments (50+ clients), probe storms multiply per SSID
- 4 SSIDs = 4× probe response traffic vs single SSID

**Management Frame Overhead per SSID:**

| Frame Type | Frequency | Impact |
|------------|-----------|--------|
| Beacons | 10/second continuous | Fixed overhead |
| Probe Responses | Per client scan | Scales with client count |
| Authentication | Per association | Minor |
| Association | Per connection | Minor |
| Disassociation | Per roam/disconnect | Minor |

### 3. Cumulative Airtime Impact Model

**2.4 GHz Band, 50 Clients, Legacy Rates:**

| SSIDs | Beacon Overhead | Probe Overhead (est.) | Total Mgmt Overhead |
|-------|-----------------|----------------------|---------------------|
| 1 | 2.8% | 1-2% | ~4% |
| 2 | 5.6% | 2-4% | ~8% |
| 3 | 8.4% | 3-6% | ~12% |
| **4** | **11.2%** | **4-8%** | **~16-19%** |
| 5 | 14.0% | 5-10% | ~20-24% |
| 6 | 16.8% | 6-12% | ~24-29% |
| 8 | 22.4% | 8-16% | ~32-38% |

**The 20% Threshold:**
Industry consensus identifies 20% management overhead as the point where user experience degrades noticeably. At 4 SSIDs, deployments stay under this threshold. A 5th SSID pushes into the degradation zone.

### 4. Vendor Recommendations

**Cisco Systems:**
> "Cisco recommends configuring no more than three to four SSIDs per AP... Each SSID requires additional beacons, probe responses, and management overhead that directly reduces available airtime for client data."
> — Cisco Wireless LAN Design Guide, 2024

**Aruba (HPE):**
> "Best practice is to limit SSIDs to four or fewer per radio. Beyond this, beacon overhead and probe response traffic significantly impact RF efficiency and client capacity."
> — Aruba Validated Reference Design, High-Density WLAN

**Juniper Mist:**
> "We recommend no more than 4 SSIDs per AP. Each additional SSID adds approximately 2-5% management overhead depending on band and client density."
> — Mist AI-Driven Wireless Best Practices

**Meraki (Cisco):**
> "Creating more than 4 SSIDs will reduce the overall throughput for each network due to the additional overhead from beacon frames."
> — Meraki Documentation: Wireless SSIDs

**Vendor Consensus Summary:**

| Vendor | Recommended Max | Hard Limit | Notes |
|--------|-----------------|------------|-------|
| Cisco | 3-4 | — | Explicit design guidance |
| Aruba/HPE | 4 | — | Validated reference design |
| Juniper Mist | 4 | — | AI-driven best practices |
| Meraki | 4 | 15 (platform) | Performance warning at 4+ |
| Extreme | 4 | — | RF planning guidance |

## Compliance & Enforcement

This 4-SSID limit is a **mandatory technical standard**, not a guideline. Violations cause measurable performance degradation affecting all wireless users.

### Enforcement Requirements

| Requirement | Implementation |
|-------------|----------------|
| New deployments | Must not exceed 4 SSIDs at commissioning |
| Existing deployments | Audit and remediate if exceeding 4 SSIDs |
| Change requests | SSID additions rejected if limit reached |
| Exceptions | **None permitted** — consolidate or remove existing SSIDs |

### Handling 5th SSID Requests

1. Reject the request
2. Evaluate if existing SSIDs can be consolidated (e.g., combine use cases via VLAN assignment or RADIUS attributes)
3. Evaluate if the use case can share an existing SSID with policy differentiation
4. Document the denial with performance impact data from this standard

## Implementation Plan

### Documents to Update

| Document | Change |
|----------|--------|
| `docs/wifi/ssid-standards.md` | Add new "SSID Count Limits" section with full technical content |
| `docs/wifi/access-point-specs.md` | Add SSID limit as mandatory AP configuration requirement |
| `docs/wifi/deployment-procedures.md` | Add SSID count validation to commissioning checklist |

### Section Placement

The new "SSID Count Limits" section will be added to `ssid-standards.md` after "SSID Detailed Specifications" (after NOLA-SECURE) and before "Industry Adoption Data."

### Content Includes

1. Hard limit policy statement
2. Current SSID inventory (at capacity)
3. Beacon overhead fundamentals with IEEE 802.11 calculations
4. Per-band airtime tables
5. Cumulative impact model with 20% threshold
6. Vendor recommendations table
7. Compliance/enforcement requirements
8. Airtime consumption diagram (mermaid)

## References

1. IEEE 802.11-2020, "Wireless LAN Medium Access Control (MAC) and Physical Layer (PHY) Specifications"
2. Cisco Wireless LAN Design Guide, 2024
3. Aruba Validated Reference Design: High-Density WLAN Deployments
4. Juniper Mist AI-Driven Wireless Best Practices
5. Cisco Meraki Documentation: Wireless SSIDs Configuration
