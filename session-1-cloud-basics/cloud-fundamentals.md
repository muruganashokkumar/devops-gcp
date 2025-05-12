### **1. On-Premises Data Centers**

**Definition:**
On-premises (on-prem) means all computing infrastructure—like servers, storage, and networking—is physically located within a company’s premises. The organization owns, manages, and maintains all hardware and software.

**Example:**
Imagine a company builds a server room in its office building. It buys racks, servers, cables, cooling systems, and hires IT staff to manage everything.

**Challenges:**

* **High Initial Cost**: Buying hardware is expensive.
* **Scalability Issues**: Adding more capacity takes time.
* **Maintenance**: Requires skilled staff and regular updates.
* **Disaster Recovery**: Must have its own backup and recovery plans.

**Use Case:** Banks or government organizations that require high control over data and strict compliance often still use on-prem systems.

---

### **2. Evolution of Cloud and GCP**

**What is Cloud?**
Cloud computing means using the internet to access computing services—servers, storage, databases—hosted by providers like AWS, GCP, Azure.

**How it evolved:**

* Early 2000s: Companies managed everything on-prem.
* 2006: Amazon introduced AWS and changed the game by offering computing power on-demand.
* Google launched **Google Cloud Platform (GCP)** shortly after, using the same technology that powers Google Search, YouTube, and Gmail.

**GCP Highlights:**

* Big on AI/ML (TensorFlow, BigQuery).
* High-performance global network.
* Secure by design (Google-grade security).

---

### **3. Advantages of Cloud over On-Premises**

| Feature               | On-Premises         | Cloud               |
| --------------------- | ------------------- | ------------------- |
| **Cost**              | High upfront        | Pay-as-you-go       |
| **Scalability**       | Manual              | Auto-scale          |
| **Maintenance**       | Your responsibility | Handled by provider |
| **Disaster Recovery** | Manual setup        | Built-in options    |
| **Speed**             | Weeks to set up     | Minutes to deploy   |

**Real-World Analogy:**
Owning an on-prem system is like buying a car—you pay upfront, handle maintenance, and it sits idle when not used. Cloud is like using Uber—pay only when you ride, and no maintenance worries.

---

### **4. Global Infrastructure and Regions**

**Definition:**
Cloud providers organize their infrastructure into **Regions** and **Zones**:

* **Region**: A geographical location (e.g., `asia-south1` = Mumbai).
* **Zone**: A data center within that region (e.g., `asia-south1-a`, `asia-south1-b`).

**Why this matters:**

* **High availability**: Deploy across multiple zones.
* **Low latency**: Choose region close to users.
* **Compliance**: Keep data within specific regions (like India).

**Example Use Case:**
An e-commerce site hosting frontend in India and backend in the US for global customers.

---

### **5. Well-Architected Framework (Google Cloud’s Approach)**

**Purpose:**
A set of best practices for building secure, high-performing, resilient, and efficient cloud applications.

**Google’s key pillars:**

* **Operational Excellence**
* **Security**
* **Reliability**
* **Performance Efficiency**
* **Cost Optimization**
* **Sustainability**

**Use Case:**
When designing an app, ensure:

* You monitor performance (Operational Excellence)
* Use IAM policies for users (Security)
* Have backups (Reliability)
* Auto-scale services (Performance)
* Choose right-sized instances (Cost Optimization)

---

### **6. Shared Responsibility Model**

**Concept:**
Security and operations in the cloud are **shared** between the provider and the customer.

| Responsibility            | Cloud Provider          | You (Customer) |
| ------------------------- | ----------------------- | -------------- |
| Physical security         | ✅                       | ❌              |
| Network infrastructure    | ✅                       | ❌              |
| Virtual machines patching | ✅ (PaaS/SaaS), ❌ (IaaS) | Depends        |
| Application data          | ❌                       | ✅              |
| Access controls           | ❌                       | ✅              |

**Analogy:**
If cloud is an apartment, the landlord (provider) ensures the building is safe and maintained, but **you’re responsible for locking your door and not leaving the stove on**.

---

### **7. Cloud Computing Models (IaaS, PaaS, SaaS)**

1. **IaaS (Infrastructure as a Service)**

    * You manage: OS, runtime, apps
    * Cloud provides: Servers, storage, network
    * Example: Compute Engine (GCP), EC2 (AWS)
    * Use Case: Custom software requiring OS-level control.

2. **PaaS (Platform as a Service)**

    * You manage: Just your application and data
    * Cloud provides: OS, runtime, scaling
    * Example: App Engine, Cloud Run
    * Use Case: Web apps, APIs without worrying about servers.

3. **SaaS (Software as a Service)**

    * Everything is managed for you
    * Example: Gmail, Google Docs, Salesforce
    * Use Case: End users accessing ready-made software.

---

### **8. Cloud Service Types (Compute, Storage, Database, Networking)**

**a. Compute**

* Run your applications.
* Examples: Compute Engine (VMs), App Engine (auto-scaled apps), Cloud Functions (serverless).
* Use Case: Host a website, run backend APIs.

**b. Storage**

* Store files, backups, or large data.
* Examples: Cloud Storage (object storage), Persistent Disks (block storage), Filestore (file storage).
* Use Case: Media storage, backup archives.

**c. Database**

* Store structured data.
* Examples: Cloud SQL (MySQL, PostgreSQL), Firestore (NoSQL), BigQuery (Analytics).
* Use Case: CRM system, analytics dashboards.

**d. Networking**

* Connect services securely and reliably.
* Examples: VPC (Virtual Private Cloud), Load Balancer, Cloud CDN, Cloud NAT.
* Use Case: Secure network, optimize latency and availability.

