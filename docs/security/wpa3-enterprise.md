---
title: WPA3-Enterprise Wireless Security Standards
version: 1.0.0
status: Supported
last_updated: 2026-02-02
ieee_reference: IEEE 802.11-2024, 802.11i
wpa_reference: Wi-Fi Alliance WPA3 Specification v3.3
---

# WPA3-Enterprise Wireless Security Standards

## Overview

This document establishes the standards for WPA3-Enterprise wireless security. WPA3-Enterprise provides the highest level of wireless authentication and encryption for municipal networks, implementing 802.1X authentication with enhanced cryptographic protections.

## Standards References

| Standard | Title | Ratification Date | Scope |
|----------|-------|-------------------|-------|
| IEEE 802.11-2024 | Wireless LAN Medium Access Control | December 2020 | Consolidated wireless standard |
| IEEE 802.11i-2004 | Security Enhancements | July 2004 | RSN framework (WPA2 basis) |
| IEEE 802.11w-2009 | Protected Management Frames | September 2009 | Management frame protection |
| IEEE 802.11r-2008 | Fast BSS Transition | July 2008 | Fast roaming |
| Wi-Fi Alliance WPA3 v3.3 | WPA3 Specification | July 2024 | WPA3 certification requirements |
| IETF RFC 9190 | EAP-TLS 1.3 Authentication Protocol | February 2022 | Certificate-based EAP with TLS 1.3 |
| IETF RFC 8446 | TLS 1.3 | August 2018 | Transport security |
| NIST SP 800-53 Rev. 5 | Security Controls | September 2020 | Federal security requirements |
| NIST SP 800-153 | Guidelines for Securing WLANs | February 2012 | WLAN security guidance |
| CNSA 2.0 | Commercial NSA Suite | September 2022 | High-security cryptography |

## WPA3 Security Modes

### Mode Comparison

```mermaid
graph TB
    subgraph WPA3["WPA3 Security Modes"]
        OWE["OWE<br/>(Enhanced Open)"]
        PERSONAL["WPA3-Personal<br/>(SAE)"]
        ENTERPRISE["WPA3-Enterprise<br/>(802.1X)"]
        ENTERPRISE_192["WPA3-Enterprise<br/>192-bit Mode"]
    end

    OWE --> OWE_USE["Guest networks<br/>No password required"]
    PERSONAL --> P_USE["IoT devices<br/>Pre-shared key"]
    ENTERPRISE --> E_USE["Corporate networks<br/>Certificate/credential auth"]
    ENTERPRISE_192 --> E192_USE["High-security environments<br/>Suite B cryptography"]

    subgraph SECURITY_LEVEL["Security Level"]
        S0["Encrypted (no auth)"]
        S1["Good"]
        S2["Better"]
        S3["Best"]
    end

    OWE -.-> S0
    PERSONAL -.-> S1
    ENTERPRISE -.-> S2
    ENTERPRISE_192 -.-> S3
```

### Municipal Security Mode Usage

| SSID | Security Mode | Use Case | Standard Reference |
|------|---------------|----------|-------------------|
| MUNI-GUEST | **OWE (Enhanced Open)** | Visitor/public access | [OWE Standards](owe-enhanced-open.md) |
| MUNI-IOT | WPA3-Personal (SAE) | IoT devices | This document |
| MUNI-CORP | WPA3-Enterprise | Corporate devices | This document |
| MUNI-SECURE | WPA3-Enterprise 192-bit | High-security systems | This document |

### WPA3-Enterprise vs. WPA3-Enterprise 192-bit

| Feature | WPA3-Enterprise | WPA3-Enterprise 192-bit |
|---------|-----------------|------------------------|
| **Target use** | General enterprise | High-security/government |
| **Encryption** | AES-CCMP-128 or AES-GCMP-256 | AES-GCMP-256 only |
| **Key derivation** | HMAC-SHA-256 or HMAC-SHA-384 | HMAC-SHA-384 only |
| **EAP method** | Any supported (EAP-TLS recommended) | EAP-TLS only |
| **Certificate requirements** | RSA 2048+ or ECC P-256+ | ECC P-384 or RSA 3072+ |
| **TLS version** | TLS 1.3 | TLS 1.3 with Suite B ciphers |
| **PMF (802.11w)** | Required | Required (BIP-GMAC-256) |
| **CNSA compliance** | Partial | Full |

## WPA3-Enterprise Architecture

### Security Stack

```mermaid
graph TB
    subgraph APPLICATION["Application Layer"]
        APP["Network Applications"]
    end

    subgraph TRANSPORT["Transport Layer"]
        TLS["TLS 1.3<br/>(EAP tunnel)"]
    end

    subgraph AUTHENTICATION["Authentication Layer"]
        EAP["EAP-TLS<br/>(802.1X)"]
        RADIUS["RADIUS"]
    end

    subgraph ENCRYPTION["Encryption Layer"]
        GCMP["AES-GCMP-256<br/>(Data encryption)"]
        PMF["BIP-GMAC-256<br/>(Management frame protection)"]
    end

    subgraph HANDSHAKE["Key Exchange"]
        FOURWAY["4-Way Handshake<br/>(Key confirmation)"]
        PMK["PMK Derivation<br/>(From EAP success)"]
    end

    subgraph PHYSICAL["Physical Layer"]
        RF["802.11ax/be<br/>(Wi-Fi 6/7)"]
    end

    APP --> TLS --> EAP --> GCMP
    EAP --> PMF
    RADIUS --> PMK --> FOURWAY
    GCMP --> RF
    PMF --> RF
```

### Authentication Flow

```mermaid
sequenceDiagram
    participant C as Client (Supplicant)
    participant AP as Access Point
    participant R as RADIUS Server
    participant CA as Certificate Authority

    Note over C,AP: Association (RSN capabilities exchanged)
    C->>AP: Probe Request
    AP->>C: Probe Response (RSN IE: WPA3)
    C->>AP: Authentication Request (Open)
    AP->>C: Authentication Response
    C->>AP: Association Request (RSN IE)
    AP->>C: Association Response

    Note over C,R: EAP-TLS Authentication
    AP->>C: EAP-Request/Identity
    C->>AP: EAP-Response/Identity
    AP->>R: Access-Request (Identity)
    R->>AP: Access-Challenge (EAP-TLS Start)
    AP->>C: EAP-Request (TLS Start)
    C->>AP: EAP-Response (TLS ClientHello)
    AP->>R: Access-Request (ClientHello)
    R->>AP: Access-Challenge (ServerHello, Certificate)
    AP->>C: EAP-Request (ServerHello, Server Cert)

    Note over C,CA: Certificate Validation
    C->>C: Validate server certificate
    C->>AP: EAP-Response (Client Cert, KeyExchange)
    AP->>R: Access-Request (Client Cert)
    R->>CA: Validate client certificate
    CA->>R: Certificate valid

    R->>AP: Access-Accept (MSK)
    AP->>C: EAP-Success

    Note over C,AP: 4-Way Handshake (PMK → PTK)
    AP->>C: Message 1 (ANonce)
    C->>AP: Message 2 (SNonce, MIC)
    AP->>C: Message 3 (GTK, MIC)
    C->>AP: Message 4 (MIC)

    Note over C,AP: Secure Communication Begins
```

## Cryptographic Requirements

### WPA3-Enterprise Standard Mode

| Component | Requirement | Standard Reference |
|-----------|-------------|-------------------|
| Pairwise cipher | AES-CCMP-128 or AES-GCMP-256 | IEEE 802.11-2024 |
| Group cipher | AES-CCMP-128 or AES-GCMP-256 | IEEE 802.11-2024 |
| Group management cipher | BIP-CMAC-128 or BIP-GMAC-256 | IEEE 802.11w |
| Key derivation | HMAC-SHA-256 or HMAC-SHA-384 | Wi-Fi Alliance |
| EAP method | EAP-TLS only (2026 policy) | RFC 9190; see [802.1X Implementation](802.1x-implementation.md) |
| TLS version | TLS 1.3 minimum | RFC 8446 |
| Server certificate | RSA 2048+ or ECDSA P-256+ | Wi-Fi Alliance |
| Client certificate | RSA 2048+ or ECDSA P-256+ | Wi-Fi Alliance |

### WPA3-Enterprise 192-bit Mode (Recommended for High-Security)

| Component | Requirement | Standard Reference |
|-----------|-------------|-------------------|
| Pairwise cipher | AES-GCMP-256 only | IEEE 802.11-2024 |
| Group cipher | AES-GCMP-256 only | IEEE 802.11-2024 |
| Group management cipher | BIP-GMAC-256 only | IEEE 802.11w |
| Key derivation | HMAC-SHA-384 only | Wi-Fi Alliance |
| EAP method | EAP-TLS only | RFC 9190 |
| TLS ciphers | TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384 | RFC 8446 |
| Server certificate | ECDSA P-384 or RSA 3072+ | CNSA 2.0 |
| Client certificate | ECDSA P-384 or RSA 3072+ | CNSA 2.0 |

## Protected Management Frames (PMF/802.11w)

### PMF Overview

PMF protects 802.11 management frames from spoofing and injection attacks:

```mermaid
graph TD
    subgraph PROTECTED["Protected Frames (PMF)"]
        DEAUTH["Deauthentication"]
        DISASSOC["Disassociation"]
        ACTION["Action frames"]
        SA_QUERY["SA Query"]
    end

    subgraph ATTACKS_BLOCKED["Attacks Prevented"]
        ATTACK1["Deauth flood attacks"]
        ATTACK2["Forced disconnection"]
        ATTACK3["Session hijacking"]
        ATTACK4["Evil twin facilitation"]
    end

    DEAUTH --> ATTACK1
    DISASSOC --> ATTACK2
    ACTION --> ATTACK3
    SA_QUERY --> ATTACK4
```

### PMF Configuration Requirements

| Setting | WPA3-Enterprise | WPA3-Enterprise 192-bit |
|---------|-----------------|------------------------|
| PMF mode | Required (mandatory) | Required (mandatory) |
| IGTK cipher | BIP-CMAC-128 or BIP-GMAC-256 | BIP-GMAC-256 only |
| SA Query timeout | 200 ms | 200 ms |
| Association comeback | Enabled | Enabled |
| Beacon protection | Recommended | Required |

## Transition Mode (WPA2/WPA3 Mixed)

### When to Use Transition Mode

Transition mode allows both WPA2 and WPA3 clients on the same SSID during migration:

```mermaid
flowchart TD
    ASSESS[Assess Client Inventory] --> Q1{All clients<br/>WPA3 capable?}
    Q1 -->|Yes| WPA3_ONLY["WPA3-Only Mode<br/>(Recommended)"]
    Q1 -->|No| Q2{>80% WPA3<br/>capable?}

    Q2 -->|Yes| TRANSITION["Transition Mode<br/>(Time-limited)"]
    Q2 -->|No| Q3{Can upgrade<br/>clients?}

    Q3 -->|Yes| UPGRADE["Upgrade clients first"]
    Q3 -->|No| SEPARATE["Separate SSIDs<br/>WPA2 + WPA3"]

    UPGRADE --> Q1
    TRANSITION --> TIMELINE["Set transition<br/>end date"]
    TIMELINE --> WPA3_ONLY
```

### Transition Mode Configuration

| Setting | Value | Rationale |
|---------|-------|-----------|
| Authentication | WPA2-Enterprise + WPA3-Enterprise | Dual support |
| Encryption | AES-CCMP (WPA2) / AES-GCMP (WPA3) | Per-client negotiation |
| PMF | Required for WPA3, optional for WPA2 | Maintain WPA2 compatibility |
| Transition Disable | Enabled | Prevent WPA3 client downgrade |
| Timeline | Maximum 12 months | Force migration completion |

### Transition Disable Feature

Transition Disable prevents WPA3-capable clients from connecting via WPA2:

```mermaid
sequenceDiagram
    participant C as WPA3 Client
    participant AP as Access Point

    Note over C,AP: First connection (WPA3)
    C->>AP: Associate (WPA3)
    AP->>C: Transition Disable indication
    C->>C: Store: "This network = WPA3 only"

    Note over C,AP: Subsequent attempt (attacker presents WPA2)
    C->>AP: Scan networks
    AP->>C: SSID available (WPA2)
    C->>C: Check stored policy
    C->>C: Reject WPA2 (Transition Disable)
    Note over C: Client refuses downgrade
```

## Access Point Configuration Standards

### Radio Settings for WPA3

| Setting | Recommended Value | Standard Reference |
|---------|-------------------|-------------------|
| Security mode | WPA3-Enterprise | Wi-Fi Alliance WPA3 |
| PMF | Required | IEEE 802.11w |
| Fast BSS transition | Enabled (802.11r) | IEEE 802.11r |
| OKC (Opportunistic Key Caching) | Enabled | IEEE 802.11-2024 |
| GTK rekey interval | 86400 seconds (24 hours) | Security best practice |
| PTK rekey | On session timeout | Security best practice |
| Management frame protection | BIP-GMAC-256 | IEEE 802.11w |

### RADIUS Integration

See [802.1X Implementation — RADIUS Architecture](802.1x-implementation.md#radius-architecture) for complete RADIUS server configuration, failover, and attribute standards.

**WPA3-specific parameter:**

| Parameter | Requirement | Notes |
|-----------|-------------|-------|
| Session timeout | 28800 seconds (8 hours) | Periodic reauthentication for WPA3-Enterprise sessions |

## Migration from WPA2-Enterprise

### Migration Assessment

```mermaid
flowchart TD
    START[Begin WPA3 Migration] --> INVENTORY[Device Inventory]

    INVENTORY --> CAT1{Client Category}
    CAT1 --> MANAGED["Managed Devices<br/>(Organization-owned)"]
    CAT1 --> BYOD["BYOD/Personal"]
    CAT1 --> IOT["IoT Devices"]

    MANAGED --> M_CHECK{OS Version<br/>supports WPA3?}
    M_CHECK -->|Yes| M_READY["Ready for WPA3"]
    M_CHECK -->|No| M_UPDATE["Update OS or<br/>plan replacement"]

    BYOD --> B_CHECK{Enforce WPA3<br/>or provide fallback?}
    B_CHECK -->|Enforce| B_NOTIFY["Notify users<br/>of requirement"]
    B_CHECK -->|Fallback| B_SEPARATE["Separate SSID<br/>(WPA2 legacy)"]

    IOT --> I_CHECK{Device supports<br/>WPA3-Personal?}
    I_CHECK -->|Yes| I_MIGRATE["Migrate to<br/>WPA3-Personal SSID"]
    I_CHECK -->|No| I_ISOLATE["Keep on isolated<br/>IoT network"]
```

### Client Compatibility Matrix

| Operating System | Minimum Version | WPA3 Support | WPA3-Enterprise 192-bit |
|------------------|-----------------|--------------|------------------------|
| Windows | 10 (1903) | Yes | Yes (11+) |
| Windows | 11 | Yes | Yes |
| macOS | 10.15 (Catalina) | Yes | Yes |
| iOS | 13.0 | Yes | Yes |
| iPadOS | 13.0 | Yes | Yes |
| Android | 10 | Yes (device dependent) | Yes (12+) |
| ChromeOS | 89 | Yes | Yes |
| Linux | Kernel 5.0+ | Yes (driver dependent) | Yes |

### Migration Timeline

```mermaid
gantt
    title WPA3-Enterprise Migration
    dateFormat  YYYY-MM-DD

    section Assessment
    Client inventory           :a1, 2026-03-01, 14d
    AP capability audit        :a2, 2026-03-01, 7d
    RADIUS/PKI readiness       :a3, 2026-03-08, 7d

    section Preparation
    Update AP firmware         :p1, 2026-03-15, 14d
    Configure WPA3 profiles    :p2, 2026-03-22, 7d
    Test with pilot group      :p3, 2026-03-29, 14d

    section Deployment
    Enable Transition Mode     :d1, 2026-04-15, 1d
    Monitor and remediate      :d2, 2026-04-15, 60d
    Disable WPA2 (new SSIDs)   :d3, 2026-06-15, 1d

    section Completion
    Full WPA3-only mode        :c1, 2026-09-01, 1d
    Legacy SSID retirement     :c2, 2026-09-15, 14d
```

## Industry Adoption Data

### WPA3 Enterprise Deployment Statistics

| Metric | Value | Source | Year |
|--------|-------|--------|------|
| WPA3-Enterprise capable APs shipped | 94% | Wi-Fi Alliance | 2024 |
| Enterprise WPA3 deployments | 61% | Ponemon Wireless Security | 2024 |
| WPA3-Enterprise 192-bit usage | 12% | Federal CIO Council | 2024 |
| Transition mode deployments | 34% | EMA Network Report | 2024 |
| Full WPA3-only enterprise networks | 27% | EMA Network Report | 2024 |

### Client Support Statistics

| Platform | WPA3 Support Rate | Notes |
|----------|-------------------|-------|
| Enterprise Windows (managed) | 98% | Win10/11 fleet |
| Enterprise macOS | 96% | Catalina+ required |
| Enterprise iOS | 99% | iOS 13+ universal |
| Android (enterprise) | 87% | Fragmentation issues |
| IoT devices | 23% | Major gap |

## Cost-Performance Analysis

### Migration Costs

| Component | Cost Range | Notes |
|-----------|------------|-------|
| AP firmware updates | $0 | Included in support |
| AP hardware replacement (if needed) | $500-1,500/AP | Only for very old APs |
| RADIUS server updates | $0-5,000 | May need EAP-TLS config |
| Client updates | $0 | OS updates |
| PKI enhancements | $0-10,000 | If certificate changes needed |
| Staff training | $2,000-5,000 | WPA3 specifics |
| Testing and validation | $5,000-10,000 | Pilot program |
| **Total (100 APs, no replacement)** | **$7,000-30,000** | — |

### Security Value

| Benefit | Annual Value | Basis |
|---------|--------------|-------|
| Prevented deauth attacks | $10,000-50,000 | PMF protection |
| Reduced credential exposure | $25,000-100,000 | Stronger encryption |
| Compliance (CJIS, CMMC, HIPAA) | Required | Audit requirements |
| Extended device lifecycle | $20,000-50,000 | Security longevity |

### TCO Comparison

```mermaid
graph TB
    subgraph WPA2_ONLY["WPA2-Enterprise Only (5-year)"]
        W2_DEPLOY["Deployment: $0"]
        W2_VULN["Vulnerability costs: $150K"]
        W2_COMPLIANCE["Compliance gaps: $100K"]
        W2_TOTAL["Total: ~$250K"]
    end

    subgraph WPA3_MIGRATE["WPA3-Enterprise Migration (5-year)"]
        W3_DEPLOY["Migration: $30K"]
        W3_VULN["Vulnerability costs: $25K"]
        W3_COMPLIANCE["Compliance: $0"]
        W3_TOTAL["Total: ~$55K"]
    end

    W2_TOTAL -->|"78% reduction"| SAVINGS["$195K savings<br/>+ security improvement"]
    W3_TOTAL --> SAVINGS
```

## NIST Alignment

### NIST SP 800-53 Control Mapping

| Control ID | Control Name | WPA3-Enterprise Implementation |
|------------|--------------|-------------------------------|
| AC-18 | Wireless Access | WPA3-Enterprise authentication |
| AC-18(1) | Authentication and Encryption | EAP-TLS + AES-GCMP-256 |
| AC-18(3) | Disable Wireless Networking | N/A (secure wireless) |
| AC-18(4) | Restrict Configurations | Centralized AP management |
| AC-18(5) | Antennas/Transmission Power | Site survey-based config |
| IA-3 | Device Identification | Device certificates |
| IA-5 | Authenticator Management | Certificate lifecycle |
| SC-8 | Transmission Confidentiality | AES-GCMP-256 encryption |
| SC-12 | Cryptographic Key Management | PMK/PTK derivation |
| SC-13 | Cryptographic Protection | FIPS 140-2 validated crypto |
| SC-40 | Wireless Link Protection | PMF (802.11w) |

### NIST SP 800-153 Compliance

| Requirement | WPA3-Enterprise Response |
|-------------|-------------------------|
| Use strong encryption | AES-GCMP-256 (192-bit mode) |
| Implement mutual authentication | EAP-TLS with certificates |
| Protect management frames | PMF required |
| Use RADIUS for authentication | 802.1X with RADIUS |
| Implement rogue AP detection | Wireless IDS/IPS |
| Segment wireless traffic | Dynamic VLAN assignment |

## Troubleshooting Guide

### Common Issues

| Symptom | Likely Cause | Resolution |
|---------|--------------|------------|
| Client won't connect to WPA3 | Unsupported OS/driver | Update client OS and drivers |
| 192-bit mode failures | Certificate algorithm mismatch | Use ECDSA P-384 certificates |
| Roaming failures | 802.11r misconfiguration | Verify FT settings on all APs |
| Intermittent disconnects | PMF timeout issues | Adjust SA Query timeout |
| RADIUS timeout | Server can't validate certificate | Check certificate chain, OCSP |
| Slow authentication | EAP-TLS full handshake | Enable OKC and 802.11r |

### Diagnostic Flowchart

```mermaid
flowchart TD
    ISSUE[WPA3 Connection Issue] --> Q1{Client shows<br/>WPA3 available?}
    Q1 -->|No| FIX1[Check AP config,<br/>client compatibility]
    Q1 -->|Yes| Q2{Association<br/>succeeds?}

    Q2 -->|No| FIX2[Check RSN<br/>capabilities match]
    Q2 -->|Yes| Q3{EAP starts?}

    Q3 -->|No| FIX3[Verify RADIUS<br/>connectivity]
    Q3 -->|Yes| Q4{Certificate<br/>validated?}

    Q4 -->|No| FIX4[Check cert chain,<br/>validity, algorithm]
    Q4 -->|Yes| Q5{4-way handshake<br/>completes?}

    Q5 -->|No| FIX5[Check PTK/GTK<br/>cipher support]
    Q5 -->|Yes| Q6{Data flows?}

    Q6 -->|No| FIX6[Check VLAN,<br/>firewall rules]
    Q6 -->|Yes| SUCCESS[Connection OK]
```

## Implementation Checklist

### Pre-Deployment

- [ ] Verify all APs support WPA3-Enterprise
- [ ] Confirm RADIUS server supports required EAP methods
- [ ] Validate PKI can issue compliant certificates
- [ ] Inventory client devices for compatibility
- [ ] Plan transition mode timeline (if needed)
- [ ] Configure test SSID for validation

### Deployment

- [ ] Update AP firmware to latest version
- [ ] Configure WPA3-Enterprise security profile
- [ ] Enable PMF (required)
- [ ] Configure 802.11r for fast roaming
- [ ] Enable Transition Disable
- [ ] Set appropriate session timeout
- [ ] Configure RADIUS failover

### Post-Deployment

- [ ] Monitor authentication success rates
- [ ] Track WPA2 vs WPA3 client distribution
- [ ] Review security logs for anomalies
- [ ] Plan WPA2 deprecation date
- [ ] Document exceptions and remediation plans

## Procurement Pass/Fail Checklist

Use this checklist to evaluate any wireless infrastructure component before purchase for WPA3-Enterprise compliance. Every **Required** item must pass. If any Required item fails, the component is **not approved** for procurement.

### WPA3 Infrastructure Procurement Checklist

| # | Requirement | Required | Pass | Fail |
|---|-------------|----------|------|------|
| 1 | WPA3-Enterprise certified (Wi-Fi Alliance) | **Yes** | ☐ | ☐ |
| 2 | 192-bit security mode (CNSA suite) support | **Conditional** | ☐ | ☐ |
| 3 | Protected Management Frames (PMF / 802.11w) mandatory mode | **Yes** | ☐ | ☐ |
| 4 | TLS 1.3 (RFC 8446) for all EAP-TLS sessions | **Yes** | ☐ | ☐ |
| 5 | Transition Disable indication support | **Yes** | ☐ | ☐ |
| 6 | 802.11r (Fast BSS Transition) support | **Yes** | ☐ | ☐ |
| 7 | Configurable session timeout and reauthentication interval | **Yes** | ☐ | ☐ |
| 8 | ECDSA P-384 certificate support | **Conditional** | ☐ | ☐ |

### Results

| Outcome | Action |
|---------|--------|
| All Required items pass | **Approved for procurement** |
| Any Required item fails | **Not approved — do not purchase** |
| Questions about a specific device | Contact Network Engineering (ITI Networking Team) |

### How to Verify Requirements

| Checklist Item | Where to Find |
|----------------|---------------|
| WPA3-Enterprise certification | Wi-Fi Alliance product finder, vendor spec sheet |
| 192-bit security mode | Vendor documentation, "WPA3-Enterprise 192-bit" in spec sheet |
| PMF mandatory mode | Configuration guide, WPA3 certification includes PMF |
| TLS 1.3 | RADIUS server documentation, supplicant OS requirements |
| Transition Disable | Firmware release notes, Wi-Fi Alliance certification |
| 802.11r support | Vendor spec sheet, configuration guide |
| Session timeout / reauth | Management platform documentation |
| ECDSA P-384 certificates | PKI documentation, certificate enrollment guide |

## References

1. IEEE 802.11-2024, "Wireless LAN Medium Access Control (MAC) and Physical Layer (PHY) Specifications," IEEE, December 2020.
2. IEEE 802.11i-2004, "Amendment 6: Medium Access Control (MAC) Security Enhancements," IEEE, July 2004.
3. IEEE 802.11w-2009, "Amendment 4: Protected Management Frames," IEEE, September 2009.
4. IEEE 802.11r-2008, "Amendment 2: Fast Basic Service Set (BSS) Transition," IEEE, July 2008.
5. Wi-Fi Alliance, "WPA3 Specification Version 3.3," Wi-Fi Alliance, July 2024.
6. Wi-Fi Alliance, "WPA3 Security Considerations," Wi-Fi Alliance Technical Note, 2024.
7. IETF RFC 9190, "EAP-TLS 1.3: Using the Extensible Authentication Protocol with TLS 1.3," IETF, February 2022.
8. IETF RFC 8446, "The Transport Layer Security (TLS) Protocol Version 1.3," IETF, August 2018.
9. NIST SP 800-53 Rev. 5, "Security and Privacy Controls for Information Systems and Organizations," NIST, September 2020.
10. NIST SP 800-153, "Guidelines for Securing Wireless Local Area Networks (WLANs)," NIST, February 2012.
11. NSA, "Commercial National Security Algorithm Suite 2.0," NSA Cybersecurity, September 2022.

## Cross-References

| Document | Relationship |
|----------|--------------|
| [802.1X Implementation](802.1x-implementation.md) | RADIUS architecture and EAP-TLS authentication |
| [OWE Enhanced Open Standards](owe-enhanced-open.md) | Guest network encryption (non-enterprise SSIDs) |
| [SSID Standards](../wifi/ssid-standards.md) | Per-SSID security profile assignments |
| [Access Point Specifications](../wifi/access-point-specs.md) | AP WPA3-Enterprise hardware requirements |
| [Wireless Client Requirements](../wifi/wireless-client-requirements.md) | Client WPA3 supplicant and cipher suite requirements |
| [Network Segmentation](network-segmentation.md) | VLAN-based security zones enforced via WPA3 |

---

*For questions about these standards, open an issue or contact the ITI Networking Team.*
