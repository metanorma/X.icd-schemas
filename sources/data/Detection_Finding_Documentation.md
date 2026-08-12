# Detection Finding Event Schema Documentation

**Schema Version**: OCSF 1.6.0  
**Category**: Findings (Category UID: 2)  
**Class UID**: 2004  
**Last Updated**: November 2025

---

## Overview

**Purpose**: Security detection findings from SIEM systems, EDR solutions, network monitoring tools, malware scanners, and threat intelligence platforms. Captures alerts, threats, anomalies, and intelligence-driven detections.

**Schema Information**:
- **Schema ID**: https://schema.ocsf.io/schema/classes/detection_finding

---

## Event Attributes Reference

| Attribute | Type | Required | Profile | Description | Constraints/Links |
|-----------|------|----------|---------|-------------|-------------------|
| `action` | string | | security_control | The normalized caption of action_id | Auto-derived from action_id |
| `action_id` | integer | | security_control | The action taken by a control leading to an outcome | 0=Unknown, 1=Allowed, 2=Denied, 3=Observed, 4=Modified, 99=Other |
| `activity_id` | integer | ✓ | | The normalized identifier of the finding activity | 0=Unknown, 1=Create, 2=Update, 3=Close, 99=Other |
| `activity_name` | string | | | The finding activity name, as defined by the activity_id | Auto-derived from activity_id |
| `anomaly_analyses` | array[object] | | | Describes baseline information and detected deviations/anomalies | See [Anomaly Analysis Object](OCSF_Shared_Objects_Reference.md#anomaly-analysis-object) |
| `api` | object | | | Describes details about a typical API call | See [API Object](OCSF_Shared_Objects_Reference.md#api-object) |
| `assignee` | object | | incident | The details of the user assigned to an Incident | See [User Object](OCSF_Shared_Objects_Reference.md#user-object) |
| `assignee_group` | object | | incident | The details of the group assigned to an Incident | See [Group Object](OCSF_Shared_Objects_Reference.md#group-object) |
| `attacks` | array[object] | | security_control | MITRE ATT&CK® objects describing identified tactics, techniques & sub-techniques | See [Attack Object](OCSF_Shared_Objects_Reference.md#attack-object) |
| `authorizations` | array[object] | | security_control | Details about authorization, outcome, and associated policies | See [Authorization Object](OCSF_Shared_Objects_Reference.md#authorization-object) |
| `category_name` | string | | | The event category name: "Findings" | Constant: "Findings" |
| `category_uid` | integer | ✓ | | The category unique identifier of the event | Constant: 2 |
| `class_name` | string | | | The event class name: "Detection Finding" | Constant: "Detection Finding" |
| `class_uid` | integer | ✓ | | The unique identifier of a class | Constant: 2004 |
| `cloud` | object | | cloud | Describes details about the Cloud environment where the event was originally created | See [Cloud Object](OCSF_Shared_Objects_Reference.md#cloud-object) |
| `comment` | string | | incident | A user provided comment about the finding | |
| `confidence` | string | | | The confidence, normalized to confidence_id caption | Auto-derived from confidence_id |
| `confidence_id` | integer | | | The normalized confidence of the rule accuracy that created the finding | 0=Unknown, 1=Low, 2=Medium, 3=High, 99=Other |
| `confidence_score` | integer | | | The confidence score as reported by the event source | |
| `count` | integer | | | The number of times events in the same logical group occurred | |
| `device` | object | | | Describes the affected device/host | See [Device Object](OCSF_Shared_Objects_Reference.md#device-object) |
| `disposition` | string | | security_control | The disposition name, normalized to disposition_id caption | Auto-derived from disposition_id |
| `disposition_id` | integer | | security_control | Describes the outcome or action taken by a security control | 0=Unknown, 1=Allowed, 2=Blocked, 3=Quarantined, etc. |
| `duration` | integer | | | The event duration from start_time to end_time in milliseconds | Milliseconds |
| `end_time` | timestamp | | | The time of the most recent event included in the finding | Unix timestamp |
| `end_time_dt` | datetime | | datetime | The time of the most recent event included in the finding | ISO 8601 format |
| `enrichments` | array[object] | | | Additional information from external data sources associated with the event | See [Enrichment Object](OCSF_Shared_Objects_Reference.md#enrichment-object) |
| `evidences` | array[object] | | | Describes various evidence artifacts associated to activities that triggered detection | See [Evidences Object](OCSF_Shared_Objects_Reference.md#evidences-object) |
| `finding_info` | object | ✓ | | Describes the supporting information about a generated finding | See [Finding Info Object](OCSF_Shared_Objects_Reference.md#finding-info-object) |
| `firewall_rule` | object | | security_control | The firewall rule that pertains to the control that triggered the event | See [Firewall Rule Object](OCSF_Shared_Objects_Reference.md#firewall-rule-object) |
| `impact` | string | | | The impact, normalized to impact_id caption | Auto-derived from impact_id |
| `impact_id` | integer | | | The normalized impact of the incident or finding | 0=Unknown, 1=Low, 2=Medium, 3=High, 4=Critical, 99=Other |
| `impact_score` | integer | | | The impact as an integer value of the finding | Range: 0-100 |
| `is_alert` | boolean | | | Indicates that the event is considered to be an alertable signal | |
| `is_suspected_breach` | boolean | | incident | A determination based on analytics as to whether a potential breach was found | |
| `malware` | array[object] | | | Describes malware reported in a Detection Finding | See [Malware Object](OCSF_Shared_Objects_Reference.md#malware-object) |
| `malware_scan_info` | object | | | Describes details about malware scan job that triggered this Detection Finding | See [Malware Scan Info Object](OCSF_Shared_Objects_Reference.md#malware-scan-info-object) |
| `message` | string | | | The description of the event/finding, as defined by the source | |
| `metadata` | object | ✓ | | The metadata associated with the event or a finding | See [Metadata Object](OCSF_Shared_Objects_Reference.md#metadata-object) |
| `observables` | array[object] | | | The observables associated with the event or a finding | See [Observable Object](OCSF_Shared_Objects_Reference.md#observable-object) |
| `osint` | array[object] | | osint | OSINT details related to indicators such as geolocation, registrar info, analyst commentary | See [OSINT Object](OCSF_Shared_Objects_Reference.md#osint-object) |
| `policy` | object | | security_control | The policy that pertains to the control that triggered the event | See [Policy Object](OCSF_Shared_Objects_Reference.md#policy-object) |
| `priority` | string | | | The priority, normalized to priority_id caption | Auto-derived from priority_id |
| `priority_id` | integer | | | The normalized priority identifying relative importance | 0=Unknown, 1=Low, 2=Medium, 3=High, 4=Critical, 99=Other |
| `raw_data` | string | | | The raw event/finding data as received from the source | |
| `raw_data_hash` | object | | | The hash describing the content of the raw_data field | See [Fingerprint Object](OCSF_Shared_Objects_Reference.md#fingerprint-object) |
| `raw_data_size` | integer | | | The size of the raw data transformed into OCSF event, in bytes | |
| `remediation` | object | | | Describes the recommended remediation steps to address identified issues | See [Remediation Object](OCSF_Shared_Objects_Reference.md#remediation-object) |
| `resources` | array[object] | | | Describes details about resources that were the target of the activity | See [Resource Details Object](OCSF_Shared_Objects_Reference.md#resource-details-object) |
| `risk_details` | string | | | Describes the risk associated with the finding | |
| `risk_level` | string | | | The risk level, normalized to risk_level_id caption | Auto-derived from risk_level_id |
| `risk_level_id` | integer | | | The normalized risk level id | 0=Info, 1=Low, 2=Medium, 3=High, 4=Critical, 99=Other |
| `risk_score` | integer | | | The risk score as reported by the event source | |
| `severity` | string | | | The event/finding severity, normalized to severity_id caption | Auto-derived from severity_id |
| `severity_id` | integer | ✓ | | The normalized identifier of the event/finding severity | 0=Unknown, 1=Informational, 2=Low, 3=Medium, 4=High, 5=Critical, 6=Fatal, 99=Other |
| `src_url` | string | | | A URL link used to access the original incident | URL format |
| `start_time` | timestamp | | | The time of the least recent event included in the finding | Unix timestamp |
| `start_time_dt` | datetime | | datetime | The time of the least recent event included in the finding | ISO 8601 format |
| `status` | string | | | The normalized status of the Finding set by the consumer | Auto-derived from status_id |
| `status_code` | string | | | The event status code, as reported by the event source | |
| `status_detail` | string | | | Additional information about the event/finding outcome | |
| `status_id` | integer | | | The normalized status identifier of the Finding | 0=Unknown, 1=New, 2=In Progress, 3=Suppressed, 4=Resolved, 5=Archived, 6=Deleted, 99=Other |
| `ticket` | object | | incident | The linked ticket in the ticketing system (deprecated) | Use `tickets` instead |
| `tickets` | array[object] | | incident | The associated ticket(s) in the ticketing system | See [Ticket Object](OCSF_Shared_Objects_Reference.md#ticket-object) |
| `time` | timestamp | ✓ | | The normalized event occurrence time or the finding creation time | Unix timestamp |
| `time_dt` | datetime | | datetime | The normalized event occurrence time or the finding creation time | ISO 8601 format |
| `timezone_offset` | integer | | | Minutes ahead or behind UTC for reported event time | Range: -1,080 to +1,080 |
| `type_name` | string | | | The event/finding type name, as defined by the type_uid | Auto-derived from type_uid |
| `type_uid` | integer | ✓ | | The event/finding type ID: class_uid * 100 + activity_id | 200400, 200401, 200402, 200403, 200499 |
| `unmapped` | object | | | Attributes not mapped to the event schema, specific to the event source | See [Object](OCSF_Shared_Objects_Reference.md#object) |
| `vendor_attributes` | object | | | Values of attributes populated by the Vendor/Finding Provider | See [Vendor Attributes Object](OCSF_Shared_Objects_Reference.md#vendor-attributes-object) |
| `verdict` | string | | incident | The verdict assigned to an Incident finding | Auto-derived from verdict_id |
| `verdict_id` | integer | | incident | The normalized verdict of an Incident | 0=Unknown, 1=False Positive, 2=True Positive, etc. |
| `vulnerabilities` | array[object] | | | Describes vulnerabilities reported in a Detection Finding | See [Vulnerability Object](OCSF_Shared_Objects_Reference.md#vulnerability-object) |

---

## References

- [OCSF Schema Repository](https://github.com/ocsf/ocsf-schema)
- [OCSF Shared Objects Reference](OCSF_Shared_Objects_Reference.md)
