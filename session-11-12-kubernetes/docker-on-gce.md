## Setting up Docker on GCE (Google Compute Engine)

#### 1. Start the VM
- Create or start a VM instance in Google Cloud.
- Choose an OS like **Debian** or **Ubuntu** for Docker compatibility.

#### 2. Install Docker
- SSH into the VM instance.
- Follow the official Docker installation steps for Debian:
  👉 [Install Docker on Debian](https://docs.docker.com/engine/install/debian/)

- set up user permission 
```bash
sudo usermod -aG docker $USER && newgrp docker
```

#### 3. Set up Networking & Firewall Rules

##### a. Check Network Interface
- Go to **VM Instances** > Select your instance  
- Under **Network Interfaces**, ensure:
  - **Network** is set to `default`

##### b. Add Firewall Rules
- Navigate to **VPC network** > **Firewall**
- Click **Create Firewall Rule**
- Set the following:
  - **Name**: `allow-all` (or any descriptive name)
  - **Targets**: All instances in the network
  - **Source IP ranges**: `0.0.0.0/0`
  - **Protocols and ports**: Select **Allow all**

### Allowing all traffic is fine for testing but **not recommended for production**. Lock down ports and IPs as needed.

