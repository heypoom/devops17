## Kubernetes Infrastructure

What will we see in Production Environment?

> Reference: [Launch Kubernetes Cluster - Katacoda](https://www.katacoda.com/courses/kubernetes/launch-cluster)

> Kubernetes consists of a combination of components, each run on the Master node.

> To start a container you define a replication controller (rc) and a service (svc) in yaml files.

> Before we can deploy Kubernetes addons, we need to create a kube-system namespace.

- Docker.
   - Should be installed on every cluster.
   - Everything else will be run as containers!

- etcd: distributed reliable key-store
   - Persistent storage of configurations, states and API objects for Kubernetes
   - Should be run as a cluster with more than 3 nodes for High Availability purpose

- API Server
   - The API processes requests from the master and store information in the etcd cluster. 
   - Uses the Hyperkube library

- The Master: controlling unit for the cluster
   - The Master is a single node which manages the cluster and the containers running it in.
   - It will manage scheduling (e.g. launch) of new containers, configure networking and provide health information, and understand which node they run on.
   - The Master will communicate with the API and nodes to complete the required tasks.
   - Launching the Master will launch more services it requires to run the cluster.

- Proxy
   - Each node in the cluster requires a running proxy server. 
   - The proxy is responsibility for managing communications by modifying the IPTables of the host machine.
   - It also handles load balancing of traffic between containers on a host.

- kubectl: the command line client used to communicate with the Master.

- KubeDNS/SkyDNS:
   - The DNS allows containers to communicate based on well-known names instead of IP addresses.
   - Because Kubernetes uses etcd, it uses the related DNS service called SkyDNS.
   - When we started the Master we defined a DNS IP, which we'll now launch.

- Dashboard (Kube UI)

- kubelet: primary node agent that runs on each node.

- Flannel: Network Fabric for containers
  - Does not rely on overlay network => no encapsulation => better performance
  - Plugins for providing network connectivity

- Services started automatically by the Master:
  - The Controller Manager handles replication. 
  - The Scheduler Server handles tracking resource use; ensures containers can run on it's assigned node without overloading capacity.

## Real World: Kubernetes in Production

- Google Container Platform

[Reference](https://techbeacon.com/one-year-using-kubernetes-production-lessons-learned)

### Deploy Kubernetes with Ansible

### Load Balance with HAProxy or NginX

- 

### Centralized Logging & Monitoring

- Logging: Kafka (Msg) + Graylog (Index)
  - Alternative: [Log from Container](https://www.loggly.com/blog/top-5-docker-logging-methods-to-fit-your-container-deployment-strategy)

- Monitoring: InfluxDB + Heapster + Grafana

### Continuous Integration and Continuous Deployment

- CI: Build server /w Docker + Git -> Docker Registry (Hub)
- CD: WebHook to Deployer -> Kubernetes

> Kubernetes recovery works so well that we have had situations where our containers would crash multiple times a day because of a memory leak, without anyone (including ourselves) noticing it.

- Setting up
  - Components
    - etcd
    - KubeDNS
    - etc
