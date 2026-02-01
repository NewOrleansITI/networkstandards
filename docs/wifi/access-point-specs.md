# Access Point Specifications

*Last Updated: February 2026*

## Overview

This document defines the approved wireless access point models and placement guidelines for City of New Orleans facilities.

## Approved Access Point Models

### Indoor Access Points

| Model | WiFi Standard | Use Case | PoE Requirement | Status |
|-------|---------------|----------|-----------------|--------|
| [Model TBD] | WiFi 6 (802.11ax) | Standard office | PoE+ (802.3at) | Approved |
| [Model TBD] | WiFi 6E (802.11ax) | High-density areas | PoE++ (802.3bt) | Approved |

### Outdoor Access Points

| Model | WiFi Standard | Use Case | Status |
|-------|---------------|----------|--------|
| [Model TBD] | WiFi 6 | Building exterior, covered areas | Approved |
| [Model TBD] | WiFi 6 | Parks, open areas | Approved |

> **Note:** Update this section with your organization's approved models.

## Minimum Requirements

### All Access Points

- WiFi 6 (802.11ax) minimum for new deployments
- Dual-band (2.4 GHz and 5 GHz)
- 2x2 MIMO minimum
- WPA3 support
- 802.1X authentication support
- Centralized management (cloud or on-premise controller)
- SNMP v3 support

### High-Density Environments

- WiFi 6E (6 GHz band) preferred
- 4x4 MIMO or higher
- 2.5GbE or higher uplink port
- Multi-user MIMO (MU-MIMO)
- OFDMA support

## Placement Guidelines

### Coverage Standards

| Environment | Target RSSI | Channel Width |
|-------------|-------------|---------------|
| Office/cubicle | -65 dBm or better | 40 MHz (5 GHz) |
| Conference room | -60 dBm or better | 40 MHz (5 GHz) |
| Public area/lobby | -67 dBm or better | 20/40 MHz |
| Outdoor | -70 dBm or better | 20 MHz |

### Mounting Requirements

- Standard height: 9-12 feet (2.7-3.6 meters)
- Orientation: Antennas facing down toward user area
- Avoid placement near metal objects, ducts, or electrical equipment
- Maintain minimum 50-foot separation between APs (adjust based on survey)

### Site Survey Requirement

**All new deployments require a predictive or active site survey** including:

1. Heat maps showing predicted/measured coverage
2. Channel plan with non-overlapping channels
3. AP placement coordinates
4. Interference analysis

## Power Requirements

| AP Type | PoE Standard | Power Draw | Switch Requirement |
|---------|--------------|------------|-------------------|
| Standard indoor | 802.3at (PoE+) | 15-25W | PoE+ capable switch |
| High-performance | 802.3bt (PoE++) | 25-40W | PoE++ capable switch |
| Outdoor | 802.3at/bt | 15-30W | PoE+ minimum |

**Note:** Always verify power requirements before deployment. Insufficient PoE may result in reduced functionality.

## Antenna Considerations

- **Internal antenna:** Standard for most indoor deployments
- **External antenna:** Required for specialized coverage patterns or outdoor long-range
- Document antenna type and orientation in deployment records

---

*For questions about these standards, open an issue or contact the ITI Networking Team.*
