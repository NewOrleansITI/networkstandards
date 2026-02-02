# Outdoor Low-Voltage Cabling Standard Design

**Date:** 2026-02-02
**Status:** Approved
**Author:** ITI Networking Team

## Executive Summary

This design establishes requirements for low-voltage cabling pathways serving outdoor-mounted devices. All wall penetrations to exterior devices must use either conduit (permanent installations) or IP67-rated weatherproof enclosures (temporary installations) to ensure environmental protection, physical security, and tamper resistance.

## Scope

### Devices Covered

- Wireless access points (WiFi 7 and legacy)
- IP security cameras (fixed and PTZ)
- Access control devices (card readers, keypads, electric strikes)
- Intercom and emergency call stations
- Public address speakers and notification devices
- Any other low-voltage device mounted on building exteriors or outdoor structures

### Installation Classifications

| Classification | Definition | Pathway Requirement |
|----------------|------------|---------------------|
| **Permanent** | All outdoor installations not meeting temporary criteria | Conduit with hardened security standard |
| **Temporary** | Event-based deployments: festivals, construction sites, seasonal installations (days to months) | IP67 weatherproof jack enclosure minimum |

### Contractor Requirement

All permanent outdoor low-voltage installations must be performed by or inspected by a licensed low-voltage contractor who certifies compliance with applicable codes.

---

## Conduit Pathway Requirements

### Conduit Type Selection

| Application | Required Conduit | NEC Article | Rationale |
|-------------|------------------|-------------|-----------|
| Exposed runs below 12 ft, public-accessible areas | Rigid Metal Conduit (RMC) or Intermediate Metal Conduit (IMC) | 344 / 342 | Maximum impact and tamper resistance |
| Exposed runs at or above 12 ft, pole mounts | Schedule 80 PVC with metal transition at device | 352 | UV and impact resistant; metal transition prevents pry-off |
| Protected runs (inside walls, above ceilings to penetration point) | EMT with compression fittings | 358 | Cost-effective for protected segments |
| Direct burial segments | Schedule 80 PVC or RMC | 352 / 344 | Burial-rated; minimum 18" depth for PVC, 6" for RMC |

### Conduit Specifications

| Requirement | Specification | Standard Reference |
|-------------|---------------|-------------------|
| Minimum trade size | 3/4" (21mm) for single cable run; 1" (27mm) for multiple cables | TIA-569-E |
| Fill ratio | ≤40% for 3+ cables | TIA-569-E, NEC Chapter 9 |
| Fittings (metallic conduit) | Compression or threaded only; set-screw prohibited outdoors | NEC 342.30, 344.30 |
| Fittings (PVC) | Solvent-welded or gasketed mechanical | NEC 352.48 |
| Metal-to-device transition | Required for all PVC runs; use listed liquidtight flexible metal conduit (LFMC) at device | NEC 350 |
| Expansion fittings | Required for PVC runs >30 ft exposed to temperature variation | NEC 352.44 |

### Pathway Security

- Conduit must be secured at intervals per NEC (RMC/IMC: 10 ft and within 3 ft of boxes; EMT: 10 ft and within 4 ft; PVC: 3 ft and within 3 ft of boxes)
- All accessible junction boxes and device housings must use **Torx or hex-socket security screws**
- Exposed conduit runs should be routed to minimize accessibility where architecturally feasible
- Conduit entry to devices must use weatherproof hubs or fittings rated for wet locations

---

## Wall Penetrations and Sealing

### Seal System Requirements

| Requirement | Specification | Rationale |
|-------------|---------------|-----------|
| Seal type | Modular mechanical seal system (Link-Seal, Thunderline, or equivalent) | Re-enterable for future cable additions; positive seal without curing time |
| Water resistance | Watertight to 15 psi minimum | Prevents water intrusion during wind-driven rain |
| Fire rating | Match wall assembly rating (1-hr, 2-hr) when penetrating fire-rated construction | Code compliance; IBC Section 714 |
| UV resistance | Required for exterior-exposed seal components | Gulf Coast sun exposure |

### Penetration Installation Detail

```
Exterior Wall Penetration Detail (Top View)

    EXTERIOR                    INTERIOR
        │                           │
        │   ┌─────────────────┐     │
        │   │  Modular Seal   │     │
━━━━━━━━┿━━━┿━━━━━━━━━━━━━━━━━┿━━━━━┿━━━━━━  Wall Assembly
        │   │  (Link-Seal)    │     │
        │   └─────────────────┘     │
        │                           │
   Weatherproof              Firestop sealant
   hub/fitting               (if fire-rated wall)
   with drip loop
```

### Installation Sequence

1. Core-drill penetration sized for conduit plus seal system (typically conduit OD + 1")
2. Install sleeve if required by seal manufacturer
3. Install conduit through penetration with exterior weatherproof hub
4. Install modular mechanical seal from interior
5. Apply firestop sealant at interior face if penetrating fire-rated assembly
6. Verify watertight seal with visual inspection
7. Document with photo before concealment

### Prohibited Practices

| Practice | Reason |
|----------|--------|
| Silicone caulk as sole seal | Not re-enterable; degrades over time; not fire-rated |
| Spray foam insulation | Not fire-rated; not watertight under pressure; not re-enterable |
| Unsealed sleeve with putty | Inadequate water protection; fails inspection |
| Penetrations below exterior grade without waterproof membrane | Water infiltration risk |

### Drip Loop Requirement

All cables entering a penetration from exterior conduit must include a drip loop below the penetration point to prevent water tracking along the cable jacket into the building.

---

## Surge Protection and Grounding

### Surge Protection Requirements

All outdoor low-voltage cable runs require surge protection at **both ends** to prevent damage from lightning-induced surges and transients.

| Location | Device Type | Specification |
|----------|-------------|---------------|
| **Device end** (outdoor) | Inline PoE surge protector | IEEE 802.3bt compatible; Cat6A rated; IP66+ for exposed mounting |
| **Switch/panel end** (indoor) | Rack-mount or inline surge protector | IEEE 802.3bt compatible; Cat6A rated; ground reference to TBB |

### Surge Protector Specifications

| Parameter | Minimum Requirement | Rationale |
|-----------|---------------------|-----------|
| Clamping voltage | ≤50V (data pairs) | Protect sensitive electronics |
| Surge current capacity | ≥10 kA per pair | Gulf Coast lightning exposure |
| Response time | ≤1 nanosecond | Fast transient protection |
| PoE compatibility | IEEE 802.3bt Type 4 (90W) | Support WiFi 7 APs and PTZ cameras |
| Data rate support | 10 Gbps / Cat6A | Match cabling standard |
| Status indication | Visual indicator for protection status | Identify failed units |
| Ground connection | Bonding lug or pigtail required | Connection to grounding system |

### Grounding and Bonding

All outdoor conduit systems and devices must be bonded to the building's telecommunications grounding infrastructure per NEC Article 250 and TIA-607-D.

| Requirement | Specification | Standard Reference |
|-------------|---------------|-------------------|
| Metallic conduit bonding | Bond to telecommunications bonding backbone (TBB) or building ground | NEC 250.96, TIA-607-D |
| Surge protector ground | Connect to telecommunications grounding busbar (TGB) | TIA-607-D Section 7 |
| Ground conductor size | Minimum #6 AWG to TGB; #3/0 AWG for TBB | TIA-607-D |
| Bonding jumpers | Required at all conduit joints using compression fittings | NEC 250.98 |
| Outdoor device enclosures | Bond metallic enclosures to conduit ground path | NEC 250.4 |

### Public Safety Facility Requirements

Installations at police, fire, emergency services, and 911 facilities require enhanced lightning protection:

| Additional Requirement | Specification | Standard Reference |
|------------------------|---------------|-------------------|
| Lightning protection system integration | Bond outdoor conduit to LPS ground ring or down conductor | NFPA 780 Section 4.9 |
| Separation distance | Maintain separation or bond per NFPA 780 calculations | NFPA 780 Section 4.8 |
| Inspection | Annual inspection of bonding connections | NFPA 780 Annex D |

### Grounding Topology

```
Outdoor Device
      │
      ├── Surge Protector (device end) ──┐
      │                                  │
   Metallic Conduit                      │
      │                                  │
   Wall Penetration                      │
      │                                  │
   Bonding Jumper ───────────────────────┼──► TGB (Telecom Grounding Busbar)
      │                                  │            │
      ├── Surge Protector (panel end) ───┘            │
      │                                               │
   Patch Panel / Switch                               │
                                                      ▼
                                              TBB (Bonding Backbone)
                                                      │
                                                      ▼
                                              Building Ground Electrode
```

---

## Cable Requirements

### Outdoor Cable Specifications

All cables installed in outdoor conduit pathways must use outdoor-rated jackets regardless of conduit protection.

| Requirement | Specification | Standard Reference |
|-------------|---------------|-------------------|
| Cable category | Cat6A minimum | TIA-568.2-D |
| Outdoor jacket rating | CMX (outdoor), CMXT (outdoor/UV), or direct burial | NEC Article 800 |
| UV resistance | Required for all outdoor-rated cables | — |
| Temperature rating | -40°C to +75°C minimum | Gulf Coast temperature extremes |
| Water resistance | Gel-filled or dry water-blocking tape | Prevents water migration |

### Prohibited Cable Types for Outdoor Runs

| Cable Type | Reason for Prohibition |
|------------|------------------------|
| CMR (riser) | Not rated for moisture or UV exposure |
| CMP (plenum) | Not rated for moisture; jacket may crack outdoors |
| Standard CM | No environmental protection |
| Non-shielded in high-EMI areas | Interference from nearby power or RF sources |

### Cable Selection by Application

| Application | Required Cable | Rationale |
|-------------|----------------|-----------|
| Standard outdoor device | Cat6A CMX or CMXT, unshielded (U/UTP) | Cost-effective; conduit provides shielding |
| High-EMI environment (near transformers, generators) | Cat6A F/UTP outdoor-rated | Foil shield for interference rejection |
| Direct burial segments | Cat6A direct burial with gel fill | Full burial rating even inside conduit |
| Runs >50m with temperature variation | Cat6A with dry water-blocking | Prevents condensation wicking |

### Cable Installation Requirements

| Requirement | Specification | Standard Reference |
|-------------|---------------|-------------------|
| Bend radius | ≥4× cable OD during installation; ≥1× at rest | TIA-568.2-D |
| Pull tension | ≤25 lbf for 4-pair Cat6A | TIA-568.2-D |
| Service loop at device | 3-5 ft coiled in weatherproof enclosure or junction box | Best practice |
| Labeling | Both ends per TIA-606-C; outdoor-rated label material | TIA-606-C |

---

## Temporary Installation Standards

### Scope

Temporary installations are limited to event-based deployments including festivals, parades, construction sites, and seasonal operations. Maximum deployment duration: **6 months**. Installations exceeding 6 months must be converted to permanent conduit pathways.

### Weatherproof Jack Requirements

| Requirement | Specification | Rationale |
|-------------|---------------|-----------|
| Enclosure rating | **IP67 minimum** | Dust-tight; withstands temporary immersion; Gulf Coast rain |
| Connector type | Shielded RJ45 with weatherproof cap or gland | Maintains seal when cable connected |
| Mounting | Weatherproof back box or pole-mount enclosure | Prevents water pooling |
| Cable entry | Gasketed cable glands; no open knockouts | Maintains IP rating |

### Temporary Installation Detail

```
Temporary Outdoor Connection Detail

┌─────────────────────────────────┐
│   IP67 Weatherproof Enclosure   │
│  ┌───────────────────────────┐  │
│  │                           │  │
│  │   Shielded RJ45 Jack      │  │
│  │   with weatherproof       │  │
│  │   cover (closed when      │  │
│  │   not in use)             │  │
│  │                           │  │
│  └───────────────────────────┘  │
│          ▲                      │
│          │ Drip loop inside     │
│          │                      │
└──────────┼──────────────────────┘
           │
    Gasketed cable gland
           │
    Outdoor-rated Cat6A cable
    to interior patch panel
```

### Temporary Installation Restrictions

| Restriction | Requirement |
|-------------|-------------|
| Wall penetrations | Must still use proper seal system; no temporary penetration methods |
| Surge protection | Required at both ends (same as permanent) |
| Maximum duration | 6 months; convert to conduit if extended |
| Documentation | Installation date recorded; removal/conversion date scheduled |
| Inspection | Weekly visual inspection during deployment |

### Conversion Trigger

Any temporary installation that will remain in place beyond 6 months, or that will be used for subsequent events at the same location, must be converted to a permanent conduit installation before continued use.

---

## Documentation and Inspection Requirements

### Required Documentation Package

| Document | Format | Retention |
|----------|--------|-----------|
| Pre-installation site survey | PDF with photos | Permanent |
| As-built pathway drawing | PDF + CAD/Visio | Permanent |
| Photo documentation | JPEG/PNG, minimum 2MP | 10 years |
| Inspection checklist (signed) | PDF with signatures | Permanent |
| Cable test results | Fluke/equivalent export | 10 years |
| Surge protector installation record | Spreadsheet with serial numbers | Life of equipment |
| Contractor certification | Signed PDF | Permanent |

### Photo Documentation Requirements

Photograph each of the following stages. Include a date stamp or date placard in frame:

| Stage | Required Photos | Purpose |
|-------|-----------------|---------|
| **Pre-installation** | Penetration location; existing conditions | Baseline documentation |
| **Conduit pathway** | Complete run showing routing and supports | Verify installation quality |
| **Wall penetration (exterior)** | Weatherproof hub and drip loop | Verify weather seal |
| **Wall penetration (interior)** | Modular seal and firestop (if applicable) | Verify fire/water seal |
| **Surge protectors** | Both device-end and panel-end units installed | Verify dual protection |
| **Grounding connections** | Bonding jumpers and TGB connection | Verify grounding path |
| **Device mounting** | Final device installation with security hardware | Verify tamper resistance |
| **Labeling** | Cable labels at both ends | Verify TIA-606-C compliance |

### Inspection Checklist

| Category | Inspection Item | Verified | N/A |
|----------|-----------------|:--------:|:---:|
| **Conduit** | Conduit type matches specification for application | ☐ | ☐ |
| | Fittings are compression or threaded (no set-screw) | ☐ | ☐ |
| | Conduit secured at proper intervals | ☐ | ☐ |
| | Metal transition installed at device (PVC runs) | ☐ | ☐ |
| **Penetration** | Modular mechanical seal installed | ☐ | ☐ |
| | Firestop applied (fire-rated assemblies) | ☐ | ☐ |
| | Drip loop present below penetration | ☐ | ☐ |
| | Weatherproof hub installed at exterior | ☐ | ☐ |
| **Cable** | Outdoor-rated jacket (CMX/CMXT/direct burial) | ☐ | ☐ |
| | Cat6A minimum category | ☐ | ☐ |
| | Service loop at device (3-5 ft) | ☐ | ☐ |
| | Cable test passed (attach results) | ☐ | ☐ |
| **Surge Protection** | Device-end surge protector installed | ☐ | ☐ |
| | Panel-end surge protector installed | ☐ | ☐ |
| | Both surge protectors bonded to ground | ☐ | ☐ |
| | Status indicators show protection active | ☐ | ☐ |
| **Grounding** | Metallic conduit bonded to TGB | ☐ | ☐ |
| | Bonding jumpers at conduit joints (compression fittings) | ☐ | ☐ |
| | LPS integration verified (public safety only) | ☐ | ☐ |
| **Security** | Torx/hex-socket security screws on accessible boxes | ☐ | ☐ |
| | Device mounted at specified height | ☐ | ☐ |
| **Labeling** | Cable labeled at both ends per TIA-606-C | ☐ | ☐ |
| | Outdoor labels use UV-resistant material | ☐ | ☐ |

### Sign-off Requirements

| Role | Responsibility | Signature Required |
|------|----------------|:------------------:|
| Installing contractor | Certifies installation per specifications and applicable codes | ✓ |
| Licensed low-voltage contractor | Certifies NEC compliance (if different from installer) | ✓ |
| City inspector or project manager | Accepts installation; authorizes commissioning | ✓ |

### As-Built Drawing Requirements

Update facility drawings to include:

- Conduit pathway routing with trade sizes
- Penetration locations with seal type noted
- Surge protector locations (both ends)
- Grounding/bonding connection points
- Device location with mounting height
- Cable ID cross-referenced to patch panel port

---

## Code References and Standards

### National Electrical Code (NEC) References

| Article | Title | Application |
|---------|-------|-------------|
| Article 250 | Grounding and Bonding | Grounding of conduit systems, enclosures, and surge protection devices |
| Article 300 | General Requirements for Wiring Methods | Conduit installation, conductor protection |
| Article 342 | Intermediate Metal Conduit (IMC) | IMC installation requirements |
| Article 344 | Rigid Metal Conduit (RMC) | RMC installation requirements |
| Article 350 | Liquidtight Flexible Metal Conduit (LFMC) | Flexible transitions at devices |
| Article 352 | Rigid Polyvinyl Chloride Conduit (PVC) | PVC conduit installation and expansion |
| Article 358 | Electrical Metallic Tubing (EMT) | EMT installation for protected runs |
| Article 725 | Class 1, Class 2, and Class 3 Remote-Control, Signaling, and Power-Limited Circuits | Access control, intercoms, sensors |
| Article 800 | Communications Circuits | Network cabling, PoE circuits |
| Article 820 | Community Antenna Television and Radio Distribution Systems | Coaxial installations (if applicable) |

### TIA Standards

| Standard | Title | Application |
|----------|-------|-------------|
| TIA-568.2-D | Balanced Twisted-Pair Telecommunications Cabling | Cable category, termination, testing |
| TIA-569-E | Telecommunications Pathways and Spaces | Conduit sizing, fill ratios, bend radius |
| TIA-606-C | Administration Standard | Labeling requirements |
| TIA-607-D | Generic Telecommunications Bonding and Grounding | TGB, TBB, bonding topology |
| TIA-1152-A | Field Testing Requirements | Cable certification testing |

### Other Referenced Standards

| Standard | Title | Application |
|----------|-------|-------------|
| NFPA 780 | Standard for the Installation of Lightning Protection Systems | Public safety facility LPS integration |
| IEC 60529 | Degrees of Protection (IP Code) | Enclosure ratings (IP67) |
| IBC Section 714 | Fire-Resistant Penetrations | Firestopping at rated assemblies |
| IEEE 802.3bt | Power over Ethernet | Surge protector PoE compatibility |
| BICSI TDMM 14th Ed. | Telecommunications Distribution Methods Manual | Installation best practices |

### Contractor Licensing Requirements

| Requirement | Specification |
|-------------|---------------|
| License type | State-licensed low-voltage contractor (Louisiana R.S. 37:2156) or equivalent |
| Scope | All permanent outdoor low-voltage installations |
| Certification | Contractor provides signed certification of code compliance |
| Insurance | Contractor must carry liability insurance per city procurement requirements |

### Inspection Authority

The City of New Orleans ITI Networking Team or designated project manager serves as inspection authority and must approve all permanent outdoor installations before commissioning. The inspection authority may require corrections or additional documentation before acceptance.

---

## Implementation

This standard applies to:

- All new outdoor low-voltage installations effective upon adoption
- Existing installations when modified or extended
- Replacement of failed outdoor cabling pathways

Updates required in:

- `docs/ethernet/cabling-standards.md` — New "Outdoor Installation Requirements" section
- `docs/wifi/access-point-specs.md` — Cross-reference in outdoor AP section
- `docs/ethernet/port-configurations.md` — Camera and outdoor device port notes

---

*Approved: 2026-02-02*
