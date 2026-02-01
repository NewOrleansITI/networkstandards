# Port Configurations

*Last Updated: February 2026*

## Overview

This document defines standard VLAN assignments, port configurations, and naming conventions for network switch ports across City of New Orleans facilities.

## VLAN Assignments

### Standard VLANs

| VLAN ID | Name | Purpose | IP Range |
|---------|------|---------|----------|
| 1 | default | Unused (disabled) | N/A |
| 10 | MGMT | Network management | [TBD] |
| 20 | CORP | Corporate workstations | [TBD] |
| 30 | VOIP | Voice over IP phones | [TBD] |
| 40 | PRINT | Printers and MFPs | [TBD] |
| 50 | SECURE | Secure/restricted systems | [TBD] |
| 100 | GUEST | Guest WiFi breakout | [TBD] |
| 200 | IOT | IoT devices and sensors | [TBD] |
| 300 | CAMERA | Security cameras | [TBD] |
| 999 | QUARANTINE | Quarantined/unknown devices | [TBD] |

> **Note:** Update IP ranges based on your network addressing plan.

## Port Configuration Templates

### Standard Workstation Port

```
interface GigabitEthernet1/0/X
 description [Building]-[Room]-[Jack]
 switchport mode access
 switchport access vlan 20
 switchport voice vlan 30
 spanning-tree portfast
 spanning-tree bpduguard enable
 switchport port-security maximum 3
 switchport port-security violation restrict
```

### VoIP Phone Only

```
interface GigabitEthernet1/0/X
 description VOIP-[Building]-[Room]
 switchport mode access
 switchport access vlan 30
 spanning-tree portfast
 spanning-tree bpduguard enable
 switchport port-security maximum 1
```

### Printer Port

```
interface GigabitEthernet1/0/X
 description PRINT-[Building]-[Room]
 switchport mode access
 switchport access vlan 40
 spanning-tree portfast
 spanning-tree bpduguard enable
 switchport port-security maximum 1
 switchport port-security mac-address sticky
```

### Access Point Port

```
interface GigabitEthernet1/0/X
 description AP-[Building]-[Location]
 switchport mode trunk
 switchport trunk native vlan 10
 switchport trunk allowed vlan 10,20,30,100
 spanning-tree portfast trunk
 spanning-tree bpduguard enable
```

### Uplink Port (to Distribution)

```
interface TenGigabitEthernet1/1/X
 description UPLINK-[Destination Switch]
 switchport mode trunk
 switchport trunk allowed vlan all
 channel-group X mode active
```

## Port Naming Convention

### Description Format

```
[Type]-[Building]-[Location/Room]-[Detail]
```

| Type Code | Meaning |
|-----------|---------|
| WS | Workstation |
| VOIP | Voice phone |
| PRINT | Printer |
| AP | Access point |
| CAM | Security camera |
| UPLINK | Uplink to distribution |
| ISL | Inter-switch link |

### Examples

- `WS-CH-205-04` — Workstation, City Hall, Room 205, Jack 4
- `AP-LIB-MAIN-LOBBY` — Access point, Library, Main Lobby
- `UPLINK-CH-MDF-SW01` — Uplink to City Hall MDF Switch 01

## Unused Ports

All unused ports must be:

1. Administratively disabled (`shutdown`)
2. Assigned to VLAN 999 (QUARANTINE)
3. Documented in port inventory

```
interface GigabitEthernet1/0/X
 description UNUSED
 switchport mode access
 switchport access vlan 999
 shutdown
```

---

*For questions about these standards, open an issue or contact the ITI Networking Team.*
