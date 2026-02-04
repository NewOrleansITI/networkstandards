---
title: OWE Enhanced Open Wireless Security Standards
version: 1.0.0
status: Supported
last_updated: 2026-02-02
ieee_reference: IEEE 802.11-2020
wpa_reference: Wi-Fi Alliance WPA3 Specification v3.3
effective_date: 2026-02-02
---

# OWE Enhanced Open Wireless Security Standards

## Overview

This document establishes the City of New Orleans standards for Opportunistic Wireless Encryption (OWE), also known as Wi-Fi CERTIFIED Enhanced Open™. OWE provides encryption on open networks without requiring passwords or authentication, protecting guest users from passive eavesdropping while maintaining zero-friction access.

**Effective 2026:** OWE is **mandatory** for all guest wireless networks. Traditional open (unencrypted) guest SSIDs are prohibited for new deployments.

## Standards References

| Standard | Title | Ratification Date | Scope |
|----------|-------|-------------------|-------|
| IEEE 802.11-2020 | Wireless LAN MAC and PHY | December 2020 | OWE specification (Section 12.12) |
| Wi-Fi Alliance WPA3 v3.3 | WPA3 Specification | July 2024 | Enhanced Open certification |
| IETF RFC 8110 | OWE | March 2017 | Opportunistic Wireless Encryption |
| IETF RFC 7748 | Elliptic Curves | January 2016 | Curve25519/Curve448 for DH |
| NIST SP 800-53 Rev. 5 | Security Controls | September 2020 | Federal security requirements |
| NIST SP 800-153 | Guidelines for Securing WLANs | February 2012 | WLAN security guidance |

## Standard Rationale and Justification

### Why OWE for Guest Networks (2026 Standard)

#### Security Gap in Traditional Open Networks

Traditional open WiFi networks (without encryption) expose users to significant security risks:

```mermaid
graph TD
    subgraph OPEN_NETWORK["Traditional Open Network (Prohibited)"]
        GUEST1["Guest Device 1"] -->|"Unencrypted"| AP1["Access Point"]
        GUEST2["Guest Device 2"] -->|"Unencrypted"| AP1
        ATTACKER["Attacker"] -->|"Passive Capture"| AIR["Airspace"]
        AP1 -.->|"All traffic visible"| AIR
    end

    subgraph OWE_NETWORK["OWE Enhanced Open Network (Required)"]
        GUEST3["Guest Device 3"] -->|"Encrypted (unique key)"| AP2["Access Point"]
        GUEST4["Guest Device 4"] -->|"Encrypted (unique key)"| AP2
        ATTACKER2["Attacker"] -->|"Cannot decrypt"| AIR2["Airspace"]
        AP2 -.->|"Traffic encrypted"| AIR2
    end
```

| Risk | Open Network | OWE Network |
|------|--------------|-------------|
| Passive eavesdropping | ❌ Vulnerable | ✅ Protected |
| Session hijacking | ❌ Vulnerable | ✅ Protected |
| Credential capture | ❌ Vulnerable | ✅ Protected |
| Man-in-the-middle | ⚠️ Possible | ⚠️ Possible (no auth) |
| User friction | ✅ None | ✅ None |

#### Justification for 2026 Mandate

| Factor | Justification |
|--------|---------------|
| **Universal AP Support** | All WiFi 7 access points (mandatory for new deployments) support OWE |
| **Client Maturity** | 95%+ of guest devices support OWE (iOS 13+, Android 10+, Windows 10+, macOS 10.15+) |
| **Zero User Impact** | Identical user experience to open networks—no passwords or configuration |
| **Industry Alignment** | Wi-Fi Alliance has certified Enhanced Open since 2018; now industry baseline |
| **Regulatory Direction** | NIST SP 800-153 recommends encryption for all wireless communications |
| **Liability Reduction** | Encrypted guest traffic reduces City liability for guest data exposure |
| **Zero Deployment Cost** | OWE requires no additional infrastructure—configuration change only |

### Industry Adoption Data

| Metric | Value | Source | Year |
|--------|-------|--------|------|
| WiFi 7 APs with OWE support | 100% | Wi-Fi Alliance Certification | 2024 |
| WiFi 6/6E APs with OWE support | 98% | Wi-Fi Alliance Certification | 2024 |
| Enterprise OWE deployments (guest networks) | 47% | Ponemon Wireless Security Study | 2025 |
| Municipal OWE adoption | 38% | State/Local IT Survey | 2025 |
| Client devices supporting OWE | 95%+ | Wi-Fi Alliance Device Statistics | 2025 |

### Client Compatibility Matrix

| Operating System | Minimum Version | OWE Support | Notes |
|------------------|-----------------|-------------|-------|
| iOS | 13.0 | ✅ Yes | Native support |
| iPadOS | 13.0 | ✅ Yes | Native support |
| Android | 10 | ✅ Yes | Device/driver dependent |
| Android | 12+ | ✅ Yes | Universal support |
| Windows | 10 (1903) | ✅ Yes | Native support |
| Windows | 11 | ✅ Yes | Native support |
| macOS | 10.15 (Catalina) | ✅ Yes | Native support |
| ChromeOS | 89 | ✅ Yes | Native support |
| Linux | Kernel 5.0+ | ✅ Yes | Driver dependent |

**Legacy Device Handling:** Devices that do not support OWE will see the network but fail to connect. For environments requiring legacy device support, see [Transition Mode](#transition-mode-owe--open-mixed) configuration.

## OWE Technical Architecture

### How OWE Works

OWE uses Diffie-Hellman key exchange to establish unique encryption keys between each client and the access point, without requiring pre-shared credentials:

```mermaid
sequenceDiagram
    participant C as Client
    participant AP as Access Point

    Note over C,AP: Discovery Phase
    C->>AP: Probe Request
    AP->>C: Probe Response (OWE capability)

    Note over C,AP: Association with DH Key Exchange
    C->>AP: Association Request (Client DH Public Key)
    AP->>C: Association Response (AP DH Public Key)

    Note over C,AP: Key Derivation (both sides)
    C->>C: Derive PMK from DH shared secret
    AP->>AP: Derive PMK from DH shared secret

    Note over C,AP: Standard 4-Way Handshake
    AP->>C: Message 1 (ANonce)
    C->>AP: Message 2 (SNonce, MIC)
    AP->>C: Message 3 (GTK, MIC)
    C->>AP: Message 4 (MIC)

    Note over C,AP: Encrypted Communication Begins
    C->>AP: Data (AES encrypted)
    AP->>C: Data (AES encrypted)
```

### Security Stack

```mermaid
graph TB
    subgraph OWE_STACK["OWE Security Stack"]
        subgraph KEY_EXCHANGE["Key Exchange Layer"]
            DH["Diffie-Hellman (ECDH)"]
            CURVES["Curve P-256 or Curve P-384"]
        end

        subgraph ENCRYPTION["Encryption Layer"]
            CCMP["AES-CCMP-128"]
            GCMP["AES-GCMP-256 (optional)"]
        end

        subgraph MGMT_PROTECTION["Management Protection"]
            PMF["Protected Management Frames<br/>(802.11w) - Required"]
        end

        subgraph HANDSHAKE["Key Confirmation"]
            FOURWAY["4-Way Handshake"]
        end
    end

    DH --> CURVES
    CURVES --> FOURWAY
    FOURWAY --> CCMP
    FOURWAY --> GCMP
    CCMP --> PMF
    GCMP --> PMF
```

### Cryptographic Requirements

| Component | Requirement | Standard Reference |
|-----------|-------------|-------------------|
| Key exchange | ECDH (Elliptic Curve Diffie-Hellman) | IETF RFC 8110 |
| DH group | Group 19 (P-256) or Group 20 (P-384) | IEEE 802.11-2020 |
| Pairwise cipher | AES-CCMP-128 or AES-GCMP-256 | IEEE 802.11-2020 |
| Group cipher | AES-CCMP-128 or AES-GCMP-256 | IEEE 802.11-2020 |
| PMF (802.11w) | **Required** | IEEE 802.11w-2009 |
| Key derivation | SHA-256 (P-256) or SHA-384 (P-384) | IETF RFC 8110 |

### OWE vs. Other Security Modes

```mermaid
graph LR
    subgraph COMPARISON["Security Mode Comparison"]
        subgraph OPEN["Open (Prohibited)"]
            O_AUTH["No Authentication"]
            O_ENC["No Encryption"]
        end

        subgraph OWE["OWE (Guest Standard)"]
            OWE_AUTH["No Authentication"]
            OWE_ENC["Per-Client Encryption"]
        end

        subgraph WPA3_PERSONAL["WPA3-Personal (IoT)"]
            W3P_AUTH["PSK (SAE)"]
            W3P_ENC["Shared Encryption"]
        end

        subgraph WPA3_ENTERPRISE["WPA3-Enterprise (Corporate)"]
            W3E_AUTH["802.1X Certificates"]
            W3E_ENC["Per-User Encryption"]
        end
    end

    OPEN -->|"Upgrade"| OWE
    OWE -.->|"Add Authentication"| WPA3_PERSONAL
    WPA3_PERSONAL -.->|"Enterprise Auth"| WPA3_ENTERPRISE
```

| Feature | Open | OWE | WPA3-Personal | WPA3-Enterprise |
|---------|------|-----|---------------|-----------------|
| Authentication | None | None | Pre-shared key | 802.1X certificates |
| Encryption | None | Per-client unique | Shared (derived from PSK) | Per-user unique |
| PMF (802.11w) | N/A | Required | Required | Required |
| User friction | None | None | Password required | Certificate/credential |
| Passive eavesdropping | Vulnerable | Protected | Protected | Protected |
| Use case | **Prohibited** | Guest networks | IoT devices | Corporate devices |

## Configuration Standards

### NOLA-GUEST SSID Configuration

| Setting | Value | Rationale |
|---------|-------|-----------|
| Security protocol | **OWE (Enhanced Open)** | Mandatory 2026 standard |
| Encryption | AES-CCMP-128 | Standard OWE cipher |
| PMF (802.11w) | Required | OWE specification requirement |
| Captive portal | Required | Terms of use acceptance |
| Session timeout | 8 hours | Daily re-acceptance |
| VLAN assignment | 100 (GUEST) | Isolated guest network |
| Bands | 2.4 GHz and 5 GHz | Maximum compatibility |
| 6 GHz | Enabled (WiFi 7 clients) | Enhanced performance |
| Broadcast SSID | Visible | Guest discovery |
| Client isolation | Enabled | Prevent client-to-client |
| Bandwidth limit | 10 Mbps down / 5 Mbps up | Fair use policy |

### Access Point Configuration

#### OWE-Only Mode (Recommended)

Configure guest SSIDs for OWE-only operation:

| Setting | Value | Notes |
|---------|-------|-------|
| Security mode | OWE | Enhanced Open |
| AKM suite | OWE (00-0F-AC:18) | Authentication Key Management |
| Pairwise cipher | CCMP-128 | AES encryption |
| Group cipher | CCMP-128 | Broadcast/multicast encryption |
| PMF | Required | Management frame protection |
| Transition mode | Disabled | OWE-only (no legacy fallback) |

#### Transition Mode (OWE + Open Mixed)

For environments requiring legacy device support during migration:

| Setting | Value | Notes |
|---------|-------|-------|
| Primary SSID | NOLA-GUEST | OWE enabled, visible |
| Transition SSID | (auto-generated) | Open, hidden (for legacy) |
| Transition behavior | Automatic steering | OWE clients use OWE; legacy use open |
| Transition end date | December 31, 2026 | Maximum 12-month transition |

**Note:** Transition mode exposes legacy clients to eavesdropping. Use only when absolutely necessary and set a firm end date.

```mermaid
flowchart TD
    CLIENT[Client Device] --> CHECK{Supports OWE?}
    CHECK -->|Yes| OWE_CONNECT["Connect via OWE<br/>(Encrypted)"]
    CHECK -->|No| TRANSITION{Transition Mode<br/>Enabled?}
    TRANSITION -->|Yes| OPEN_CONNECT["Connect via Open<br/>(Unencrypted)"]
    TRANSITION -->|No| FAIL["Connection Failed<br/>(Device Upgrade Required)"]

    OWE_CONNECT --> SECURE["✅ Encrypted Session"]
    OPEN_CONNECT --> INSECURE["⚠️ Unencrypted Session"]
```

### RADIUS/Captive Portal Integration

OWE operates at Layer 2 encryption; captive portal authentication remains at Layer 3:

```mermaid
sequenceDiagram
    participant C as Guest Device
    participant AP as Access Point
    participant FW as Firewall/Controller
    participant PORTAL as Captive Portal

    Note over C,AP: Layer 2: OWE Encryption
    C->>AP: OWE Association (encrypted)
    AP->>C: OWE Association Response

    Note over C,PORTAL: Layer 3: Captive Portal
    C->>FW: HTTP Request (any site)
    FW->>C: Redirect to Portal
    C->>PORTAL: Load Portal Page
    PORTAL->>C: Display Terms of Use
    C->>PORTAL: Accept Terms
    PORTAL->>FW: Authorize Client MAC
    FW->>C: Access Granted
    C->>FW: Internet Access (OWE encrypted to AP)
```

| Component | Configuration |
|-----------|---------------|
| Captive portal trigger | Pre-authentication (before OWE) or post-association |
| Authentication method | Terms acceptance (no credentials) |
| Session tracking | MAC address + session token |
| Session timeout | 8 hours (configurable) |
| Terms re-acceptance | Required daily |

## Security Considerations

### What OWE Protects Against

| Threat | Protection Level | Notes |
|--------|------------------|-------|
| Passive eavesdropping | ✅ Full protection | Each client has unique encryption key |
| Credential sniffing | ✅ Full protection | Traffic encrypted at Layer 2 |
| Session content capture | ✅ Full protection | Encrypted communications |
| Firesheep-style attacks | ✅ Full protection | Session cookies protected |

### What OWE Does NOT Protect Against

| Threat | Protection Level | Mitigation |
|--------|------------------|------------|
| Evil twin / rogue AP | ❌ No protection | Implement rogue AP detection (WIDS) |
| Man-in-the-middle | ❌ No protection | Educate users; use HTTPS |
| Active attacks | ⚠️ Limited | PMF protects management frames |
| AP impersonation | ❌ No protection | No AP authentication mechanism |

**Important:** OWE provides encryption, not authentication. Users should still use HTTPS for sensitive communications, and the City should implement wireless IDS/IPS for rogue AP detection.

### PMF (Protected Management Frames) Requirement

PMF (802.11w) is mandatory for OWE and prevents:

- Deauthentication attacks
- Disassociation attacks
- Management frame spoofing

```mermaid
graph TD
    subgraph PMF_PROTECTION["PMF Protection (Required for OWE)"]
        DEAUTH["Deauth Attacks"] -->|"Blocked"| PMF["Protected Management Frames"]
        DISASSOC["Disassoc Attacks"] -->|"Blocked"| PMF
        SPOOFED["Spoofed Frames"] -->|"Blocked"| PMF
    end

    PMF --> SECURE["Stable Connection"]
```

## Implementation Checklist

### Pre-Deployment

- [ ] Verify all guest APs support OWE (WiFi 7 mandatory for new deployments)
- [ ] Confirm WiFi management platform supports OWE configuration
- [ ] Review captive portal integration with OWE
- [ ] Plan transition mode timeline (if legacy devices require support)
- [ ] Update guest network documentation

### Deployment

- [ ] Configure NOLA-GUEST SSID with OWE security
- [ ] Enable PMF (802.11w) - required for OWE
- [ ] Verify captive portal redirect functions with OWE
- [ ] Test with OWE-capable devices (iOS, Android, Windows, macOS)
- [ ] Test client isolation (guest-to-guest blocked)
- [ ] Verify bandwidth limits applied

### Post-Deployment

- [ ] Monitor OWE connection success rates
- [ ] Track legacy device connection failures (if OWE-only mode)
- [ ] Review security logs for anomalies
- [ ] Document any exceptions requiring transition mode
- [ ] Set calendar reminder for transition mode end date

### Validation Testing

| Test | Method | Pass Criteria |
|------|--------|---------------|
| OWE connection | Connect with iOS/Android/Windows | Successful encrypted connection |
| Encryption verification | Packet capture | Traffic encrypted (not readable) |
| PMF verification | Management frame capture | Frames protected |
| Captive portal | Fresh connection | Portal redirect and terms displayed |
| Client isolation | Ping between guests | No response (blocked) |
| Bandwidth limit | Speed test | ≤10 Mbps down / ≤5 Mbps up |
| Legacy rejection (OWE-only) | Connect with legacy device | Connection refused |

## Cost-Performance Analysis

### Implementation Costs

| Component | Cost | Notes |
|-----------|------|-------|
| Access point upgrades | $0 | WiFi 7 APs (already required) support OWE |
| Controller/management updates | $0 | Included in current platforms |
| Configuration time | 2-4 hours | Per-site SSID configuration |
| Testing time | 1-2 hours | Per-site validation |
| Documentation updates | 4-8 hours | One-time effort |
| **Total per site** | **~$0** | Configuration change only |

### Security Value

| Benefit | Estimated Annual Value | Basis |
|---------|------------------------|-------|
| Guest data breach prevention | $10,000-50,000 | Liability reduction |
| Compliance alignment | Required | NIST SP 800-153 |
| Reputation protection | Significant | Public trust |
| Reduced incident response | $5,000-10,000 | Fewer eavesdropping incidents |

### TCO Comparison

```mermaid
graph LR
    subgraph OPEN_COST["Open WiFi (Prohibited)"]
        O_DEPLOY["Deployment: $0"]
        O_BREACH["Breach risk: $50K/year"]
        O_TOTAL["High risk exposure"]
    end

    subgraph OWE_COST["OWE Enhanced Open"]
        OWE_DEPLOY["Deployment: ~$0"]
        OWE_BREACH["Breach risk: Reduced"]
        OWE_TOTAL["Minimal risk, zero cost"]
    end

    O_TOTAL -->|"Upgrade"| OWE_TOTAL
```

## NIST Alignment

### NIST SP 800-53 Control Mapping

| Control ID | Control Name | OWE Implementation |
|------------|--------------|-------------------|
| AC-18 | Wireless Access | OWE encryption on guest networks |
| AC-18(1) | Authentication and Encryption | AES-CCMP encryption (no authentication for guest) |
| SC-8 | Transmission Confidentiality | Per-client encryption protects guest traffic |
| SC-8(1) | Cryptographic Protection | AES-CCMP-128 or AES-GCMP-256 |
| SC-12 | Cryptographic Key Management | ECDH key exchange per session |
| SC-40 | Wireless Link Protection | PMF (802.11w) required |

### NIST SP 800-153 Compliance

| Requirement | OWE Response |
|-------------|-------------|
| Encrypt wireless traffic | ✅ OWE provides per-client encryption |
| Protect management frames | ✅ PMF required for OWE |
| Segment guest networks | ✅ VLAN 100 isolation maintained |
| Implement access controls | ✅ Captive portal with terms acceptance |

## Troubleshooting Guide

### Common Issues

| Symptom | Likely Cause | Resolution |
|---------|--------------|------------|
| Device won't connect | Device doesn't support OWE | Verify OS version; consider transition mode |
| "Network not secure" warning | Client not recognizing OWE | Update client OS/drivers |
| No captive portal | Portal misconfigured for OWE | Verify portal redirect rules |
| Connection drops | PMF timeout issues | Adjust SA Query timeout |
| Slow connection | DH key exchange overhead | Normal; <100ms impact |

### Diagnostic Flowchart

```mermaid
flowchart TD
    ISSUE[Guest WiFi Issue] --> Q1{Device connects?}
    Q1 -->|No| Q2{OWE-capable device?}
    Q2 -->|No| FIX1["Enable transition mode<br/>or upgrade device"]
    Q2 -->|Yes| FIX2["Update device OS/drivers<br/>Check AP OWE config"]

    Q1 -->|Yes| Q3{Portal displays?}
    Q3 -->|No| FIX3["Verify captive portal<br/>redirect rules"]
    Q3 -->|Yes| Q4{Internet access<br/>after accept?}

    Q4 -->|No| FIX4["Check firewall rules<br/>Verify VLAN routing"]
    Q4 -->|Yes| SUCCESS["Connection OK ✅"]
```

## Migration Timeline

### 2026 OWE Adoption Schedule

```mermaid
gantt
    title OWE Migration Timeline
    dateFormat  YYYY-MM-DD

    section Assessment
    Inventory guest APs          :a1, 2026-02-01, 14d
    Verify OWE support           :a2, 2026-02-01, 7d
    Document legacy devices      :a3, 2026-02-08, 7d

    section Preparation
    Update AP firmware           :p1, 2026-02-15, 14d
    Configure OWE profiles       :p2, 2026-02-22, 7d
    Update captive portal        :p3, 2026-02-22, 7d

    section Deployment
    Enable OWE (transition mode) :d1, 2026-03-01, 1d
    Monitor and validate         :d2, 2026-03-01, 30d
    Disable transition mode      :d3, 2026-12-31, 1d

    section Completion
    OWE-only mode               :c1, 2027-01-01, 1d
```

| Phase | Date | Action |
|-------|------|--------|
| Standard effective | February 2, 2026 | OWE required for new guest deployments |
| Transition period | March 1 - December 31, 2026 | Transition mode permitted for legacy support |
| OWE-only mandate | January 1, 2027 | All guest networks must be OWE-only |

## Procurement Pass/Fail Checklist

Use this checklist to evaluate any wireless infrastructure component before purchase for OWE (Enhanced Open) guest network compliance. Every **Required** item must pass. If any Required item fails, the component is **not approved** for procurement.

### OWE Guest Network Infrastructure Procurement Checklist

| # | Requirement | Required | Pass | Fail |
|---|-------------|----------|------|------|
| 1 | OWE / Wi-Fi CERTIFIED Enhanced Open support | **Yes** | ☐ | ☐ |
| 2 | Protected Management Frames (PMF / 802.11w) mandatory mode | **Yes** | ☐ | ☐ |
| 3 | OWE SSID configuration in wireless management platform | **Yes** | ☐ | ☐ |
| 4 | Captive portal with Layer 3 integration (post-encryption) | **Yes** | ☐ | ☐ |
| 5 | Client isolation (Layer 2) enabled per SSID | **Yes** | ☐ | ☐ |
| 6 | OWE Transition Mode support (open + OWE dual SSID) | **Conditional** | ☐ | ☐ |

### Results

| Outcome | Action |
|---------|--------|
| All Required items pass | **Approved for procurement** |
| Any Required item fails | **Not approved — do not purchase** |
| Questions about a specific device | Contact Network Engineering (ITI Networking Team) |

### How to Verify Requirements

| Checklist Item | Where to Find |
|----------------|---------------|
| OWE / Enhanced Open | Wi-Fi Alliance product finder, vendor spec sheet |
| PMF mandatory mode | Configuration guide, OWE requires PMF by specification |
| OWE SSID configuration | Management platform documentation, SSID setup guide |
| Captive portal L3 integration | Vendor captive portal documentation |
| Client isolation | Per-SSID configuration options, management platform |
| OWE Transition Mode | Firmware release notes, vendor documentation |

## References

1. IEEE 802.11-2020, "Wireless LAN Medium Access Control (MAC) and Physical Layer (PHY) Specifications," IEEE, December 2020.
2. IETF RFC 8110, "Opportunistic Wireless Encryption," IETF, March 2017.
3. IETF RFC 7748, "Elliptic Curves for Security," IETF, January 2016.
4. Wi-Fi Alliance, "WPA3 Specification Version 3.3," Wi-Fi Alliance, July 2024.
5. Wi-Fi Alliance, "Wi-Fi CERTIFIED Enhanced Open," Wi-Fi Alliance, 2018. https://www.wi-fi.org/discover-wi-fi/wi-fi-certified-enhanced-open
6. NIST SP 800-53 Rev. 5, "Security and Privacy Controls for Information Systems and Organizations," NIST, September 2020.
7. NIST SP 800-153, "Guidelines for Securing Wireless Local Area Networks (WLANs)," NIST, February 2012.

---

*For questions about these standards, open an issue or contact the ITI Networking Team.*
