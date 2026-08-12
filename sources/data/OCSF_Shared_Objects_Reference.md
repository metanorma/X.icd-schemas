# OCSF Shared Objects Reference

**Version**: OCSF 1.6.0  
**Last Updated**: November 2025

This reference contains comprehensive documentation for all shared objects used across OCSF event classes. These objects provide the common building blocks that enable consistency and interoperability across all OCSF schemas.

---

## Shared Objects Reference

### Account Object
**Purpose**: Describes account details across different systems and cloud providers.

**Conditional Requirements**: Must have at least one of `uid` or `name`

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `uid` | string | ○ | Unique identifier | Must have uid or name |
| `name` | string | ○ | Account name | Must have uid or name |
| `type` | string | | Account type name | Auto-derived from type_id |
| `type_id` | integer | | Account type identifier | LDAP, Windows, Cloud IAM, etc. |
| `labels` | array[string] | | Associated labels | |
| `tags` | object | | Associated metadata tags | |

### Actor Object
**Purpose**: Describes the entity that initiated an activity.

**Conditional Requirements**: Must have at least one of `invoked_by`, `app_uid`, `app_name`, `user`, `session`, or `process`

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `user` | object | ○ | User that initiated the activity | See [User Object](#user-object) |
| `app_name` | string | ○ | Client application name | Must have app_name or app_uid |
| `app_uid` | string | ○ | Client application identifier | Must have app_name or app_uid |
| `process` | object | ○ | Process that initiated the activity | See [Process Object](#process-object) |
| `session` | object | ○ | User session context | See [Session Object](#session-object) |
| `authorizations` | array[object] | | Authorization details and policies | See [Authorization Object](#authorization-object) |
| `idp` | object | | Identity Provider information | See Identity Provider Object |
| `invoked_by` | string | ○ | Entity that invoked the activity | One of required alternatives |

### Advisory Object
**Purpose**: Security advisory information for patches and vulnerabilities.

**Required Properties**: `uid`

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `uid` | string | ✓ | Advisory identifier | e.g., GHSA-5mrr-rgp6-x4gr |
| `title` | string | | Advisory title | |
| `desc` | string | | Advisory description | |
| `classification` | string | | Vendor classification | |
| `bulletin` | string | | Advisory bulletin identifier | |
| `created_time` | timestamp | | Advisory creation time | Unix timestamp |
| `modified_time` | timestamp | | Advisory modification time | Unix timestamp |
| `install_state` | string | | Installation state name | Auto-derived from install_state_id |
| `install_state_id` | integer | | Installation status identifier | |
| `related_cves` | array[object] | | Related CVE vulnerabilities | See [CVE Object](#cve-object) |
| `related_cwes` | array[object] | | Related CWE weaknesses | See [CWE Object](#cwe-object) |
| `os` | object | | Applicable operating system | See [OS Object](#os-object) |
| `product` | object | | Applicable product | See [Product Object](#product-object) |
| `size` | integer | | Advisory size in bytes | |

### Affected Code Object
**Purpose**: Details about code blocks identified as vulnerable.

**Required Properties**: `file`

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `file` | object | ✓ | File containing the affected code | See [File Object](#file-object) |
| `start_line` | integer | | Starting line number of vulnerable code | |
| `end_line` | integer | | Ending line number of vulnerable code | |
| `start_column` | integer | | Starting column position | |
| `end_column` | integer | | Ending column position | |
| `owner` | object | | User that owns the affected file | See [User Object](#user-object) |
| `rule` | object | | Specific rule that triggered the finding | See Rule Object |
| `remediation` | object | | Recommended remediation steps | See Remediation Object |

### Affected Package Object  
**Purpose**: Software packages identified as affected by vulnerabilities.

**Required Properties**: `name`, `version`

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `name` | string | ✓ | Package name | |
| `version` | string | ✓ | Package version | |
| `uid` | string | | Unique package identifier | |
| `architecture` | string | | Target architecture | x86_64, arm64, etc. |
| `epoch` | integer | | Package epoch | |
| `release` | string | | Package release | |
| `package_manager` | string | | Manager used | npm, yum, dpkg, etc. |
| `vendor_name` | string | | Publisher name | |
| `cpe_name` | string | | Common Platform Enumeration identifier | |
| `purl` | string | | Package URL for universal identification | |
| `fixed_in_version` | string | | Version where vulnerability was patched | |
| `hash` | object | | Cryptographic hash for identification | See [Fingerprint Object](#fingerprint-object) |
| `remediation` | object | | Remediation guidance | See Remediation Object |

### Agent Object
**Purpose**: Information about agents or sensors.

**Conditional Requirements**: Must have at least one of `uid` or `name`

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `uid` | string | ○ | Agent unique identifier | Must have uid or name |
| `uid_alt` | string | | Alternative agent identifier | |
| `name` | string | ○ | Agent name | Must have uid or name |
| `type` | string | | Agent type name | Auto-derived from type_id |
| `type_id` | integer | | Agent type identifier | EDR, DLP, Backup & Recovery, etc. |
| `version` | string | | Semantic version | e.g., "7.101.50.0" |
| `vendor_name` | string | | Creator company | e.g., "Crowdstrike" |
| `policies` | array[object] | | Applied or enforced policies | See Policy Object |

### Analytic Object
**Purpose**: Information about analytics that generated findings.

**Conditional Requirements**: Must have at least one of `uid` or `name`

**Required Properties**: `type_id`

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `uid` | string | ○ | Unique identifier of the analytic | Must have uid or name |
| `name` | string | ○ | Analytic name | Must have uid or name |
| `desc` | string | | Description of the analytic | |
| `type` | string | | Analytic type name | Auto-derived from type_id |
| `type_id` | integer | ✓ | Analytic type identifier | Rule, Behavioral, Statistical, ML/DL, etc. |
| `algorithm` | string | | Algorithm used by the analytic | |
| `category` | string | | Analytic category | |
| `state` | string | | Analytic state name | Auto-derived from state_id |
| `state_id` | integer | | Analytic state identifier | Active, Suppressed, Experimental |
| `version` | string | | Analytic version | e.g., "1.1" |

### Attack Object
**Purpose**: MITRE ATT&CK® and ATLAS™ technique information.

**Conditional Requirements**: Must have at least one of `tactic`, `sub_technique`, or `technique`

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `tactic` | object | ○ | High-level adversary goal | See Tactic Object |
| `technique` | object | ○ | Method to achieve the tactic | See Technique Object |
| `sub_technique` | object | ○ | Specific implementation details | See Sub-technique Object |
| `mitigation` | object | | Associated countermeasures | See Mitigation Object |
| `version` | string | | ATT&CK Matrix version | |

### Authentication Factor Object
**Purpose**: Multi-factor authentication method details.

**Required Properties**: `factor_type_id`

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `factor_type` | string | | Factor type name | Auto-derived from factor_type_id |
| `factor_type_id` | integer | ✓ | Factor type identifier | SMS, Push Notification, Hardware Token, etc. |
| `device` | object | | Device used for authentication | See Device Object |
| `email_addr` | string | | Email address for email-based factors | |
| `phone_number` | string | | Phone number for telephony-based factors | |
| `provider` | string | | Authentication factor provider | |
| `is_hotp` | boolean | | HMAC-based OTP indicator | |
| `is_totp` | boolean | | Time-based OTP indicator | |

### Authorization Object
**Purpose**: Authorization result and policy information.

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `decision` | string | | Authorization outcome | allowed, denied |
| `policy` | object | | Identity/Access management policies | |

### Certificate Object  
**Purpose**: Digital certificate information.

**Conditional Requirements**: Must have at least one of `uid_alt` or `uid`

**Required Properties**: `issuer`, `serial_number`

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `uid` | string | ○ | Certificate unique identifier | Must have uid or uid_alt |
| `uid_alt` | string | ○ | Alternative certificate identifier | Must have uid or uid_alt |
| `issuer` | string | ✓ | Certificate issuer distinguished name | |
| `subject` | string | | Certificate subject distinguished name | |
| `serial_number` | string | ✓ | Certificate serial number | |
| `algorithm` | string | | Certificate algorithm | e.g., RSA-1024 |
| `fingerprints` | array[object] | | Certificate fingerprint list | See Fingerprint Object |
| `created_time` | timestamp | | Certificate creation time | Unix timestamp |
| `expiration_time` | timestamp | | Certificate expiration time | Unix timestamp |
| `sans` | array[string] | | Subject Alternative Names | |
| `key_usages` | array[string] | | Key usage definitions | |

### Cloud Object
**Purpose**: Cloud environment details across providers.

**Required Properties**: `provider`

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `provider` | string | ✓ | Cloud services provider | Major cloud platforms |
| `account` | object | | Account details | See Account Object |
| `region` | string | | Cloud region name | |
| `zone` | string | | Availability zone | |
| `cloud_partition` | string | | Cloud partition | e.g., commercial, government, regional |
| `org` | object | | Organization information | See Organization Object |

### Container Object
**Purpose**: Container instance information.

**Conditional Requirements**: Must have at least one of `uid` or `name`

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `uid` | string | ○ | Full container unique identifier | Must have uid or name |
| `name` | string | ○ | Container name | Must have uid or name |
| `hash` | string | | Container image commit hash or SHA256 | |
| `image` | object | | Container image template | See Image Object |
| `orchestrator` | string | | Managing system | ECS, EKS, K8s, OpenShift |
| `runtime` | string | | Backend runtime | containerd, cri-o |
| `network_driver` | string | | Network driver | bridge, overlay, host |
| `pod_uuid` | string | | Pod identifier for orchestrated containers | |
| `labels` | array[string] | | Associated labels | |
| `tags` | object | | Associated metadata tags | |

### CVE Object
**Purpose**: Common Vulnerabilities and Exposures details.

**Required Properties**: `uid`

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `uid` | string | ✓ | CVE identifier | e.g., CVE-2021-12345 |
| `title` | string | | CVE title | |
| `desc` | string | | CVE description | |
| `type` | string | | Vulnerability type | DoS, Code Execution, etc. |
| `cvss` | object | | CVSS scoring information | See CVSS Object |
| `epss` | object | | Exploit Prediction Scoring System data | |
| `created_time` | timestamp | | CVE creation time | Unix timestamp |
| `modified_time` | timestamp | | CVE modification time | Unix timestamp |
| `related_cwes` | array[object] | | Associated CWE details | See CWE Object |
| `references` | array[string] | | Additional information URLs | |
| `product` | object | | Product where vulnerability was discovered | See Product Object |

### CVSS Object
**Purpose**: Common Vulnerability Scoring System scores.

**Required Properties**: `base_score`, `version`

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `base_score` | float | ✓ | CVSS base score | e.g., 9.1 |
| `overall_score` | float | | Overall score with all metrics | |
| `severity` | string | | Qualitative severity | Low, Medium, High, Critical |
| `version` | string | ✓ | CVSS version | e.g., "3.1" |
| `vector_string` | string | | CVSS vector representation | |
| `depth` | string | | CVSS depth | Base, Environmental, Temporal |
| `metrics` | array[object] | | CVE impact metrics | |
| `vendor_name` | string | | Score provider | NVD, REDHAT, etc. |

### CWE Object
**Purpose**: Common Weakness Enumeration details.

**Required Properties**: `uid`

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `uid` | string | ✓ | CWE identifier | e.g., CWE-123 |
| `caption` | string | | CWE caption/title | |
| `src_url` | string | | CWE specification URL | |

### Device Object
**Purpose**: Represents endpoints, hosts, and computing devices.

**Conditional Requirements**: Must have at least one of `hostname`, `interface_uid`, `instance_uid`, `name`, `interface_name`, `uid_alt`, `ip`, or `uid`

**Required Properties**: `type_id`

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `uid` | string | ○ | Device unique identifier | One of required alternatives |
| `uid_alt` | string | ○ | Alternative device identifier | One of required alternatives |
| `name` | string | ○ | Device name | One of required alternatives |
| `hostname` | string | ○ | Device hostname | One of required alternatives |
| `ip` | string | ○ | Device IP address | One of required alternatives |
| `mac` | string | | MAC address | |
| `type` | string | | Device type name | Auto-derived from type_id |
| `type_id` | integer | ✓ | Device type identifier | Server, Desktop, Laptop, Mobile, Virtual, etc. |
| `os` | object | | Operating system details | See OS Object |
| `hw_info` | object | | Hardware information | See Device Hardware Info Object |
| `network_interfaces` | array[object] | | Associated network interfaces | See Network Interface Object |
| `groups` | array[object] | | Device groups | See Group Object |
| `owner` | object | | Device owner | See User Object |
| `agent_list` | array[object] | | Associated agents/sensors | See Agent Object |
| `risk_level` | string | | Risk level name | Auto-derived from risk_level_id |
| `risk_score` | integer | | Risk assessment score | |
| `is_managed` | boolean | | Management status indicator | |
| `is_compliant` | boolean | | Compliance status indicator | |
| `is_trusted` | boolean | | Trust status indicator | |
| `interface_uid` | string | ○ | Network interface identifier | One of required alternatives |
| `instance_uid` | string | ○ | Instance identifier | One of required alternatives |
| `interface_name` | string | ○ | Network interface name | One of required alternatives |

### Device Hardware Info Object
**Purpose**: Detailed hardware specifications.

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `bios_date` | string | | BIOS release date | |
| `bios_manufacturer` | string | | BIOS manufacturer | |
| `bios_ver` | string | | BIOS version | |
| `cpu_architecture` | string | | CPU architecture | x86, x64, ARM, etc. |
| `cpu_bits` | integer | | CPU architecture bits | 32, 64 |
| `cpu_cores` | integer | | Number of CPU cores | |
| `cpu_count` | integer | | Number of CPUs | |
| `cpu_speed` | integer | | CPU speed in MHz | |
| `cpu_type` | string | | CPU type | |
| `ram_size` | integer | | Total installed RAM in MB | |
| `chassis` | string | | System enclosure type | |
| `serial_number` | string | | Hardware serial number | |
| `uuid` | string | | Hardware UUID | |
| `vendor_name` | string | | Device manufacturer | |
| `desktop_display` | object | | Display information | |
| `keyboard_info` | object | | Keyboard information | |

### DNS Answer Object
**Purpose**: DNS response information.

**Required Properties**: `rdata`

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `rdata` | string | ✓ | DNS resource record data | |
| `type` | string | | Resource record type | A, AAAA, CNAME, etc. |
| `class` | string | | DNS data class | |
| `ttl` | integer | | Time to live value | |
| `flags` | array[string] | | DNS header flags | |
| `flag_ids` | array[integer] | | DNS header flag identifiers | |
| `packet_uid` | string | | DNS packet identifier | |

### DNS Query Object
**Purpose**: DNS query information.

**Required Properties**: `hostname`

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `hostname` | string | ✓ | Queried hostname/domain | |
| `type` | string | | Resource record type being queried | |
| `class` | string | | Resource record class | |
| `opcode` | string | | Query message type name | Auto-derived from opcode_id |
| `opcode_id` | integer | | Query message type identifier | |
| `packet_uid` | string | | DNS packet identifier | |

### Email Object
**Purpose**: Email message structure and headers.

**Conditional Requirements**: Must have at least one of `from` or `to`

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `from` | string | ○ | Sender email address | Must have from or to |
| `to` | array[string] | ○ | Recipient email addresses | Must have from or to |
| `cc` | array[string] | | Carbon copy recipients | |
| `subject` | string | | Email subject line | |
| `message_uid` | string | | Message identifier | |
| `size` | integer | | Email size in bytes | |
| `files` | array[object] | | Embedded or attached files | See File Object |
| `urls` | array[object] | | Embedded URLs | See URL Object |
| `is_read` | boolean | | Read status indicator | |
| `x_originating_ip` | string | | Originating IP address | |

### Evidences Object
**Purpose**: Evidence artifacts associated with security detections.

**Conditional Requirements**: Must have at least one evidence type (device, file, process, user, etc.)

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `actor` | object | ○ | User/role/process source of activity | See Actor Object |
| `api` | object | ○ | API call details | |
| `device` | object | ○ | Addressable device/host | See Device Object |
| `file` | object | ○ | File associated with activity | See File Object |
| `process` | object | ○ | Process associated with activity | See Process Object |
| `user` | object | ○ | User associated with activity | See User Object |
| `email` | object | ○ | Email object details | See Email Object |
| `url` | object | ○ | URL object details | See URL Object |
| `connection_info` | object | ○ | Network connection details | See Network Connection Info Object |
| `verdict` | string | | Evidence verdict name | Auto-derived from verdict_id |
| `verdict_id` | integer | | Evidence verdict identifier | |

### File Object
**Purpose**: File system objects with metadata and security attributes.

**Required Properties**: `name`, `type_id`

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `name` | string | ✓ | File name | |
| `path` | string | | File path | |
| `uid` | string | | Unique file identifier | |
| `type` | string | | File type name | Auto-derived from type_id |
| `type_id` | integer | ✓ | File type identifier | Regular File, Folder, Executable, etc. |
| `size` | integer | | File size in bytes | |
| `hashes` | array[object] | | Cryptographic hashes | See Fingerprint Object |
| `signature` | object | | Digital signature | |
| `mime_type` | string | | MIME type | |
| `created_time` | timestamp | | File creation time | Unix timestamp |
| `modified_time` | timestamp | | File modification time | Unix timestamp |
| `accessed_time` | timestamp | | File access time | Unix timestamp |
| `owner` | object | | File owner | See User Object |
| `creator` | object | | File creator | See User Object |
| `modifier` | object | | File modifier | See User Object |
| `is_system` | boolean | | System file indicator | |
| `is_encrypted` | boolean | | Encryption status indicator | |
| `confidentiality` | string | | Classification level name | Auto-derived from confidentiality_id |
| `confidentiality_id` | integer | | Classification level identifier | |

### Finding Info Object
**Purpose**: Core information about security findings.

**Required Properties**: `uid`

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `uid` | string | ✓ | Finding unique identifier | |
| `uid_alt` | string | | Alternative finding identifier | |
| `title` | string | | Finding title | |
| `desc` | string | | Finding description | |
| `created_time` | timestamp | | Finding creation time | Unix timestamp |
| `modified_time` | timestamp | | Finding modification time | Unix timestamp |
| `first_seen_time` | timestamp | | First observation time | Unix timestamp |
| `last_seen_time` | timestamp | | Last observation time | Unix timestamp |
| `analytic` | object | | Analytic technique used | See Analytic Object |
| `attacks` | array[object] | | MITRE ATT&CK details | See Attack Object |
| `data_sources` | array[string] | | Data sources utilized | |
| `related_events` | array[string] | | Related events/findings | |
| `product` | object | | Product that reported the finding | See Product Object |

### Fingerprint Object
**Purpose**: Digital fingerprint/hash information.

**Required Properties**: `algorithm_id`, `value`

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `algorithm` | string | | Hash algorithm name | Auto-derived from algorithm_id |
| `algorithm_id` | integer | ✓ | Hash algorithm identifier | MD5, SHA-1, SHA-256, etc. |
| `value` | string | ✓ | Digital fingerprint value | hex format |

### Group Object
**Purpose**: Administrative groups and organizational units.

**Conditional Requirements**: Must have at least one of `uid` or `name`

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `uid` | string | ○ | Unique group identifier | Must have uid or name |
| `name` | string | ○ | Group name | Must have uid or name |
| `desc` | string | | Group description | |
| `domain` | string | | Domain where group is defined | |
| `privileges` | array[string] | | Group privileges | |
| `type` | string | | Group or account type | |

### Image Object
**Purpose**: Container/VM template image information.

**Conditional Requirements**: Must have at least one of `uid_alt`, `uid`, or `name`

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `uid` | string | ○ | Image unique identifier | Must have uid, uid_alt, or name |
| `uid_alt` | string | ○ | Alternative image identifier | Must have uid, uid_alt, or name |
| `name` | string | ○ | Image name | Must have uid, uid_alt, or name |
| `path` | string | | Full path to image file | |
| `hash` | string | | Unique image hash | |
| `architecture` | string | | CPU architecture | x86_64, arm64 |
| `platform` | string | | OS platform | e.g., AMAZON_LINUX_2 |
| `registry_uid` | string | | Registry identifier | |
| `repository_name` | string | | Repository name | |
| `created_time` | timestamp | | Image creation time | Unix timestamp |
| `modified_time` | timestamp | | Image modification time | Unix timestamp |
| `labels` | array[string] | | Associated labels | |
| `tags` | object | | Associated metadata tags | |

### Malware Object
**Purpose**: Malware classification and details.

**Conditional Requirements**: Must have at least one of `uid` or `name`

**Required Properties**: `classification_ids`

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `uid` | string | ○ | Unique malware identifier | Must have uid or name |
| `name` | string | ○ | Malware name as reported | Must have uid or name |
| `classifications` | array[string] | | Malware type names | Auto-derived from classification_ids |
| `classification_ids` | array[integer] | ✓ | Malware type identifiers | Adware, Backdoor, Ransomware, etc. |
| `severity` | string | | Malware severity name | Auto-derived from severity_id |
| `severity_id` | integer | | Malware severity identifier | |
| `files` | array[object] | | Files identified as infected | See [File Object](#file-object) |
| `num_infected` | integer | | Number of infected files | |
| `cves` | array[object] | | Associated vulnerabilities | See [CVE Object](#cve-object) |
| `provider` | string | | Detection provider | |

### Metadata Object
**Purpose**: Event processing and schema information.

**Required Properties**: `product`, `version`

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `version` | string | ✓ | OCSF schema version | always "1.6.0" |
| `product` | object | ✓ | Product that reported the event | See [Product Object](#product-object) |
| `uid` | string | | Event unique identifier | |
| `correlation_uid` | string | | Event correlation identifier | |
| `event_code` | string | | Product event identifier | |
| `labels` | array[string] | | Event labels | |
| `tags` | object | | Event tags | |
| `logged_time` | timestamp | | When logging system collected the event | Unix timestamp |
| `processed_time` | timestamp | | Event processing time | Unix timestamp |
| `profiles` | array[string] | | Schema profiles used | |
| `extensions` | array[string] | | Schema extensions used | |

### Network Connection Info Object
**Purpose**: Network connection characteristics and metadata.

**Required Properties**: `direction_id`

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `direction` | string | | Connection direction name | Auto-derived from direction_id |
| `direction_id` | integer | ✓ | Connection direction identifier | Inbound, Outbound, Lateral |
| `boundary` | string | | Connection boundary name | Auto-derived from boundary_id |
| `boundary_id` | integer | | Connection boundary identifier | Internal, External, VPC |
| `protocol_name` | string | | IP protocol name | |
| `protocol_num` | integer | | IP protocol number | |
| `protocol_ver` | string | | IP version name | Auto-derived from protocol_ver_id |
| `protocol_ver_id` | integer | | IP version identifier | IPv4, IPv6 |
| `uid` | string | | Connection unique identifier | |
| `community_id` | string | | Community ID of connection | |
| `tcp_flags` | integer | | TCP header flags | |
| `session` | object | | Authenticated session | See [Session Object](#session-object) |

### Network Endpoint Object
**Purpose**: Network communication endpoints.

**Conditional Requirements**: Must have at least one of `svc_name`, `interface_uid`, `interface_name`, `instance_uid`, `uid`, `hostname`, `ip`, `domain`, or `name`

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `ip` | string | ○ | IP address | One of required alternatives |
| `port` | integer | | Port number | |
| `hostname` | string | ○ | Hostname | One of required alternatives |
| `domain` | string | ○ | Domain name | One of required alternatives |
| `name` | string | ○ | Endpoint name | One of required alternatives |
| `uid` | string | ○ | Endpoint unique identifier | One of required alternatives |
| `instance_uid` | string | ○ | Instance identifier | One of required alternatives |
| `mac` | string | | MAC address | |
| `location` | object | | Geographic location | |
| `autonomous_system` | object | | AS information | |
| `isp` | string | | Internet service provider | |
| `isp_org` | string | | ISP organization | |
| `type` | string | | Endpoint type name | Auto-derived from type_id |
| `type_id` | integer | | Endpoint type identifier | |
| `svc_name` | string | ○ | Service name | One of required alternatives |
| `interface_uid` | string | ○ | Interface identifier | One of required alternatives |
| `interface_name` | string | ○ | Interface name | One of required alternatives |

### Network Interface Object
**Purpose**: Physical or virtual network interface details.

**Conditional Requirements**: Must have at least one of `uid_alt`, `mac`, `uid`, `hostname`, `ip`, or `name`

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `uid` | string | ○ | Interface unique identifier | One of required alternatives |
| `uid_alt` | string | ○ | Alternative interface identifier | One of required alternatives |
| `name` | string | ○ | Interface name | One of required alternatives |
| `ip` | string | ○ | IP address | One of required alternatives |
| `mac` | string | ○ | MAC address | One of required alternatives |
| `hostname` | string | ○ | Associated hostname | One of required alternatives |
| `type` | string | | Interface type name | Auto-derived from type_id |
| `type_id` | integer | | Interface type identifier | Wired, Wireless, Mobile, Tunnel |
| `subnet_prefix` | integer | | Network prefix length | |
| `open_ports` | array[integer] | | List of open ports | |
| `security_groups` | array[object] | | Associated security groups | |

### Observable Object
**Purpose**: Observable attributes and indicators.

**Required Properties**: `type_id`

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `name` | string | | Observable attribute name | pointer to event data |
| `type` | string | | Observable type name | Auto-derived from type_id |
| `type_id` | integer | ✓ | Observable type identifier | IP Address, Hash, User Name, etc. |
| `value` | string | | Associated value | |
| `reputation` | object | | Reputation information | See [Reputation Object](#reputation-object) |

### Organization Object
**Purpose**: Organizational structure information.

**Conditional Requirements**: Must have at least one of `uid` or `name`

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `uid` | string | ○ | Organization unique identifier | Must have uid or name |
| `name` | string | ○ | Organization name | Must have uid or name |
| `ou_uid` | string | | Organizational unit identifier | |
| `ou_name` | string | | Organizational unit name | |

### OS Object
**Purpose**: Operating system information.

**Required Properties**: `name`, `type_id`

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `name` | string | ✓ | Operating system name | |
| `type` | string | | OS type name | Auto-derived from type_id |
| `type_id` | integer | ✓ | OS type identifier | Windows, Linux, macOS, etc. |
| `version` | string | | OS version | |
| `build` | string | | OS build number | |
| `edition` | string | | OS edition | Professional, etc. |
| `lang` | string | | Language code | |
| `country` | string | | Country code | |
| `cpe_name` | string | | Common Platform Enumeration name | |

### Process Object
**Purpose**: Running processes and applications.

**Conditional Requirements**: Must have at least one of `cpid`, `uid`, or `pid`

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `uid` | string | ○ | Process unique identifier | Must have cpid, uid, or pid |
| `pid` | integer | ○ | Process identifier | Must have cpid, uid, or pid |
| `cpid` | string | ○ | Common process identifier | UUID format |
| `name` | string | | Process name | |
| `cmd_line` | string | | Full command line | |
| `file` | object | | Executable file object | See [File Object](#file-object) |
| `parent_process` | object | | Parent process information | See [Process Object](#process-object) |
| `ancestry` | array[object] | | Extended process parentage | See [Process Object](#process-object) |
| `user` | object | | User running the process | See [User Object](#user-object) |
| `session` | object | | User session context | See [Session Object](#session-object) |
| `created_time` | timestamp | | Process creation time | Unix timestamp |
| `terminated_time` | timestamp | | Process termination time | Unix timestamp |

### Product Object
**Purpose**: Product information for event sources.

**Conditional Requirements**: Must have at least one of `uid` or `name`

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `uid` | string | ○ | Product unique identifier | Must have uid or name |
| `name` | string | ○ | Product name | Must have uid or name |
| `version` | string | | Product version | |
| `vendor_name` | string | | Vendor name | |
| `feature` | string | | Specific product feature | |
| `lang` | string | | Product language | |
| `path` | string | | Installation path | |

### Reputation Object
**Purpose**: Reputation scoring information.

**Required Properties**: `base_score`, `score_id`

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `base_score` | integer | ✓ | Reputation score value | |
| `score` | string | | Normalized reputation score name | Auto-derived from score_id |
| `score_id` | integer | ✓ | Normalized reputation score identifier | |
| `provider` | string | | Reputation provider | |

### Resource Details Object
**Purpose**: Cloud resource information and metadata.

**Conditional Requirements**: Must have at least one of `name`, `uid_alt`, or `uid`

**Required Properties**: `type`

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `uid` | string | ○ | Resource unique identifier | Must have name, uid_alt, or uid |
| `uid_alt` | string | ○ | Alternative resource identifier | Must have name, uid_alt, or uid |
| `name` | string | ○ | Resource name | Must have name, uid_alt, or uid |
| `type` | string | ✓ | Resource type | e.g., compute instance, storage bucket |
| `region` | string | | Geographic region | |
| `zone` | string | | Geographic placement zone | |
| `created_time` | timestamp | | Resource creation time | Unix timestamp |
| `modified_time` | timestamp | | Resource modification time | Unix timestamp |
| `owner` | object | | Resource owner | See [User Object](#user-object) |
| `tags` | object | | Resource tags | |
| `criticality` | string | | Resource criticality | |
| `group` | object | | Related resource group | See [Group Object](#group-object) |

### Session Object
**Purpose**: User sessions and authentication contexts.

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `uid` | string | | Session unique identifier | |
| `uid_alt` | string | | Alternative session identifier | |
| `uuid` | string | | Session UUID | |
| `created_time` | timestamp | | Session creation time | Unix timestamp |
| `expiration_time` | timestamp | | Session expiration time | Unix timestamp |
| `is_mfa` | boolean | | Multi-factor authentication indicator | |
| `is_remote` | boolean | | Remote session indicator | |
| `is_vpn` | boolean | | VPN session indicator | |
| `credential_uid` | string | | Associated credential identifier | |
| `terminal` | string | | Associated terminal | tty/pts |
| `issuer` | string | | Session issuer identifier | |

### TLS Object
**Purpose**: Transport Layer Security connection details.

**Required Properties**: `version`

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `version` | string | ✓ | TLS protocol version | |
| `cipher` | string | | Negotiated cipher suite | |
| `certificate` | object | | Server certificate | See [Certificate Object](#certificate-object) |
| `sni` | string | | Server Name Indication | |
| `ja3_hash` | object | | JA3 client fingerprint | See [Fingerprint Object](#fingerprint-object) |
| `ja3s_hash` | object | | JA3S server fingerprint | See [Fingerprint Object](#fingerprint-object) |
| `client_ciphers` | array[string] | | Client cipher suites | |
| `server_ciphers` | array[string] | | Server cipher suites | |
| `handshake_dur` | integer | | Handshake duration in milliseconds | |

### URL Object
**Purpose**: Uniform Resource Locator details.

**Conditional Requirements**: Must have at least one of `url_string` or `path`

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `url_string` | string | ○ | Complete URL | Must have url_string or path |
| `scheme` | string | | URL scheme | http, https, ftp |
| `hostname` | string | | Host name | |
| `domain` | string | | Domain name | |
| `subdomain` | string | | Subdomain | |
| `path` | string | ○ | URL path | Must have url_string or path |
| `port` | integer | | URL port | |
| `query_string` | string | | Query parameters | |
| `categories` | array[string] | | Web category names | Auto-derived from category_ids |
| `category_ids` | array[integer] | | Web categorization identifiers | |

### User Object
**Purpose**: User identities and attributes.

**Conditional Requirements**: Must have at least one of `uid_alt`, `account`, `uid`, or `name`

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `uid` | string | ○ | User unique identifier | One of required alternatives |
| `uid_alt` | string | ○ | Alternative user identifier | One of required alternatives |
| `name` | string | ○ | Username | One of required alternatives |
| `display_name` | string | | User display name | |
| `full_name` | string | | User full name | |
| `email_addr` | string | | Primary email address | |
| `domain` | string | | User domain | |
| `account` | object | ○ | Associated account | See [Account Object](#account-object) |
| `groups` | array[object] | | Group memberships | See [Group Object](#group-object) |
| `type` | string | | User type name | Auto-derived from type_id |
| `type_id` | integer | | User type identifier | User, Admin, System, Service |
| `risk_level` | string | | Risk level name | Auto-derived from risk_level_id |
| `risk_score` | integer | | Risk assessment score | |
| `has_mfa` | boolean | | Multi-factor authentication status | |

### Vulnerability Object
**Purpose**: Vulnerability details with standards alignment.

**Conditional Requirements**: Must have exactly one of `cve`, `cwe`, or `advisory`

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `cve` | object | ○ | CVE vulnerability reference | See [CVE Object](#cve-object) |
| `cwe` | object | ○ | CWE weakness reference | See [CWE Object](#cwe-object) |
| `advisory` | object | ○ | Advisory reference | See [Advisory Object](#advisory-object) |
| `affected_packages` | array[object] | | Affected software packages | See [Affected Package Object](#affected-package-object) |
| `affected_code` | array[object] | | Affected code blocks | See [Affected Code Object](#affected-code-object) |
| `desc` | string | | Vulnerability description | |
| `title` | string | | Vulnerability title | |
| `severity` | string | | Vendor-assigned severity | |
| `is_fix_available` | boolean | | Fix availability status | |
| `is_exploit_available` | boolean | | Exploit availability status | |
| `remediation` | object | | Remediation guidance | See [Remediation Object](#remediation-object) |

### Anomaly Analysis Object
**Purpose**: Describes baseline behavior patterns and detected anomalies that triggered security findings.

**Required Properties**: `analysis_targets`, `anomalies`

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `analysis_targets` | array[object] | ✓ | Array of monitored entities | users, systems, processes |
| `anomalies` | array[object] | ✓ | Array of detected deviations from baseline behavior | |
| `baselines` | array[object] | | Array of established normal activity patterns | |
| `uid` | string | | Analysis identification unique identifier | |
| `name` | string | | Analysis name | |
| `desc` | string | | Analysis description | |

**Related Sub-Objects**:
- **Analysis Target**: `name` (required), `type`, `uid`
- **Anomaly**: `observation_parameter`, `observations` (required), `observation_type`, `observed_pattern`, `confidence`, `severity`
- **Baseline**: `observation_parameter`, `observations` (required), `observation_type`, `observed_pattern`, `learning_period`
- **Observation**: `value` (required), `count`, `timespan`, `timestamp`, `context`

### OSINT Object  
**Purpose**: Open Source Intelligence information related to threat indicators.

**Required Properties**: `type_id`, `value`

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `type` | string | | Indicator type name | Auto-derived from type_id |
| `type_id` | integer | ✓ | Indicator type identifier | IP Address, Domain, Hash, URL, etc. |
| `value` | string | ✓ | Actual indicator value | IP, domain, hash, URL |
| `confidence` | string | | Intelligence confidence level name | Auto-derived from confidence_id |
| `confidence_id` | integer | | Intelligence confidence level identifier | |
| `severity` | string | | Threat severity assessment name | Auto-derived from severity_id |
| `severity_id` | integer | | Threat severity assessment identifier | |
| `reputation` | object | | Reputation scoring information | See [Reputation Object](#reputation-object) |
| `verdict` | string | | Intelligence verdict name | Auto-derived from verdict_id |
| `verdict_id` | integer | | Intelligence verdict identifier | |
| `threat_actor` | string | | Associated threat actor information | |
| `campaign` | string | | Related campaign details | |
| `malware` | array[object] | | Associated malware information | See [Malware Object](#malware-object) |
| `vulnerabilities` | array[object] | | Related vulnerability details | See [Vulnerability Object](#vulnerability-object) |
| `detection_pattern` | string | | Detection signature or pattern | |
| `detection_pattern_type` | string | | Pattern type | STIX, YARA, Snort, etc. |
| `references` | array[string] | | External information sources | |
| `labels` | array[string] | | Tags for searchability | |
| `created_time` | timestamp | | Intelligence creation time | Unix timestamp |
| `modified_time` | timestamp | | Intelligence modification time | Unix timestamp |
| `expiration_time` | timestamp | | Intelligence expiration time | Unix timestamp |
| `creator` | string | | Intelligence creator | |
| `vendor_name` | string | | Intelligence vendor | |
| `provider` | string | | Intelligence provider | |

### Malware Scan Info Object
**Purpose**: Detailed information about malware scan operations.

**Conditional Requirements**: Must have at least one of `uid` or `name`

**Required Properties**: `type_id`

| Property | Type | Required | Description | Constraints |
|----------|------|----------|-------------|-------------|
| `uid` | string | ○ | Scan instance unique identifier | Must have uid or name |
| `name` | string | ○ | Administrator-supplied scan name | Must have uid or name |
| `type` | string | | Scan type name | Auto-derived from type_id |
| `type_id` | integer | ✓ | Scan type identifier | Manual, Scheduled, Real-time, etc. |
| `engine` | string | | Malware detection engine used | |
| `version` | string | | Scanner engine version | |
| `start_time` | timestamp | | Scan start time | Unix timestamp |
| `end_time` | timestamp | | Scan end time | Unix timestamp |
| `duration` | integer | | Total scan duration in milliseconds | |
| `num_files` | integer | | Total files analyzed | |
| `num_infected` | integer | | Files identified as infected | |
| `num_quarantined` | integer | | Files moved to quarantine | |
| `num_cleaned` | integer | | Files successfully remediated | |
| `unique_malware_count` | integer | | Unique malware variants detected | |
| `size` | integer | | Total data size scanned in bytes | |
| `signature_version` | string | | Malware signature database version | |

---

---

*This reference serves as the authoritative documentation for all shared OCSF objects. For event-class-specific objects and requirements, refer to individual event class documentation.*
