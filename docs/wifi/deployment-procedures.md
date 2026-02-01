# WiFi Deployment Procedures

*Last Updated: February 2026*

## Overview

This document defines the standard procedures for deploying wireless networks in City of New Orleans facilities, from initial survey through final handoff.

## Deployment Phases

1. [Site Survey](#1-site-survey)
2. [Design and Planning](#2-design-and-planning)
3. [Installation](#3-installation)
4. [Configuration](#4-configuration)
5. [Validation Testing](#5-validation-testing)
6. [Documentation and Handoff](#6-documentation-and-handoff)

---

## 1. Site Survey

### Pre-Survey Requirements

- [ ] Obtain floor plans (CAD or PDF)
- [ ] Identify coverage requirements and user density
- [ ] Schedule site visit with facility contact
- [ ] Review existing infrastructure (ethernet drops, ceiling access)

### Survey Activities

#### Predictive Survey (New Construction)

- Import floor plans into survey software
- Define wall materials and attenuation values
- Place virtual APs based on coverage requirements
- Generate heat maps for review

#### Active Survey (Existing Buildings)

- Walk the facility with survey equipment
- Measure existing WiFi and interference
- Identify RF challenges (metal structures, competing networks)
- Document mounting locations and cable paths

### Survey Deliverables

- [ ] Coverage heat maps (2.4 GHz and 5 GHz)
- [ ] AP placement map with coordinates
- [ ] Channel plan
- [ ] Interference report
- [ ] Bill of materials (AP models, mounting hardware, cabling)

---

## 2. Design and Planning

### Design Review Checklist

- [ ] AP count meets coverage and capacity requirements
- [ ] Ethernet drops available or planned for each AP location
- [ ] PoE budget verified on switches
- [ ] Channel plan avoids co-channel interference
- [ ] SSID and VLAN design follows [SSID Standards](ssid-standards.md)
- [ ] Security requirements defined

### Approval Process

1. Submit design to ITI Networking Team for review
2. Address any feedback or required changes
3. Obtain written approval before proceeding
4. Schedule installation window

---

## 3. Installation

### Pre-Installation Checklist

- [ ] All equipment received and verified
- [ ] Network ports active and tested
- [ ] Ceiling/wall access confirmed
- [ ] Installation window confirmed with facility

### Mounting Standards

| Location | Mount Type | Height |
|----------|------------|--------|
| Drop ceiling | T-bar clip or above-tile | 9-12 ft |
| Hard ceiling | Direct mount or junction box | 9-12 ft |
| Wall | Wall bracket | 8-10 ft |
| Outdoor | Pole or wall mount | Per design |

### Cabling Requirements

- Use Cat6A cabling per [Cabling Standards](../ethernet/cabling-standards.md)
- Label cables at both ends
- Leave service loop at AP location
- Secure cables with proper management

### Installation Checklist

- [ ] AP mounted at correct location and orientation
- [ ] Ethernet cable connected and tested
- [ ] AP powered on and LED indicates normal operation
- [ ] AP appears in wireless management system
- [ ] Physical installation documented (photos)

---

## 4. Configuration

### Controller/Cloud Setup

1. Add AP to management platform
2. Assign to correct site/building/floor
3. Apply configuration profile:
   - SSIDs per [SSID Standards](ssid-standards.md)
   - RF settings per design
   - Security policies

### Per-AP Configuration

- [ ] AP name follows naming convention: `AP-[Building]-[Location]`
- [ ] Correct SSIDs assigned
- [ ] Channel and power settings applied (or auto-optimization enabled)
- [ ] VLAN tagging verified
- [ ] Management IP assigned

### Verification

- [ ] AP online in management system
- [ ] All SSIDs broadcasting (where applicable)
- [ ] Clients can connect to each SSID
- [ ] VLAN assignment correct (verify client IP)
- [ ] 802.1X authentication functional (NOLA-CORP)
- [ ] Captive portal functional (NOLA-GUEST)

---

## 5. Validation Testing

### Coverage Validation

Perform post-installation survey to verify:

- [ ] RSSI meets target (-65 dBm or better for office areas)
- [ ] No dead zones or weak spots
- [ ] Channel interference within acceptable limits
- [ ] Roaming works between APs

### Performance Testing

| Test | Target | Tool |
|------|--------|------|
| Throughput | 100+ Mbps per client | iPerf or speed test |
| Latency | < 20 ms to gateway | Ping |
| Roaming | < 150 ms handoff | Roaming test app |
| Client capacity | Per design requirements | Load test |

### Security Testing

- [ ] Unauthorized SSIDs not broadcast
- [ ] Client isolation working (GUEST, IOT)
- [ ] RADIUS authentication logging
- [ ] Rogue AP detection enabled

---

## 6. Documentation and Handoff

### Required Documentation

- [ ] As-built drawings (AP locations, cable runs)
- [ ] AP inventory (serial numbers, MAC addresses, locations)
- [ ] Configuration backup
- [ ] Post-installation survey report
- [ ] Test results (coverage, performance, security)

### Handoff Checklist

- [ ] Documentation submitted to ITI Networking Team
- [ ] Management access transferred/shared
- [ ] Facility contact trained on basic troubleshooting
- [ ] Support escalation path documented
- [ ] 30-day post-deployment review scheduled

### Post-Deployment Review

Schedule a review 30 days after deployment to:

- Address any user-reported issues
- Review performance metrics
- Optimize RF settings if needed
- Close out deployment project

---

## Troubleshooting Quick Reference

| Issue | First Steps |
|-------|-------------|
| No connectivity | Verify AP powered, check uplink port, verify VLAN |
| Slow speeds | Check channel utilization, interference, client count |
| Authentication failure | Verify RADIUS, check certificates, review logs |
| Roaming issues | Check channel overlap, verify controller sync |

---

*For questions about these procedures, open an issue or contact the ITI Networking Team.*
