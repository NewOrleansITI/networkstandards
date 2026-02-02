# City of New Orleans Network Standards

**Vendor-neutral, open-source network infrastructure standards for municipal deployments.**

[![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)
[![Standards: IEEE/ANSI/TIA](https://img.shields.io/badge/Standards-IEEE%20%7C%20ANSI%20%7C%20TIA-blue.svg)](#standards-framework)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

## Overview

This repository is a public, open-source initiative by the City of New Orleans Department of Information Technology and Innovation to establish vendor-neutral wired and wireless networking standards for municipal infrastructure.

**Dual Purpose:**
1. Standardize internal City of New Orleans network deployments
2. Provide a collaborative resource for other municipalities, IT professionals, and the public

All standards are derived exclusively from public governing bodies (IEEE, ANSI, TIA, IETF, ISO, NIST) and prioritize **security > reliability > cost-effectiveness > features** with 15+ year infrastructure lifecycles in mind.

**Current Key Policies:**
- **WiFi 7 Mandatory** — All new AP deployments must use 802.11be (2026)
- **4 SSID Maximum** — Hard limit per access point for performance
- **OWE Required** — Guest networks must use Enhanced Open encryption

## Documentation

### Wired Ethernet

| Document | Description | Status |
|----------|-------------|--------|
| [Cabling Standards](docs/ethernet/cabling-standards.md) | Structured cabling categories, testing, TIA-568 compliance | Supported |
| [Switch Specifications](docs/ethernet/switch-specifications.md) | Layer 2/3 switch requirements, stacking, PoE standards | Supported |
| [Port Configurations](docs/ethernet/port-configurations.md) | VLAN assignments, port security, naming conventions | Supported |

### Wireless (WiFi)

| Document | Description | Status |
|----------|-------------|--------|
| [Access Point Specifications](docs/wifi/access-point-specs.md) | AP requirements, placement guidelines, WiFi 7 (802.11be) standards | Supported |
| [SSID Standards](docs/wifi/ssid-standards.md) | Network naming, WPA3 security, segmentation | Supported |
| [Deployment Procedures](docs/wifi/deployment-procedures.md) | Site surveys, installation, validation procedures | Supported |

### Security

| Document | Description | Status |
|----------|-------------|--------|
| [802.1X Implementation](docs/security/802.1x-implementation.md) | IEEE 802.1X port-based network access control | Supported |
| [WPA3-Enterprise Standards](docs/security/wpa3-enterprise.md) | WPA3-Enterprise wireless security requirements | Supported |
| [Network Segmentation](docs/security/network-segmentation.md) | VLAN architecture, security zones, microsegmentation | Supported |
| [OWE Enhanced Open](docs/security/owe-enhanced-open.md) | Opportunistic Wireless Encryption for guest networks | Supported |

### Layer 3 (Network)

| Document | Description | Status |
|----------|-------------|--------|
| [IP Addressing Standards](docs/layer3/ip-addressing.md) | IP allocation, subnetting, DHCP, IPAM | Supported |
| [Routing Standards](docs/layer3/routing-standards.md) | OSPF, BGP, FHRP, route management | Supported |

### Network Services

| Document | Description | Status |
|----------|-------------|--------|
| [DNS Standards](docs/services/dns-standards.md) | DNS architecture, DNSSEC, zone management | Supported |
| [DHCP Standards](docs/services/dhcp-standards.md) | DHCP failover, scopes, IPAM integration | Supported |
| [NTP Standards](docs/services/ntp-standards.md) | Time synchronization, NTS security | Supported |

## Standards Framework

All documentation references standards from recognized public governing bodies only:

| Organization | Scope | Key Standards |
|--------------|-------|---------------|
| **IEEE** | Ethernet, WiFi, bridging | 802.3, 802.11, 802.1Q, 802.1X |
| **ANSI** | US national standards | Endorses TIA/EIA standards |
| **TIA** | Telecommunications infrastructure | TIA-568, TIA-569, TIA-606 |
| **IETF** | Internet protocols | RFCs for IP, DNS, DHCP, EAP |
| **ISO** | International standards | ISO/IEC 11801 (generic cabling) |
| **NIST** | Security frameworks | SP 800 series, Zero Trust |
| **BICSI** | Cabling best practices | TDMM, installer certifications |

**Explicitly excluded:** Vendor whitepapers, proprietary specifications, paid analyst reports (Gartner, IDC, Forrester).

## Documentation Standards

Every standards document in this repository includes:

- **Standard Reference** — IEEE/ANSI/TIA/IETF number
- **Ratification Date** — When officially adopted
- **Industry Adoption Data** — Current deployment statistics with sources
- **Cost-Performance Analysis** — TCO framework for municipal budgets
- **Security Rationale** — NIST SP 800-53 control alignment
- **Visual Diagrams** — Mermaid diagrams for architecture visualization

### Document Lifecycle

| Status | Definition |
|--------|------------|
| **Supported** | Actively recommended for new deployments |
| **Legacy** | Acceptable for existing installations, not for new |
| **Deprecated** | Should be replaced when possible |

## RFC Process

New standards or significant changes require a Request for Comments (RFC):

1. **Draft** — Create RFC using [RFC-TEMPLATE.md](rfcs/RFC-TEMPLATE.md)
2. **Discussion** — 30-day minimum comment period
3. **Review** — Team evaluation against standards criteria
4. **Decision** — Maintainer approval or rejection with rationale
5. **Implementation** — PR submitted referencing accepted RFC

See the [Contributing Guide](CONTRIBUTING.md) for the complete governance model and RFC lifecycle.

## Project Structure

```
networkstandards/
├── docs/                    # Standards documentation
│   ├── ethernet/            # Wired network standards
│   ├── wifi/                # Wireless network standards
│   ├── security/            # Security standards (802.1X, WPA3, segmentation)
│   ├── layer3/              # Layer 3 standards (IP, routing)
│   ├── services/            # Network services (DNS, DHCP, NTP)
│   ├── plans/               # Implementation design documents
│   └── index.md             # Documentation home
├── rfcs/                    # RFC proposals
│   └── RFC-TEMPLATE.md      # RFC template
├── .github/                 # GitHub configuration
│   ├── ISSUE_TEMPLATE/      # Issue templates
│   ├── workflows/           # GitHub Actions
│   └── PULL_REQUEST_TEMPLATE.md
├── CONTRIBUTING.md          # Contribution guidelines
├── CODE_OF_CONDUCT.md       # Community standards
└── README.md                # This file
```

## Contributing

We welcome contributions from city staff, municipal IT professionals, subject matter experts, and the broader community.

### Ways to Contribute

| Action | Use Case |
|--------|----------|
| **Open an Issue** | Report errors, request clarification, suggest improvements |
| **Submit an RFC** | Propose new standards or significant changes |
| **Submit a PR** | Fix typos, improve diagrams, enhance documentation |

### Issue Templates

- **Standard Proposal** — Propose a new standard or major update
- **Standard Update** — Request updates to existing standards
- **Clarification Request** — Request clarification on existing documentation
- **Security Concern** — Report security-related issues
- **Bug Report** — Report errors or issues in documentation
- **New Documentation** — Request new documentation topics

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines.

## Quick Links

| Resource | Description |
|----------|-------------|
| [Documentation Site](https://neworleansiti.github.io/networkstandards/) | Web-friendly documentation |
| [Skills & MCP Guide](SKILLS_AND_MCP_RECOMMENDATIONS.md) | Team skills assessment and AI tooling recommendations |
| [RFC Template](rfcs/RFC-TEMPLATE.md) | Template for standards proposals |

## Roadmap

### Completed

- [x] Layer 1 Standards (Cabling, Fiber, Testing)
- [x] Switching Standards (Specifications, Port Configurations)
- [x] Wireless Standards (AP Specs, SSID, Deployment)
- [x] Security Standards (802.1X, WPA3-Enterprise, Segmentation)
- [x] Layer 3 Standards (IP Addressing, Routing, FHRP)
- [x] Network Services (DNS, DHCP, NTP)

### Planned

- [ ] QoS and Traffic Management
- [ ] Certificate Management and PKI
- [ ] Network Monitoring and Observability

## For Other Municipalities

This repository is designed to be forked and adapted. If you're a municipal IT department:

1. **Fork** this repository
2. **Customize** standards for your environment
3. **Contribute back** improvements that benefit everyone
4. **Share** your experience via issues or discussions

We encourage collaboration to build a shared body of knowledge for municipal networking.

## License

This documentation is licensed under [Creative Commons Attribution 4.0 International (CC BY 4.0)](LICENSE).

You are free to:
- **Share** — Copy and redistribute in any medium or format
- **Adapt** — Remix, transform, and build upon the material

With attribution to the City of New Orleans Department of Information Technology and Innovation.

## Contact

| Channel | Details |
|---------|---------|
| **Maintainer** | City of New Orleans ITI Networking Team |
| **Issues** | [GitHub Issues](https://github.com/NewOrleansITI/networkstandards/issues) |
| **Discussions** | [GitHub Discussions](https://github.com/NewOrleansITI/networkstandards/discussions) |

---

*Maintained by the City of New Orleans Department of Information Technology and Innovation*

*Building open standards for municipal networks — together.*

