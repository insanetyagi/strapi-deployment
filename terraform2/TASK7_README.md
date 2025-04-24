# ✅ Task 7: Monitoring & Alerting for Strapi on AWS ECS Fargate

## 🧩 Overview

This task focuses on implementing **CloudWatch monitoring and alerting** for the Strapi application deployed on **AWS ECS Fargate**. The objective is to ensure observability of system performance and real-time notification in case of resource exhaustion.

---

## 📊 Monitoring Setup

- **CloudWatch Logs**  
  Integrated with ECS to stream real-time container logs.

- **CloudWatch Alarms**  
  Automatically trigger when CPU or memory crosses threshold limits.

- **CloudWatch Dashboard**  
  Visual overview of ECS metrics like CPU and memory utilization.

---

## 🧱 Resources Provisioned

### 🔹 Log Group

- **Name**: `/ecs/strapi`  
- **Purpose**: Streams container logs via the `awslogs` driver from ECS Task Definition.

---

### 🔹 CloudWatch Alarms

- **High CPU Utilization Alarm**  
  - **Threshold**: CPU > 80%  
  - **Duration**: For at least 2 consecutive evaluation periods (1 min each)

- **High Memory Utilization Alarm**  
  - **Threshold**: Memory > 80%  
  - **Duration**: For at least 2 consecutive evaluation periods (1 min each)

---

### 🔹 CloudWatch Dashboard

- **Name**: `StrapiMonitoringDashboard`  
- **Includes**:  
  - CPU Utilization (ECS Service Level)  
  - Memory Utilization (ECS Service Level)  
- **Visualization**: Real-time time series view

---

## ⚙️ How It Works

- ECS Task Definition includes a `logConfiguration` block using the `awslogs` driver.
- Logs are streamed into the `/ecs/strapi` log group.
- Metric alarms continuously evaluate resource usage.
- The dashboard visualizes key metrics from ECS in real time.

---

## ✅ Verification Steps

### 🔍 Log Streams
- Go to: **CloudWatch → Log Groups → `/ecs/strapi`**
- ✅ Confirm recent log streams are showing container logs from ECS tasks.

### 🔍 Alarms
- Go to: **CloudWatch → Alarms**
- ✅ Check:
  - `HighCPUUtilization`
  - `HighMemoryUtilization`
- Status should show **OK** unless thresholds are breached.

### 🔍 Dashboard
- Go to: **CloudWatch → Dashboards → `StrapiMonitoringDashboard`**
- ✅ Confirm real-time graphs for CPU and Memory utilization.

### 🔍 ECS Health
- Go to: **ECS Console → Cluster → Services**
- ✅ Ensure service status is **RUNNING** and stable.

---

## 💡 Notes

- 📬 In future, alarms can be integrated with **SNS** to trigger **email or SMS notifications**.
- 🗑️ Log retention is configured to **7 days** (modifiable via `cloudwatch.tf`).

---
