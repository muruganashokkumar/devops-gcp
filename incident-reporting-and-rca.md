### Incident Reporting and Root Cause Analysis (RCA) in GCP


## Incident Reporting in GCP

Incident reporting is the process of **capturing what went wrong**, how it was detected, its **impact**, and what **actions** were taken.

### Best Practices

| Step                        | Description                                              |
| --------------------------- | -------------------------------------------------------- |
| **Title**                   | Brief description of what went wrong                     |
| **Incident Number**         | Use a unique identifier (e.g., `INC-20240618-001`)       |
| **Date & Time**             | Start time and end time (with timezone)                  |
| **Detected By**             | Monitoring alert, user report, synthetic test            |
| **Affected Services**       | GKE, GCE, Cloud Run, Cloud SQL, etc.                     |
| **Impact Summary**          | What was affected (e.g., 80% traffic loss, DB read-only) |
| **Severity Level**          | SEV1 (critical), SEV2, SEV3                              |
| **Stakeholders Informed**   | Engineering, DevOps, Product, Clients                    |
| **Immediate Actions Taken** | What was done to mitigate                                |

---

## Tools to Detect and Report Incidents in GCP

| Tool                               | Purpose                                                                                  |
| ---------------------------------- | ---------------------------------------------------------------------------------------- |
| **Cloud Monitoring (Stackdriver)** | Dashboard, uptime checks, metrics                                                        |
| **Cloud Logging**                  | See logs from all services in real-time                                                  |
| **Error Reporting**                | Automatically detects and aggregates app errors                                          |
| **Alerting Policies**              | Sends alerts (email, Slack, PagerDuty) based on thresholds                               |
| **Cloud Trace**                    | Understand performance bottlenecks                                                       |
| **Cloud Profiler**                 | Continuous profiling to find CPU/memory hotspots                                         |
---

## Root Cause Analysis (RCA)

### RCA Template

| Section                | Description                                        |
| ---------------------- | -------------------------------------------------- |
| **Summary**            | High-level overview of what happened               |
| **Root Cause**         | What exactly triggered the failure                 |
| **Timeline**           | Ordered events (e.g., 10:01AM: Deployment started) |
| **Detection**          | How the issue was identified                       |
| **Impact**             | Systems/users affected and to what extent          |
| **Resolution**         | Steps taken to resolve                             |
| **Preventive Actions** | What will be done to prevent recurrence            |

---

### Example RCA

```
Title: Cloud Run app outage on June 18
Incident ID: INC-20240618-001
Detected By: Cloud Monitoring alert on 5XX error rate

Timeline:
- 10:00 AM - New Cloud Run revision deployed
- 10:05 AM - Error rate > 60%
- 10:10 AM - Alert triggered
- 10:12 AM - Rollback initiated
- 10:15 AM - Traffic normalized

Root Cause:
Misconfigured environment variable caused app to crash on start

Impact:
- 100% downtime on /api endpoint for 15 mins
- ~8000 failed requests

Resolution:
Rollback to previous working revision

Preventive Measures:
- Add canary deployment checks
- Add automated integration test pipeline before deploy
```

---


## Postmortem Culture

* Keep blame-free and educational
* Focus on fixing the system, not people
* Share RCA internally (optionally externally)


