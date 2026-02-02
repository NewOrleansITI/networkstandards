# Code of Conduct

## City of New Orleans Network Standards Repository

**Version:** 1.1.0
**Effective Date:** February 2, 2026

---

## Our Commitment

Welcome to the City of New Orleans Network Standards Repository! We're building something valuable together—vendor-neutral documentation that helps our city's infrastructure serve everyone better.

We believe the best communities are built on mutual respect and a shared commitment to learning. Whether you're a seasoned network engineer or just getting started, you belong here.

This Code of Conduct applies to all repository spaces, including issues, pull requests, discussions, and any other communication channels associated with this project.

---

## Community First Philosophy

**We lead with education, not punishment.** Most issues arise from misunderstandings, not malice.

- **Assume good intent** — When someone makes a mistake, start with a friendly conversation
- **Coach first** — Private feedback is almost always more effective than public correction
- **Build people up** — Help contributors learn and grow, even when addressing problems
- **Reserve bans for bad actors** — Permanent exclusion is for those who genuinely want to cause harm

The vast majority of contributors will never need anything beyond a friendly nudge. That's exactly how it should be.

---

## Professional Standards

### Expected Behavior

All community members are expected to:

```mermaid
graph TD
    subgraph PROFESSIONAL["Professional Conduct"]
        A[Use professional language]
        B[Provide constructive feedback]
        C[Focus on technical merit]
        D[Respect differing viewpoints]
        E[Accept responsibility for mistakes]
        F[Prioritize community benefit]
    end
    
    subgraph COLLABORATIVE["Collaborative Spirit"]
        G[Welcome newcomers]
        H[Share knowledge openly]
        I[Credit others' contributions]
        J[Seek to understand before criticizing]
        K[Assume positive intent]
    end
    
    PROFESSIONAL --> SUCCESS[Healthy Community]
    COLLABORATIVE --> SUCCESS
```

#### Specifically:

1. **Use Professional Language**
   - Communicate clearly and respectfully
   - Avoid slang, jargon, or colloquialisms that may confuse non-native speakers
   - Write as if your communications will be read by your employer

2. **Provide Constructive Feedback**
   - Critique ideas, not people
   - Offer specific, actionable suggestions
   - Acknowledge strengths before addressing weaknesses

3. **Focus on Technical Merit**
   - Evaluate contributions based on standards compliance and quality
   - Support positions with evidence and references
   - Remain objective in technical discussions

4. **Respect Differing Viewpoints**
   - Acknowledge that reasonable people can disagree
   - Engage thoughtfully with alternative perspectives
   - Seek common ground where possible

5. **Welcome All Experience Levels**
   - Be patient with those learning
   - Provide helpful guidance to newcomers
   - Never dismiss questions as "obvious" or "basic"

---

## Prohibited Conduct

The following behaviors are strictly prohibited and will result in immediate moderation action:

### Zero Tolerance Violations

```mermaid
graph LR
    subgraph ZERO["Zero Tolerance — Immediate Ban"]
        Z1[Threats of violence]
        Z2[Discriminatory harassment]
        Z3[Sexual harassment]
        Z4[Doxxing/privacy violation]
        Z5[Targeted personal attacks]
    end
    
    Z1 --> BAN[Permanent Ban]
    Z2 --> BAN
    Z3 --> BAN
    Z4 --> BAN
    Z5 --> BAN
```

### Serious Violations

| Violation | Description | First Offense | Repeat |
|-----------|-------------|---------------|--------|
| **Profanity** | Use of vulgar, obscene, or offensive language | Warning | Suspension |
| **Harassment** | Repeated unwelcome contact or attention | Warning | Suspension |
| **Personal attacks** | Insulting or demeaning individuals | Warning | Suspension |
| **Discrimination** | Bias based on protected characteristics | Permanent ban | — |
| **Trolling** | Deliberately inflammatory or disruptive posts | Warning | Suspension |
| **Spam** | Unsolicited promotional content | Removal | Warning |
| **Vendor promotion** | Marketing specific products or services | Warning | Suspension |

### Moderate Violations

| Violation | Description | Action |
|-----------|-------------|--------|
| **Off-topic discussions** | Derailing technical threads | Warning, post removal |
| **Unconstructive criticism** | Complaints without solutions | Coaching |
| **Dismissive responses** | Belittling legitimate questions | Warning |
| **Excessive self-promotion** | Repeated references to personal work | Warning |

---

## Scope of Application

This Code of Conduct applies to:

- **GitHub Repository**
  - Issues and issue comments
  - Pull requests and PR reviews
  - Discussions
  - Commit messages
  - Wiki pages

- **Associated Platforms**
  - Any official project communication channels
  - Project-related social media accounts
  - Conference presentations about this project

- **Public Representation**
  - When speaking on behalf of the project
  - When identified as a project contributor in professional settings

---

## Enforcement

### Enforcement Process

```mermaid
flowchart TD
    A[Violation Reported/Observed] --> B{Severity?}

    B -->|Zero Tolerance| C[Immediate Permanent Ban]
    B -->|Serious/Moderate| D[Private Coaching]
    B -->|Minor| D

    D --> E{Resolved?}
    E -->|Yes| F[Continue Participation]
    E -->|Pattern continues| G[Formal Warning]

    G --> H{Behavior improves?}
    H -->|Yes| F
    H -->|No| I[Suspension 7-30 days]

    I --> J{Returns and repeats?}
    J -->|No| F
    J -->|Yes| C

    C --> K[Account Blocked<br/>No Appeal for Zero Tolerance]
```

### Enforcement Actions

| Level | Action | Duration | Appeal |
|-------|--------|----------|--------|
| **Coaching** | Private feedback on behavior | N/A | N/A |
| **Warning** | Public or private notice | Documented | N/A |
| **Suspension** | Temporary participation ban | 7-30 days | N/A |
| **Permanent Ban** | Permanent exclusion | Indefinite | After 6 months |

### Reporting Violations

To report a Code of Conduct violation:

1. **GitHub Issues** — For public violations, open an issue with the `code-of-conduct` label
2. **Email** — For sensitive matters, email networkingteam@nola.gov with subject line "CoC Report"
3. **Direct Message** — Contact the maintainer directly on GitHub

**Report should include:**
- Description of the incident
- Link to the offending content (if applicable)
- Any additional context
- Your preferred resolution (optional)

**Response Timeline:**
- Acknowledgment within 48 hours
- Initial assessment within 7 days
- Resolution within 14 days (complex cases may take longer)

---

## Appeals

### Appeal Process

Only permanent bans may be appealed. Participants who have been permanently banned may request reconsideration by:

1. Waiting at least 6 months from the date of the ban
2. Emailing networkingteam@nola.gov with:
   - Acknowledgment of the original violation
   - What you've learned from the experience
   - Why you believe you should be allowed to return
3. Awaiting review by the maintainer (within 14 days)

**Note:** Zero tolerance violations (threats, harassment, doxxing) result in permanent bans with no appeal option.

Appeals are reviewed by the maintainer with input from the reviewer team. Decisions are final.

---

## Contributor Responsibilities

### All Contributors

- Read and understand this Code of Conduct
- Follow the guidelines in all project spaces
- Report violations when observed
- Accept enforcement decisions gracefully

### Reviewers

- Model exemplary professional conduct
- Apply enforcement fairly and consistently
- Escalate serious violations to the maintainer
- Protect reporter confidentiality

### Maintainer

- Final authority on enforcement decisions
- Ensure consistent application of standards
- Review appeals fairly
- Update this Code of Conduct as needed

---

## Acknowledgment

This Code of Conduct is adapted from:
- [Contributor Covenant](https://www.contributor-covenant.org/) v2.1
- [Django Code of Conduct](https://www.djangoproject.com/conduct/)
- Federal workplace conduct standards

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.1.0 | 2026-02-02 | Lighter tone; education-first approach; graduated responses for serious violations; appeals limited to permanent bans only |
| 1.0.0 | 2026-02-02 | Initial release |

---

## Contact

- **Maintainer:** Christopher, City of New Orleans ITI
- **Email:** networkingteam@nola.gov
- **Response Time:** Within 48 hours for Code of Conduct matters

---

*By participating in this project, you agree to abide by this Code of Conduct.*
