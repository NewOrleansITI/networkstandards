# Switch Specifications

*Last Updated: February 2026*

## Overview

This document defines the approved network switch models and configuration requirements for City of New Orleans facilities.

## Approved Switch Models

### Access Layer Switches

| Model | Ports | PoE | Use Case | Status |
|-------|-------|-----|----------|--------|
| [Model TBD] | 24/48 | PoE+ | Standard office deployment | Approved |
| [Model TBD] | 24/48 | PoE++ | High-power devices (PTZ cameras, APs) | Approved |

### Distribution/Core Switches

| Model | Capacity | Use Case | Status |
|-------|----------|----------|--------|
| [Model TBD] | 10GbE+ | MDF core switching | Approved |
| [Model TBD] | 10GbE+ | IDF aggregation | Approved |

> **Note:** Update this section with your organization's approved models.

## Minimum Requirements

### Access Layer Switches

- Gigabit Ethernet on all ports
- PoE+ (802.3at, 30W per port) minimum
- 10GbE uplinks (SFP+ or dedicated)
- Layer 2+ features (VLANs, LACP, spanning tree)
- SNMP v3 support
- 802.1X port-based authentication
- Management interface (CLI, web GUI, or both)

### Distribution/Core Switches

- 10GbE or higher port speeds
- Layer 3 routing capability
- Redundant power supplies
- Hot-swappable fans
- Stacking or VSS capability (if applicable)
- OSPF/BGP support

## Configuration Baseline

### Required Security Settings

```
! Example configuration (adjust for your platform)
!
! Disable unused services
no ip http server
no ip finger
no ip bootp server

! Enable secure management
ip ssh version 2
transport input ssh

! Port security baseline
switchport port-security maximum 2
switchport port-security violation restrict
switchport port-security aging time 120
```

### VLAN Configuration

See [Port Configurations](port-configurations.md) for standard VLAN assignments.

### Spanning Tree

- Mode: Rapid PVST+ or MST
- Enable BPDU Guard on all access ports
- Enable Root Guard on distribution uplinks

## Management Requirements

| Requirement | Standard |
|-------------|----------|
| Management VLAN | VLAN [TBD] |
| SNMP | v3 with authentication and encryption |
| Syslog | Forward to central syslog server |
| NTP | Sync to city NTP servers |
| Authentication | RADIUS/TACACS+ for admin access |

## Lifecycle

| Phase | Timeframe |
|-------|-----------|
| Approved for new deployment | 0-5 years from purchase |
| Maintenance only | 5-7 years |
| End of life/replacement | 7+ years |

---

*For questions about these standards, open an issue or contact the ITI Networking Team.*
