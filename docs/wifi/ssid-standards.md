# SSID Standards

*Last Updated: February 2026*

## Overview

This document defines the standard SSIDs, security settings, and network segmentation for City of New Orleans wireless networks.

## Standard SSIDs

| SSID Name | Purpose | Authentication | VLAN | Visibility |
|-----------|---------|----------------|------|------------|
| NOLA-CORP | City employee devices | 802.1X (EAP-TLS) | 20 | Hidden |
| NOLA-GUEST | Visitor/public access | Captive portal | 100 | Broadcast |
| NOLA-IOT | IoT devices | WPA3-Personal (PSK) | 200 | Hidden |
| NOLA-SECURE | Restricted systems | 802.1X (EAP-TLS) + certificates | 50 | Hidden |

> **Note:** Adjust SSID names and VLANs based on your organization's requirements.

## SSID Details

### NOLA-CORP (Corporate)

**Purpose:** Primary network for city-owned devices and employees.

| Setting | Value |
|---------|-------|
| Security | WPA3-Enterprise (802.1X) |
| Authentication | EAP-TLS with device certificates |
| RADIUS Server | [Your RADIUS server] |
| Band | 5 GHz preferred, 2.4 GHz available |
| VLAN | 20 (CORP) |
| Visibility | Hidden (not broadcast) |
| Client isolation | Disabled |

### NOLA-GUEST (Guest)

**Purpose:** Internet access for visitors, public, and personal devices.

| Setting | Value |
|---------|-------|
| Security | Open with captive portal |
| Authentication | Captive portal acceptance |
| Terms of use | Required acceptance |
| Session timeout | 8 hours |
| Bandwidth limit | 10 Mbps down / 5 Mbps up |
| Band | 2.4 GHz and 5 GHz |
| VLAN | 100 (GUEST) |
| Visibility | Broadcast |
| Client isolation | Enabled |

**Restrictions:**
- No access to internal city resources
- Content filtering enabled
- Logged for compliance

### NOLA-IOT (Internet of Things)

**Purpose:** Connected devices (sensors, displays, smart devices).

| Setting | Value |
|---------|-------|
| Security | WPA3-Personal (SAE) |
| Pre-shared key | [Managed via secure process] |
| Band | 2.4 GHz only (IoT compatibility) |
| VLAN | 200 (IOT) |
| Visibility | Hidden |
| Client isolation | Enabled |

**Access Controls:**
- Firewall restricts IoT VLAN to specific destinations
- No access to corporate network
- Outbound internet: Limited to required services

### NOLA-SECURE (Restricted)

**Purpose:** High-security systems and applications.

| Setting | Value |
|---------|-------|
| Security | WPA3-Enterprise (802.1X) |
| Authentication | EAP-TLS with user + device certificates |
| Additional | MAC filtering (allowlist) |
| Band | 5 GHz only |
| VLAN | 50 (SECURE) |
| Visibility | Hidden |
| Client isolation | Disabled |

## Security Requirements

### All SSIDs

- WPA3 required for new deployments (WPA2 transitional mode acceptable during migration)
- Disable legacy protocols (WEP, WPA, TKIP)
- Enable Protected Management Frames (PMF/802.11w)
- Configure proper session timeouts

### RADIUS Configuration

- Use RADIUS server for 802.1X authentication
- Configure redundant RADIUS servers
- Enable RADIUS accounting for audit logs
- Integrate with city identity management (Active Directory/LDAP)

### Rate Limiting

| SSID | Download | Upload |
|------|----------|--------|
| NOLA-CORP | Unlimited | Unlimited |
| NOLA-GUEST | 10 Mbps | 5 Mbps |
| NOLA-IOT | 5 Mbps | 2 Mbps |
| NOLA-SECURE | Unlimited | Unlimited |

## RF Settings

### Channel Planning

| Band | Channel Width | Channels |
|------|---------------|----------|
| 2.4 GHz | 20 MHz | 1, 6, 11 only |
| 5 GHz | 40 MHz | Non-DFS preferred: 36, 44, 149, 157 |
| 6 GHz | 80 MHz | Per WiFi 6E planning |

### Power Settings

- Use automatic power control when available
- Maximum power: Set based on site survey
- Minimum power: Prevent coverage holes

---

*For questions about these standards, open an issue or contact the ITI Networking Team.*
