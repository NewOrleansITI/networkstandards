#!/usr/bin/env bash
#
# standards-monitor.sh
# Daily check for network standards updates relevant to City of New Orleans
# network documentation. Sends email summary via msmtp.
#
# Monitored standards bodies:
#   - IEEE (802.11, 802.3, 802.1X)
#   - Wi-Fi Alliance (WPA3, WiFi 7 certification)
#   - IETF (TLS, EAP, RADIUS RFCs)
#   - NIST (SP 800-53, SP 800-153)
#
# Usage: Run via cron daily at 07:00
#   0 7 * * * /opt/networkdocumentation/scripts/standards-monitor.sh

set -euo pipefail

REPO_DIR="/opt/networkdocumentation"
RECIPIENT="cjwolff@nola.gov"
SENDER="switchmon@cityofno.com"
HOSTNAME=$(hostname -f 2>/dev/null || hostname)
DATE=$(date '+%Y-%m-%d')
LOGFILE="/var/log/standards-monitor.log"
TMPFILE=$(mktemp)

trap 'rm -f "$TMPFILE"' EXIT

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') $1" >> "$LOGFILE"
}

log "Standards monitor started"

# --- Build report ---
{
    echo "NETWORK STANDARDS MONITOR - ${DATE}"
    echo "========================================"
    echo ""
    echo "Server: ${HOSTNAME}"
    echo "Repository: ${REPO_DIR}"
    echo "Generated: $(date '+%Y-%m-%d %H:%M:%S %Z')"
    echo ""

    # --- Section 1: Check document ages ---
    echo "1. DOCUMENT CURRENCY CHECK"
    echo "----------------------------------------"
    echo ""
    echo "Documents not updated in the last 90 days:"
    echo ""

    STALE_COUNT=0
    NINETY_DAYS_AGO=$(date -d '90 days ago' '+%Y-%m-%d' 2>/dev/null || date -v-90d '+%Y-%m-%d' 2>/dev/null || echo "")

    if [ -n "$NINETY_DAYS_AGO" ]; then
        while IFS= read -r -d '' mdfile; do
            last_updated=$(grep -m1 '^last_updated:' "$mdfile" 2>/dev/null | sed 's/last_updated: *//' | tr -d ' ')
            if [ -n "$last_updated" ]; then
                if [[ "$last_updated" < "$NINETY_DAYS_AGO" ]]; then
                    relpath="${mdfile#${REPO_DIR}/}"
                    echo "  [STALE] ${relpath} (last updated: ${last_updated})"
                    STALE_COUNT=$((STALE_COUNT + 1))
                fi
            fi
        done < <(find "${REPO_DIR}/docs" -name '*.md' -not -path '*/plans/*' -print0) || true
    fi

    if [ "$STALE_COUNT" -eq 0 ]; then
        echo "  All documents updated within 90 days."
    fi
    echo ""

    # --- Section 2: TLS version audit ---
    echo "2. TLS VERSION COMPLIANCE AUDIT"
    echo "----------------------------------------"
    echo ""
    echo "Checking for prohibited TLS 1.2 references:"
    echo ""

    TLS12_HITS=$(grep -rn 'TLS 1\.2' "${REPO_DIR}/docs/" 2>/dev/null | grep -v 'plans/' | grep -vi 'prohibited\|earlier\|forbidden\|not permitted\|no longer' || true)
    if [ -n "$TLS12_HITS" ]; then
        echo "  [WARNING] TLS 1.2 references found (policy requires TLS 1.3 minimum):"
        echo ""
        echo "$TLS12_HITS" | while IFS= read -r line; do
            echo "    ${line#${REPO_DIR}/}"
        done
        echo ""
    else
        echo "  All documents comply with TLS 1.3 minimum policy."
    fi
    echo ""

    # --- Section 3: Standards body update checks ---
    echo "3. STANDARDS BODY UPDATE CHECKS"
    echo "----------------------------------------"
    echo ""

    check_url() {
        local label="$1"
        local url="$2"
        local search_terms="$3"
        local status

        status=$(curl -sL -o /dev/null -w '%{http_code}' --max-time 15 "$url" 2>/dev/null || echo "000")

        if [ "$status" = "200" ]; then
            local content
            content=$(curl -sL --max-time 30 "$url" 2>/dev/null || echo "")
            if [ -n "$content" ]; then
                local matches=""
                for term in $search_terms; do
                    if echo "$content" | grep -qi "$term" 2>/dev/null; then
                        matches="${matches} ${term}"
                    fi
                done
                if [ -n "$matches" ]; then
                    echo "  [OK] ${label}: Reachable (keywords found:${matches})"
                else
                    echo "  [OK] ${label}: Reachable (no new keyword matches)"
                fi
            else
                echo "  [WARN] ${label}: Page returned empty content"
            fi
        else
            echo "  [ERROR] ${label}: HTTP ${status} (may need manual review)"
        fi
    }

    # IEEE 802.11 working group
    check_url "IEEE 802.11 (WiFi)" \
        "https://www.ieee802.org/11/" \
        "802.11be 802.11bn amendment draft"

    # Wi-Fi Alliance certifications
    check_url "Wi-Fi Alliance" \
        "https://www.wi-fi.org/discover-wi-fi" \
        "WPA3 WiFi7 certification 2026"

    # IETF TLS working group
    check_url "IETF TLS Working Group" \
        "https://datatracker.ietf.org/wg/tls/documents/" \
        "draft rfc tls"

    # IETF EAP/RADIUS
    check_url "IETF EMU (EAP Methods)" \
        "https://datatracker.ietf.org/wg/emu/documents/" \
        "eap-tls draft rfc"

    # NIST publications
    check_url "NIST Cybersecurity" \
        "https://csrc.nist.gov/publications" \
        "800-53 800-153 wireless"

    echo ""

    # --- Section 4: Repository standards references ---
    echo "4. REFERENCED STANDARDS INVENTORY"
    echo "----------------------------------------"
    echo ""
    echo "Standards referenced across documentation:"
    echo ""

    # Count references to key standards
    for std in "802.11be" "802.11ax" "802.11w" "802.1X" "802.3bt" "WPA3" "TLS 1.3" "NIST SP 800-53" "NIST SP 800-153" "RFC 8446" "NFPA 110" "NFPA 111" "IEEE 446" "IEEE 1100" "NEC 700" "Article 700" "PE-11"; do
        count=$(grep -r "$std" "${REPO_DIR}/docs/" 2>/dev/null | grep -v 'plans/' | wc -l)
        printf "  %-25s %3d references\n" "$std" "$count"
    done
    echo ""

    # --- Section 5: Procurement checklist audit ---
    echo "5. PROCUREMENT CHECKLIST AUDIT"
    echo "----------------------------------------"
    echo ""
    echo "Documents with procurement checklists:"
    echo ""

    while IFS= read -r -d '' mdfile; do
        relpath="${mdfile#${REPO_DIR}/}"
        if grep -qi 'procurement.*checklist\|pass.*fail.*checklist' "$mdfile" 2>/dev/null; then
            echo "  [HAS CHECKLIST] ${relpath}"
        else
            echo "  [MISSING]       ${relpath}"
        fi
    done < <(find "${REPO_DIR}/docs" -name '*.md' -not -path '*/plans/*' -print0 | sort -z) || true
    echo ""

    # --- Footer ---
    echo "========================================"
    echo "END OF REPORT"
    echo ""
    echo "Action required: Review any [WARNING], [STALE], or [ERROR] items above."
    echo "To update standards documentation: edit files in ${REPO_DIR}/docs/"
    echo ""
    echo "This report is generated daily by ${REPO_DIR}/scripts/standards-monitor.sh"

} > "$TMPFILE"

# --- Send email ---
MAIL_RESULT=0
{
    echo "From: ${SENDER}"
    echo "To: ${RECIPIENT}"
    echo "Subject: [Network Standards] Daily Monitor Report - ${DATE}"
    echo "Content-Type: text/plain; charset=utf-8"
    echo ""
    cat "$TMPFILE"
} | msmtp "${RECIPIENT}" 2>> "$LOGFILE" || MAIL_RESULT=$?

if [ "$MAIL_RESULT" -eq 0 ]; then
    log "Report sent successfully to ${RECIPIENT}"
else
    log "ERROR: Failed to send report to ${RECIPIENT} (exit code: ${MAIL_RESULT})"
fi

log "Standards monitor completed"
