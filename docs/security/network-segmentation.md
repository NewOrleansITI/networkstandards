---
title: Network Segmentation Standards
version: 1.1.0
status: Supported
last_updated: 2026-02-04
ieee_reference: IEEE 802.1Q-2022
---

# Network Segmentation Standards

## Overview

This document establishes the City of New Orleans standards for network segmentation, defining how municipal networks are divided into security zones to contain threats, enforce access policies, and meet compliance requirements. Proper segmentation is foundational to defense-in-depth and zero trust architecture.

## Standards References

| Standard | Title | Ratification Date | Scope |
|----------|-------|-------------------|-------|
| IEEE 802.1Q-2022 | Bridges and Bridged Networks | December 2022 | VLAN tagging and bridging |
| IEEE 802.1X-2020 | Port-Based Network Access Control | February 2020 | Dynamic VLAN assignment |
| IEEE 802.1Qbv-2015 | Enhancements for Scheduled Traffic | March 2016 | Time-sensitive networking |
| IETF RFC 4364 | BGP/MPLS IP VPNs | February 2006 | VRF-based segmentation |
| IETF RFC 7432 | EVPN | February 2015 | Ethernet VPN |
| NIST SP 800-53 Rev. 5 | Security Controls | September 2020 | Federal security requirements |
| NIST SP 800-125B | Secure Virtual Network Configuration | March 2016 | Virtual network security |
| NIST SP 800-207 | Zero Trust Architecture | August 2020 | Zero trust principles |
| CISA Zero Trust Maturity Model | ZT Guidance | April 2023 | Federal zero trust |
| PCI DSS v4.0 | Payment Card Industry Standards | March 2022 | Cardholder data isolation |

## Segmentation Architecture

### Zone-Based Network Model

```mermaid
graph TB
    subgraph EXTERNAL["External Zone (Untrusted)"]
        INTERNET["Internet"]
        PARTNERS["Partner Networks"]
    end

    subgraph DMZ["DMZ Zone (Semi-Trusted)"]
        WEBSERVERS["Public Web Services"]
        EMAIL_GW["Email Gateway"]
        VPN_GW["VPN Gateway"]
    end

    subgraph INTERNAL["Internal Zones (Trusted)"]
        subgraph CORP["Corporate Zone"]
            WORKSTATIONS["Workstations<br/>VLAN 20"]
            VOIP["VoIP/UC<br/>VLAN 30"]
        end

        subgraph RESTRICTED["Restricted Zone"]
            SERVERS["Application Servers<br/>VLAN 40"]
            SECURE["High-Security Systems<br/>VLAN 50"]
        end

        subgraph IOT_ZONE["IoT Zone"]
            BUILDING["Building Systems<br/>VLAN 200"]
            SENSORS["Sensors/Cameras<br/>VLAN 210"]
        end

        subgraph GUEST_ZONE["Guest Zone"]
            GUEST["Guest WiFi<br/>VLAN 100"]
            KIOSK["Public Kiosks<br/>VLAN 110"]
        end
    end

    subgraph MGMT["Management Zone (Highest Trust)"]
        NETWORK_MGMT["Network Management<br/>VLAN 999"]
        SECURITY["Security Tools<br/>VLAN 998"]
    end

    INTERNET <-->|"Firewall"| DMZ
    DMZ <-->|"Firewall"| INTERNAL
    INTERNAL <-->|"ACL"| MGMT
    GUEST_ZONE -->|"Internet Only"| INTERNET
```

### VLAN Architecture

```mermaid
graph LR
    subgraph VLAN_RANGES["VLAN ID Allocation"]
        subgraph INFRA["Infrastructure (1-19)"]
            V1["VLAN 1: Native (unused)"]
            V10["VLAN 10: Infrastructure"]
        end

        subgraph USER["User Networks (20-99)"]
            V20["VLAN 20: Corporate"]
            V30["VLAN 30: VoIP"]
            V40["VLAN 40: Servers"]
            V50["VLAN 50: Restricted"]
        end

        subgraph GUEST_IOT["Guest/IoT (100-299)"]
            V100["VLAN 100: Guest"]
            V110["VLAN 110: Kiosks"]
            V200["VLAN 200: Building IoT"]
            V210["VLAN 210: Cameras"]
        end

        subgraph SPECIAL["Special Purpose (900-999)"]
            V998["VLAN 998: Security"]
            V999["VLAN 999: Management"]
        end
    end
```

## VLAN Standards

### VLAN Allocation Table

| VLAN ID | Name | Purpose | Security Zone | DHCP | 802.1X |
|---------|------|---------|---------------|------|--------|
| 1 | Native | Unused (disabled) | N/A | No | No |
| 10 | Infrastructure | Switch-to-switch links | Management | No | No |
| 20 | Corporate | City employee workstations | Corporate | Yes | Required |
| 30 | VoIP | IP phones and UC devices | Corporate | Yes | Required |
| 40 | Servers | Application servers | Restricted | No | MAB |
| 50 | Secure | High-security systems | Restricted | No | Required |
| 100 | Guest | Visitor wireless | Guest | Yes | Portal |
| 110 | Kiosk | Public access terminals | Guest | Yes | MAB |
| 200 | Building | HVAC, lighting, access control | IoT | Yes | MAB |
| 210 | Cameras | Surveillance systems | IoT | Yes | MAB |
| 998 | Security | SIEM, IDS/IPS, scanners | Management | No | Required |
| 999 | Management | Network device management | Management | No | Required |

### VLAN Design Principles

| Principle | Requirement | Rationale |
|-----------|-------------|-----------|
| Native VLAN | Disabled or unused | Prevent VLAN hopping |
| VLAN 1 | Never used for traffic | Security best practice |
| User VLANs | Separate by function/trust | Limit blast radius |
| IoT isolation | Dedicated VLANs | Contain compromised devices |
| Management VLAN | Restricted access | Protect control plane |
| Voice VLAN | QoS-enabled, separate | Ensure call quality |

## Security Zone Definitions

### Zone Trust Levels

```mermaid
graph TB
    subgraph TRUST_MODEL["Trust Level Hierarchy"]
        UNTRUST["UNTRUSTED<br/>Internet, Unknown"]
        SEMI["SEMI-TRUSTED<br/>DMZ, Partners"]
        USER_TRUST["USER-TRUSTED<br/>Corporate, Guest"]
        APP_TRUST["APPLICATION-TRUSTED<br/>Servers, Databases"]
        MGMT_TRUST["MANAGEMENT-TRUSTED<br/>Network Infrastructure"]
    end

    UNTRUST -->|"Strict filtering"| SEMI
    SEMI -->|"Application inspection"| USER_TRUST
    USER_TRUST -->|"Role-based access"| APP_TRUST
    APP_TRUST -->|"Admin only"| MGMT_TRUST
```

### Zone Specifications

#### External Zone (Untrusted)

| Attribute | Value |
|-----------|-------|
| Trust level | None |
| Traffic sources | Internet, unknown networks |
| Allowed inbound | Explicitly permitted services only |
| Inspection | Full (IPS, malware, DLP) |
| Logging | All traffic |

#### DMZ Zone (Semi-Trusted)

| Attribute | Value |
|-----------|-------|
| Trust level | Limited |
| Purpose | Public-facing services |
| Hosts | Web servers, email gateways, VPN concentrators |
| Internal access | Specific ports to specific hosts only |
| Internet access | Outbound restricted to required services |

#### Corporate Zone (Trusted)

| Attribute | Value |
|-----------|-------|
| Trust level | Standard |
| Purpose | Employee workstations and productivity |
| Access granted | Internal applications, internet (filtered) |
| Access denied | Direct server admin, management networks |
| 802.1X | Required |

#### Restricted Zone (High Trust)

| Attribute | Value |
|-----------|-------|
| Trust level | Elevated |
| Purpose | Sensitive applications and data |
| Access granted | Authorized users and applications only |
| Access denied | General corporate, guest, IoT |
| Additional controls | MFA, enhanced logging, DLP |

#### IoT Zone (Limited Trust)

| Attribute | Value |
|-----------|-------|
| Trust level | Minimal |
| Purpose | Connected devices (cameras, HVAC, sensors) |
| Access granted | Specific cloud services, management systems |
| Access denied | Corporate networks, internet (general) |
| Isolation | Client isolation enabled |

#### Guest Zone (Minimal Trust)

| Attribute | Value |
|-----------|-------|
| Trust level | Minimal |
| Purpose | Visitor internet access |
| Wireless security | **OWE (Enhanced Open)** — Mandatory 2026 |
| Encryption | AES-CCMP-128 (per-client unique keys) |
| Access granted | Internet only (filtered) |
| Access denied | All internal networks |
| Isolation | Full client isolation |

**OWE Requirement:** Guest wireless networks must use OWE (Opportunistic Wireless Encryption) to protect visitors from passive eavesdropping. See [OWE Enhanced Open Standards](owe-enhanced-open.md) for implementation details.

#### Management Zone (Maximum Trust)

| Attribute | Value |
|-----------|-------|
| Trust level | Maximum |
| Purpose | Network and security infrastructure |
| Access granted | Administrators only |
| Access denied | All non-admin traffic |
| Access method | Jump host or PAM required |

**UPS Management Interfaces:** All UPS SNMP management cards and network-connected power management devices must be placed on the Management VLAN (VLAN 999). UPS monitoring traffic must not traverse user or guest networks. See [Backup Power Standards](../ethernet/backup-power-standards.md) for UPS SNMP monitoring requirements.

## Inter-Zone Traffic Policies

### Traffic Flow Matrix

```mermaid
flowchart LR
    subgraph SOURCES["Source Zones"]
        S_EXT["External"]
        S_DMZ["DMZ"]
        S_CORP["Corporate"]
        S_REST["Restricted"]
        S_IOT["IoT"]
        S_GUEST["Guest"]
        S_MGMT["Management"]
    end

    subgraph DESTINATIONS["Destination Zones"]
        D_EXT["External"]
        D_DMZ["DMZ"]
        D_CORP["Corporate"]
        D_REST["Restricted"]
        D_IOT["IoT"]
        D_GUEST["Guest"]
        D_MGMT["Management"]
    end

    S_EXT -->|"Explicit only"| D_DMZ
    S_DMZ -->|"Explicit only"| D_REST
    S_CORP -->|"Filtered"| D_EXT
    S_CORP -->|"App-specific"| D_REST
    S_GUEST -->|"Filtered"| D_EXT
    S_MGMT -->|"Full"| D_CORP
    S_MGMT -->|"Full"| D_REST
    S_MGMT -->|"Full"| D_IOT
```

### Inter-Zone Access Control Matrix

| Source → Dest | External | DMZ | Corporate | Restricted | IoT | Guest | Management |
|---------------|----------|-----|-----------|------------|-----|-------|------------|
| **External** | — | Explicit | Deny | Deny | Deny | Deny | Deny |
| **DMZ** | Limited | — | Deny | Explicit | Deny | Deny | Deny |
| **Corporate** | Filtered | Explicit | Allow | Explicit | Deny | Deny | Deny |
| **Restricted** | Limited | Limited | Explicit | Allow | Deny | Deny | Deny |
| **IoT** | Explicit | Deny | Deny | Deny | Isolated | Deny | Deny |
| **Guest** | Filtered | Deny | Deny | Deny | Deny | Isolated | Deny |
| **Management** | Limited | Allow | Allow | Allow | Allow | Allow | Allow |

**Legend:**
- **Allow**: Traffic permitted with basic ACL
- **Explicit**: Traffic permitted only for defined services/ports
- **Filtered**: Traffic permitted through content inspection
- **Limited**: Minimal outbound only
- **Isolated**: No inter-client communication
- **Deny**: All traffic blocked

### Firewall Rule Framework

```mermaid
flowchart TD
    TRAFFIC[Incoming Traffic] --> ZONE{Source Zone?}

    ZONE -->|External| EXT_RULES["External Rules<br/>- Default deny inbound<br/>- Explicit allow for DMZ services<br/>- IPS inspection required"]

    ZONE -->|DMZ| DMZ_RULES["DMZ Rules<br/>- Allow to specific internal hosts/ports<br/>- Deny direct corporate access<br/>- Log all internal traffic"]

    ZONE -->|Corporate| CORP_RULES["Corporate Rules<br/>- Allow standard internet (filtered)<br/>- Allow approved applications<br/>- Deny management access"]

    ZONE -->|IoT| IOT_RULES["IoT Rules<br/>- Allow specific cloud endpoints<br/>- Allow management system access<br/>- Deny all else"]

    ZONE -->|Guest| GUEST_RULES["Guest Rules<br/>- Allow internet (filtered)<br/>- Deny all internal<br/>- Rate limit applied"]

    ZONE -->|Management| MGMT_RULES["Management Rules<br/>- Allow infrastructure management<br/>- Log all access<br/>- MFA required"]

    EXT_RULES & DMZ_RULES & CORP_RULES & IOT_RULES & GUEST_RULES & MGMT_RULES --> DECISION{Policy<br/>Match?}
    DECISION -->|Yes| ALLOW[Permit]
    DECISION -->|No| DENY[Drop + Log]
```

## Layer 3 Segmentation

### Inter-VLAN Routing Architecture

```mermaid
graph TB
    subgraph CORE["Core Layer (Layer 3)"]
        CORE_SW["Core Switch/Router<br/>Inter-VLAN Routing"]
        FW["Zone Firewall"]
    end

    subgraph DISTRIBUTION["Distribution Layer"]
        DIST1["Distribution 1"]
        DIST2["Distribution 2"]
    end

    subgraph ACCESS["Access Layer"]
        ACC1["Access Switch 1<br/>VLANs 20, 30"]
        ACC2["Access Switch 2<br/>VLANs 20, 30"]
        ACC3["Access Switch 3<br/>VLANs 100, 200"]
    end

    ACC1 & ACC2 --> DIST1
    ACC2 & ACC3 --> DIST2
    DIST1 & DIST2 --> CORE_SW
    CORE_SW <--> FW

    FW -->|"Zone policies"| SERVERS["Server Networks"]
    FW -->|"Internet"| INTERNET["External"]
```

### Routing Security Requirements

| Requirement | Implementation | Rationale |
|-------------|----------------|-----------|
| Route filtering | Prefix lists on all L3 interfaces | Prevent route injection |
| Routing authentication | MD5/SHA for OSPF/BGP | Prevent route spoofing |
| Null routes | Bogon and RFC 1918 at edge | Block invalid sources |
| URPF | Strict mode where possible | Anti-spoofing |
| ACLs on SVIs | Permit only authorized traffic | Inter-VLAN control |

### VRF Segmentation (Advanced)

For environments requiring stronger isolation:

```mermaid
graph TB
    subgraph VRF_MODEL["VRF-Based Segmentation"]
        subgraph VRF_CORP["VRF: Corporate"]
            V_CORP["Corporate VLANs<br/>20, 30, 40"]
        end

        subgraph VRF_GUEST["VRF: Guest"]
            V_GUEST["Guest VLANs<br/>100, 110"]
        end

        subgraph VRF_IOT["VRF: IoT"]
            V_IOT["IoT VLANs<br/>200, 210"]
        end

        subgraph VRF_MGMT["VRF: Management"]
            V_MGMT["Management VLANs<br/>998, 999"]
        end
    end

    VRF_CORP & VRF_GUEST & VRF_IOT <-->|"Route leaking<br/>(controlled)"| FW["Zone Firewall"]
    VRF_MGMT <-->|"Admin access"| FW
```

| VRF | Purpose | Route Leaking |
|-----|---------|---------------|
| Corporate | Business operations | To/from internet, restricted servers |
| Guest | Visitor access | To internet only |
| IoT | Device networks | To specific cloud services |
| Management | Infrastructure | To all VRFs (admin) |

## Microsegmentation

### Microsegmentation Architecture

```mermaid
graph TB
    subgraph TRADITIONAL["Traditional Segmentation"]
        T_NET1["Network A"] <-->|"Firewall"| T_NET2["Network B"]
        T_WL1["Workload 1"] --- T_NET1
        T_WL2["Workload 2"] --- T_NET1
        T_WL3["Workload 3"] --- T_NET2
    end

    subgraph MICRO["Microsegmentation"]
        M_WL1["Workload 1"]
        M_WL2["Workload 2"]
        M_WL3["Workload 3"]
        M_WL1 <-->|"Policy"| M_WL2
        M_WL2 <-->|"Policy"| M_WL3
        M_WL1 <-->|"Policy"| M_WL3
    end

    TRADITIONAL -->|"Evolution"| MICRO
```

### Microsegmentation Approaches

| Approach | Implementation | Use Case | Complexity |
|----------|----------------|----------|------------|
| Network-based | ACLs per host/port | Physical servers | Medium |
| Hypervisor-based | Distributed firewall | Virtual workloads | Medium |
| Agent-based | Host firewall agents | Mixed environments | High |
| Identity-based | User/device identity policies | Zero trust | High |

### Microsegmentation Policy Example

```mermaid
flowchart LR
    subgraph APP_TIER["Application Microsegments"]
        WEB["Web Servers<br/>Allow: 443 in"]
        APP["App Servers<br/>Allow: 8080 from Web"]
        DB["Database<br/>Allow: 5432 from App"]
    end

    USERS["Users"] -->|"HTTPS:443"| WEB
    WEB -->|"HTTP:8080"| APP
    APP -->|"SQL:5432"| DB

    WEB -.->|"Denied"| DB
    USERS -.->|"Denied"| APP
    USERS -.->|"Denied"| DB
```

## IoT Segmentation

### IoT Network Architecture

```mermaid
graph TB
    subgraph IOT_NETWORK["IoT Segmentation"]
        subgraph BUILDING_SYS["Building Systems (VLAN 200)"]
            HVAC["HVAC Controllers"]
            LIGHTS["Lighting Systems"]
            ACCESS_CTRL["Access Control"]
        end

        subgraph SURVEILLANCE["Surveillance (VLAN 210)"]
            CAMERAS["IP Cameras"]
            NVR["NVR/Storage"]
        end

        subgraph SENSORS["Sensors (VLAN 220)"]
            ENV["Environmental Sensors"]
            METERS["Utility Meters"]
        end
    end

    subgraph IOT_CONTROLS["IoT Security Controls"]
        IOT_FW["IoT Firewall"]
        IOT_MGMT["IoT Management Platform"]
        CLOUD["Approved Cloud Services"]
    end

    BUILDING_SYS & SURVEILLANCE & SENSORS --> IOT_FW
    IOT_FW --> IOT_MGMT
    IOT_FW -->|"Allowlisted"| CLOUD
    IOT_FW -->|"Blocked"| INTERNET["General Internet"]
    IOT_FW -->|"Blocked"| CORPORATE["Corporate Network"]
```

### IoT Segmentation Requirements

| Requirement | Implementation | Standard Reference |
|-------------|----------------|-------------------|
| Dedicated VLANs | Separate VLAN per IoT category | IEEE 802.1Q |
| Client isolation | No device-to-device communication | — |
| Internet restriction | Allowlist-only outbound | NIST SP 800-183 |
| Protocol restriction | Allow only required protocols | — |
| Bandwidth limits | QoS rate limiting | IEEE 802.1Qav |
| MAC binding | Static MAC-to-port (critical devices) | — |
| Network monitoring | Full traffic visibility | NIST 800-53 SI-4 |

### IoT Traffic Policies

| IoT Category | Allowed Destinations | Blocked | Protocols |
|--------------|---------------------|---------|-----------|
| Building systems | Management platform, vendor cloud | Internet, corporate | HTTPS, MQTT |
| Cameras | NVR, management platform | All external | RTSP, HTTPS |
| Sensors | IoT platform, time servers | All other | HTTPS, NTP |
| Access control | Directory services, management | Internet | LDAPS, HTTPS |

## Guest Network Segmentation

### Guest Network Architecture

```mermaid
graph TB
    subgraph GUEST_NETWORK["Guest Network Segmentation"]
        GUEST_WIFI["Guest WiFi<br/>VLAN 100"]
        KIOSK_NET["Kiosks<br/>VLAN 110"]
        CONF_NET["Conference Rooms<br/>VLAN 120"]
    end

    subgraph GUEST_CONTROLS["Guest Security Controls"]
        PORTAL["Captive Portal"]
        FILTER["Content Filter"]
        RATE["Rate Limiter"]
        FW_GUEST["Guest Firewall"]
    end

    GUEST_WIFI --> PORTAL
    KIOSK_NET --> PORTAL
    CONF_NET --> PORTAL

    PORTAL --> FILTER --> RATE --> FW_GUEST

    FW_GUEST -->|"Allowed"| INTERNET["Internet"]
    FW_GUEST -->|"Blocked"| INTERNAL["Internal Networks"]
```

### Guest Network Requirements

| Requirement | Implementation | Rationale |
|-------------|----------------|-----------|
| Wireless security | **OWE (Enhanced Open)** — see [OWE Enhanced Open Standards](owe-enhanced-open.md) | Protect against eavesdropping (2026 mandate) |
| Network isolation | Separate VRF or firewall zone | Prevent internal access |
| Client isolation | Layer 2 isolation enabled | Prevent client-to-client attacks |
| Captive portal | Terms acceptance required | Legal liability |
| Content filtering | Block malware, phishing | Security hygiene |
| Bandwidth limits | Fair use policy (10/5 Mbps) | Prevent abuse |
| Session timeout | 8 hours | Force re-acceptance |
| DNS filtering | Malicious domain blocking | Threat prevention |

**Note:** OWE encryption, PMF, and per-client key details are defined in [OWE Enhanced Open Standards](owe-enhanced-open.md). The captive portal provides terms acceptance at Layer 3, while OWE encryption operates at Layer 2.

## Implementation Standards

### VLAN Configuration Checklist

- [ ] Native VLAN changed from 1 (or disabled)
- [ ] VLAN 1 not used for any traffic
- [ ] All VLANs documented with purpose
- [ ] Unused ports in dedicated unused VLAN
- [ ] Trunk ports explicitly configured (no DTP)
- [ ] VLAN pruning enabled on trunks
- [ ] Voice VLAN configured for phone ports
- [ ] Private VLANs for isolation where needed

### Firewall Rule Standards

| Rule Element | Requirement |
|--------------|-------------|
| Default policy | Deny all (implicit) |
| Rule specificity | Most specific first |
| Source/destination | Named objects (not IPs) |
| Service definition | Named services (not port numbers) |
| Logging | All denies, critical permits |
| Rule documentation | Comment on every rule |
| Review frequency | Quarterly minimum |
| Unused rules | Remove after 90 days |

### Change Management

```mermaid
flowchart TD
    REQUEST[Segmentation Change Request] --> REVIEW{Security Review}
    REVIEW -->|Approved| PLAN[Implementation Plan]
    REVIEW -->|Denied| REJECT[Document Rejection]

    PLAN --> TEST[Test in Lab/Staging]
    TEST --> CAB[Change Advisory Board]
    CAB -->|Approved| IMPLEMENT[Implement in Production]
    CAB -->|Denied| REVISE[Revise Plan]

    IMPLEMENT --> VERIFY[Verify Connectivity]
    VERIFY --> MONITOR[Monitor for 30 Days]
    MONITOR --> CLOSE[Close Change]

    REVISE --> TEST
```

## Industry Adoption Data

### Segmentation Deployment Statistics

| Metric | Value | Source | Year |
|--------|-------|--------|------|
| Organizations using VLANs | 97% | EMA Network Report | 2024 |
| Formal zone-based architecture | 78% | SANS Security Survey | 2024 |
| IoT network segmentation | 76% | Ponemon IoT Study | 2024 |
| Guest network isolation | 94% | Industry benchmark | 2024 |
| Microsegmentation adoption | 42% | Forrester Research | 2024 |
| Zero trust network initiatives | 67% | Gartner Security Survey | 2024 |

### Municipal/Government Adoption

| Segmentation Practice | Adoption Rate | Notes |
|-----------------------|---------------|-------|
| Basic VLAN segmentation | 95% | Nearly universal |
| DMZ architecture | 89% | Standard practice |
| IoT isolation | 71% | Growing rapidly |
| Microsegmentation | 28% | Early adoption |
| Zero trust architecture | 45% | Federal mandate driving |

## Cost-Performance Analysis

### Implementation Costs

| Component | Initial Cost | Annual Cost | Notes |
|-----------|--------------|-------------|-------|
| Network redesign (consulting) | $10,000-50,000 | — | One-time |
| Firewall (zone-based) | $15,000-100,000 | $3,000-15,000 | Size dependent |
| Switch upgrades (if needed) | $0-50,000 | — | Most support VLANs |
| Microsegmentation platform | $20,000-150,000 | $15,000-75,000 | Optional |
| Staff training | $5,000-10,000 | $2,000 | Initial + ongoing |
| Documentation/procedures | $5,000 | $1,000 | Critical investment |
| **Total (medium network)** | **$55,000-365,000** | **$21,000-93,000** | — |

### Risk Reduction Value

| Risk Mitigated | Estimated Value | Basis |
|----------------|-----------------|-------|
| Lateral movement prevention | $50,000-500,000/year | Breach containment |
| Ransomware containment | $100,000-1,000,000 | Reduced blast radius |
| IoT compromise isolation | $25,000-250,000 | Device containment |
| Compliance penalties avoided | $10,000-500,000 | PCI, HIPAA, CJIS |
| Incident response costs | $20,000-100,000 | Faster containment |

### TCO Analysis

```mermaid
graph LR
    subgraph FLAT["Flat Network (5-year)"]
        F_IMPL["Implementation: $0"]
        F_BREACH["Breach costs: $500K"]
        F_COMPLIANCE["Compliance gaps: $200K"]
        F_TOTAL["Total: ~$700K"]
    end

    subgraph SEGMENTED["Segmented Network (5-year)"]
        S_IMPL["Implementation: $100K"]
        S_OPS["Operations: $100K"]
        S_BREACH["Breach costs: $75K"]
        S_TOTAL["Total: ~$275K"]
    end

    F_TOTAL -->|"61% reduction"| SAVINGS["$425K savings<br/>+ security improvement"]
    S_TOTAL --> SAVINGS
```

## NIST Alignment

### NIST SP 800-53 Control Mapping

| Control ID | Control Name | Segmentation Implementation |
|------------|--------------|----------------------------|
| AC-4 | Information Flow Enforcement | Zone-based firewall policies |
| AC-4(21) | Physical/Logical Separation | VLANs, VRFs, separate infrastructure |
| CA-3 | Information Exchange | Inter-zone policy enforcement |
| SC-7 | Boundary Protection | Zone firewalls, ACLs |
| SC-7(5) | Deny by Default | Default-deny firewall rules |
| SC-7(9) | Restrict Threatening Traffic | IPS at zone boundaries |
| SC-7(21) | Isolation of System Components | Microsegmentation |
| SC-32 | System Partitioning | Security zone architecture |
| SI-4 | System Monitoring | Inter-zone traffic logging |

### NIST SP 800-207 Zero Trust Alignment

| Zero Trust Principle | Segmentation Implementation |
|---------------------|----------------------------|
| All resources secured | Every zone has explicit policies |
| Least privilege | Minimum necessary access between zones |
| Inspect and log all traffic | Zone boundary logging |
| Dynamic, continuous validation | 802.1X + NAC integration |
| Assume breach | Microsegmentation limits blast radius |

### CISA Zero Trust Maturity Model

| Pillar | Segmentation Contribution |
|--------|--------------------------|
| Identity | 802.1X dynamic VLAN assignment |
| Devices | IoT segmentation, device profiling |
| Networks | Zone architecture, microsegmentation |
| Applications | Application-aware firewall rules |
| Data | Data classification zone alignment |

## Troubleshooting Guide

### Common Issues

| Symptom | Likely Cause | Resolution |
|---------|--------------|------------|
| No inter-VLAN connectivity | Missing route or ACL | Check routing table, ACLs |
| Partial connectivity | Firewall rule missing | Review zone policies |
| Slow inter-zone traffic | Firewall bottleneck | Check firewall performance |
| VLAN not propagating | Trunk misconfiguration | Verify allowed VLANs on trunk |
| Guest accessing internal | Firewall rule error | Audit guest zone policies |
| IoT device offline | Overly restrictive ACL | Review IoT allowlist |

### Diagnostic Flowchart

```mermaid
flowchart TD
    ISSUE[Connectivity Issue] --> Q1{Same VLAN?}
    Q1 -->|Yes| L2["Layer 2 issue<br/>Check switch, STP"]
    Q1 -->|No| Q2{Same zone?}

    Q2 -->|Yes| ACL["Check inter-VLAN ACL<br/>on router/L3 switch"]
    Q2 -->|No| Q3{Firewall in path?}

    Q3 -->|Yes| FW["Check firewall rules<br/>for zone pair"]
    Q3 -->|No| ROUTING["Check routing<br/>between segments"]

    FW --> Q4{Rule exists?}
    Q4 -->|No| ADD["Add appropriate rule"]
    Q4 -->|Yes| LOG["Check firewall logs<br/>for deny entries"]

    LOG --> Q5{Traffic denied?}
    Q5 -->|Yes| MODIFY["Modify rule or<br/>verify correct traffic"]
    Q5 -->|No| INSPECT["Enable packet capture<br/>on firewall"]
```

## Procurement Pass/Fail Checklist

Use this checklist to evaluate any network infrastructure component before purchase for segmentation compliance. Every **Required** item must pass. If any Required item fails, the component is **not approved** for procurement.

### Segmentation Infrastructure Procurement Checklist

| # | Requirement | Required | Pass | Fail |
|---|-------------|----------|------|------|
| 1 | IEEE 802.1Q VLAN support (4094 VLANs minimum) | **Yes** | ☐ | ☐ |
| 2 | Inter-VLAN ACL / access control list support | **Yes** | ☐ | ☐ |
| 3 | VLAN trunk pruning support | **Yes** | ☐ | ☐ |
| 4 | Zone-based firewall with default-deny policy | **Yes** | ☐ | ☐ |
| 5 | VRF (Virtual Routing and Forwarding) support | **Conditional** | ☐ | ☐ |
| 6 | Dynamic VLAN assignment via 802.1X RADIUS attributes | **Yes** | ☐ | ☐ |
| 7 | Microsegmentation / host-level policy enforcement | **Conditional** | ☐ | ☐ |
| 8 | Private VLAN (PVLAN) support | **Yes** | ☐ | ☐ |

### Results

| Outcome | Action |
|---------|--------|
| All Required items pass | **Approved for procurement** |
| Any Required item fails | **Not approved — do not purchase** |
| Questions about a specific device | Contact Network Engineering (ITI Networking Team) |

### How to Verify Requirements

| Checklist Item | Where to Find |
|----------------|---------------|
| 802.1Q VLAN support | Switch datasheet, configuration guide |
| Inter-VLAN ACLs | Feature list, CLI/management reference |
| Trunk pruning | Configuration guide, VLAN management section |
| Zone-based firewall | Firewall datasheet, security feature list |
| VRF support | Router/L3 switch datasheet, routing feature list |
| Dynamic VLAN via 802.1X | 802.1X configuration guide, RADIUS integration docs |
| Microsegmentation | Software-defined networking features, policy engine docs |
| Private VLANs | Switch datasheet, L2 feature list |

## References

1. IEEE 802.1Q-2022, "Bridges and Bridged Networks," IEEE, December 2022.
2. IEEE 802.1X-2020, "Port-Based Network Access Control," IEEE, February 2020.
3. IETF RFC 4364, "BGP/MPLS IP Virtual Private Networks (VPNs)," IETF, February 2006.
4. NIST SP 800-53 Rev. 5, "Security and Privacy Controls for Information Systems and Organizations," NIST, September 2020.
5. NIST SP 800-125B, "Secure Virtual Network Configuration for Virtual Machine (VM) Protection," NIST, March 2016.
6. NIST SP 800-207, "Zero Trust Architecture," NIST, August 2020.
7. NIST SP 800-183, "Networks of 'Things'," NIST, July 2016.
8. CISA, "Zero Trust Maturity Model Version 2.0," CISA, April 2023.
9. PCI Security Standards Council, "PCI DSS v4.0," PCI SSC, March 2022.
10. CIS Controls v8, "CIS Critical Security Controls," Center for Internet Security, May 2021.

---

*For questions about these standards, open an issue or contact the ITI Networking Team.*
