# Kubernetes

## Ref
 - https://towardsdatascience.com/a-beginner-friendly-introduction-to-kubernetes-540b5d63b3d7

## DevOps and NoOps
- Ideally, you want the developers to deploy applications themselves without knowing anything about the hardware infrastructure and without dealing with the ops team. This is referred to as NoOps

## Containers
### Linux Container technologies
- Linux allows you to run multiple services on the same host machine, while not only exposing a different environment to each of them, but also isolating them from each other, similarly to VMs, but with much less overhead.
- Containers, on the other hand, all perform system calls on the exact same kernel running in the host OS. This single kernel is the only one performing x86 instructions on the host’s CPU.
- How about security, because containers all call out to the same kernel, and resource isolated as well?
    - Two mechanisms make this possible:
        - https://www.tothenew.com/blog/cgroups-and-namespaces-on-ubuntu/
        - The first one, Linux Namespaces, makes sure each process sees its own personal view of the system (files, processes, network interfaces, hostname, and so on). 
        - The second one is Linux Control Groups (**cgroups**), which limit the amount of resources the process can consume (CPU, memory, network bandwidth, and so on).
        - For Windows server: we have https://docs.microsoft.com/en-us/virtualization/windowscontainers/manage-containers/hyperv-container
### Isolate Resource with Linux Namespace
- https://www.tothenew.com/blog/cgroups-and-namespaces-on-ubuntu/
- By default, each Linux system initially has one single namespace. 
- All system resources, such as **filesystems**, process IDs, user IDs, network interfaces, and others, belong to the single namespace.
- We can create additional namespaces and organize resources across them. When running a process, you run it inside one of those namespaces. The process will only see resources that are inside the same namespace.
- Each namespace kind is used to isolate a certain group of resources (Mount, Process ID, Network, Inter-process communication, UTS, User ID)
- Limit resources:
    - This is achieved with **cgroups**, a Linux kernel feature that limits the resource usage of a process (or a group of processes).
    - A process can’t use more than the configured amount of CPU, memory, network bandwidth

### Docker
 - It simplified the process of packaging up not only the application but also all its libraries and other dependencies, even the whole OS file system, into a simple, portable package. It sees the exact filesystem contents that you’ve bundled with it.
 - Images layer:
    - Different images can contain the exact same layers because every Docker image is built on top of another image and two different images can both use the same parent image as their base.
    - Two containers created from two images based on the same base layers can therefore read the same files. 
    - But **container image layers are read-only**. When a container is run, a new writable layer is created on top of the layers in the image.
    - We can’t containerize an application built for the x86 architecture and expect it to run on an ARM-based machine because it also runs Docker. We still need a VM for that.
 - It doesn't need a base image of an OS: https://stackoverflow.com/a/59539587
 - Flashback Docker: https://www.youtube.com/watch?v=3c-iBn73dDE

## K8s from the bird's view
- Kubernetes enables you to run your software applications on thousands of computer nodes as if all those nodes were a single, enormous computer. It abstracts away the underlying infrastructure and, by doing so, simplifies development, deployment, and management for both development and the operations teams.
- Help developer focus on the core app features
- Help ops teams achieve better resource utilization
    - Simplifying application deployment
    - Achieving better utilization of hardware
    - Health checking and self-healing
    - Automatic scaling
    - Simplifying application development
        - Detect bugs sooner
        - Not have to invent the wheel (DNS lookup, leader election)
        - App version control

- Architecture
    - Master node -> Control Plane: controls and manages the whole Kubernetes system.
        - *Kubernetes API Server*, which you and the other Control Plane components communicate with
        - *Scheduler*, which schedules your apps
        - *Controller Manager*, which performs cluster-level functions, such as replicating components
        - *etcd*, a reliable distributed data store that persistently stores the cluster configuration.
    - Worker node(s): run the actual applications you deploy
        - *Kubelet*, which talks to the API server and manages containers on its node
        - *Kubernetes Service Proxy* (kube-proxy), which load-balances network traffic between application components

# Core concepts
## Pods
 - Pods represent the basic deployable unit in Kubernetes, and the basic unit of scaling.
 - Why multiple containers are better than one container running Multiple processes?
    - If you run multiple unrelated processes in a single container, it is your responsibility to keep all those processes running, manage their logs, and so on. For example, you’d have to include a mechanism for automatically restarting individual processes if they crash. 
    - Also, all those processes would log to the same standard output, so you’d have a hard time figuring out what process logged what.
 - The flat inter-pod network
    - Communication between pods is always simple. 
    It doesn’t matter if two pods are scheduled onto a single or onto different worker nodes; in both cases the containers inside those pods can communicate with each other across the flat NATless network, much like computers on a local area network (LAN), regardless of the actual inter-node network topology. 
    - Like a computer on a LAN, each pod gets its own IP address and is accessible from all other pods through this network established specifically for pods.
- Splitting multi-tier apps into multiple pods
    - Splitting into multiple pods to enable individual scaling
    - The main reason to put multiple containers into a single pod is when the application consists of one main process and one or more complementary processes
- Deciding when to use multiple containers in a pod
    - Do they need to be run together or can they run on different hosts?
    - Do they represent a single whole or are they independent components?
    - Must they be scaled together or individually?
### Organizing pods with labels
- Labels are a simple, yet incredibly powerful, Kubernetes feature for organizing not
only pods, but all other Kubernetes resources.
- A label is an arbitrary key-value pair you attach to a resource, which is then utilized when selecting resources using label selectors
- A resource can have more than one label, as long as the keys of those labels are
unique within that resource.
- Label selectors aren’t useful only for listing pods, but also for performing actions on a subset of all pods. Benefits:
    - Using labels for categorizing worker nodes
    - Scheduling pods to specific nodes
    - Scheduling to one specific node
### Annotating pods
- Annotations are also key-value pairs, so in essence, they’re similar to labels, but they aren’t meant to hold identifying information.
- Annotations allow attaching larger blobs of data to pods either by people or
tools and libraries.

### Using namespaces to group resources
- Using multiple namespaces allows you to split complex systems with numerous components into smaller distinct groups.
- Namespaces can be used to allow different teams to use the same cluster as though they were using separate Kubernetes clusters.
- How to use the kubectl explain command to quickly look up the information on any Kubernetes resource.

## Replication and other controllers, deploying and managed pods
### Liveness probes
- You can specify a liveness probe for each container in the pod’s specification. Kubernetes will periodically
execute the probe and restart the container if the probe fails.
    - An HTTP GET probe performs an HTTP GET request on the container’s IP address, a port and path you specify
    - A TCP Socket probe tries to open a TCP connection to the specified port of the container
    - An Exec probe executes an arbitrary command inside the container and checks the command’s exit status code

### Replication Controllers (to be deprecated)
- ReplicationControllers were the only Kubernetes component for replicating
pods and rescheduling them when nodes failed. It is a Kubernetes resource that ensures its pods are always kept running
- A ReplicationController’s job is to make sure that an exact number of pods always matches its label selector. If it doesn’t, the ReplicationController takes the appropriate action to reconcile the actual with the desired number
- 3 Parts:
    - A label selector, which determines what pods are in the ReplicationController’s scope
    - A replica count, which specifies the desired number of pods that should be running
    - A pod template, which is used when creating new pod replicas
- Benefits:
    - It makes sure a pod (or multiple pod replicas) is always running by starting a new pod when an existing one goes missing.
    - When a cluster node fails, it creates replacement replicas for all the pods that were running on the failed node (those that were under the Replication- Controller’s control).
    - It enables easy horizontal scaling of pods—both manual and automatic (see horizontal pod auto-scaling in chapter 15).
- Changing the pod template
    - Changing the pod template is like replacing a cookie cutter with another one. It will only affect the cookies you cut out afterward and will have no effect on the ones you’ve already cut.
#### Horizontally scaling pods
- Declarative approach
    - "I want to have x number of instances running." You’re not telling Kubernetes what or how to do it. You’re just specifying the desired state.

### Replica Sets
- It’s a n**ew generation of ReplicationController** and replaces it completely (ReplicationControllers will eventually be deprecated).
- A ReplicaSet **behaves exactly like** a ReplicationController, but it has **more expressive pod selectors**.
- Whereas a ReplicationController’s label selector only allows matching pods that include a certain label, ReplicaSet’s selector also allows matching pods that lack a certain label or pods that include a certain label key, regardless of its value.

### Daemon Sets
- A DaemonSet makes sure it creates as many pods as there are nodes and deploys each one on its own node.

### Job resources
- You’ll have cases where you only want to run a task that terminates after completing its work.
- ReplicationControllers, ReplicaSets, and DaemonSets run continuous tasks that are never considered completed. Processes in such pods are restarted when they exit. But in a completable task, after its process terminates, it should not be restarted again.


### Cron jobs
- At the configured time, Kubernetes will create a Job resource according to the Job template configured in the CronJob object

### Take away for Replication and other controllers
- You can specify a liveness probe to have Kubernetes restart your container as soon as it’s no longer healthy (where the app defines what’s considered healthy).
- Pods shouldn’t be created directly, because they will not be re-created if they’re deleted by mistake, if the node they’re running on fails, or if they’re evicted from the node.
- ReplicationControllers always keep the desired number of pod replicas running.
- Scaling pods horizontally is as easy as changing the desired replica count on a ReplicationController.
- Pods aren’t owned by the ReplicationControllers and can be moved between them if necessary.
- A ReplicationController creates new pods from a pod template. Changing the template has no effect on existing pods.

### Services
- Enabling clients to discover and talk to pods.
- Pods need a way of finding other pods if they want to consume the services they provide. Unlike in the non-Kubernetes world, where a sysadmin would configure each client app by specifying the exact IP address or hostname of the server providing the service in the client’s configuration files, doing the same in Kubernetes wouldn’t work, because:
    - Pods are ephemeral
    - Kubernetes assigns an IP address to a pod after the pod has been scheduled to a node and before it’s started
    - Horizontal scaling means multiple pods may provide the same service
- Exposes multiple HTTP services through a single **Ingress** (consuming a single IP)
- ClusterIP: ClusterIP is a Kubernetes service type that is used to group pods together and provide a single interface to access them.
- NodePort: When we create a NodePort service, the service is assigned a high port on all nodes. When a request comes in for node:port, it will act as a built-in load balancer and send the request to one of the pods at random. NodePort is a Kubernetes service type that listens on a port on the node and forward requests on that port to a pod on the node
- LoadBalancer
- https://www.cortex.io/post/understanding-kubernetes-services-ingress-networking
- Unlike NodePort or LoadBalancer, Ingress is not actually a type of service. Instead, it is an entry point that sits in front of multiple services in the cluster. It can be defined as a collection of routing rules that govern how external users access services running inside a Kubernetes cluster.
- An **Ingress** is used when we have multiple services on our cluster and we want the user request routed to the service based on their path. Consider an example, I have two services foo and bar in our cluster. When we type www.example.com/foo we should be routed to the foo service and www.example.com/bar should be routed to bar service. These routings will be performed by an Ingress.


### Volumes
- Create a multi-container pod and have the pod’s containers operate on the
same files by adding a volume to the pod and mounting it in each container
- Use the emptyDir volume to store temporary, non-persistent data
- Use the gitRepo volume to easily populate a directory with the contents of a Git
repository at pod startup
- Use the hostPath volume to access files from the host node
- Mount external storage in a volume to persist pod data across pod restarts
- Decouple the pod from the storage infrastructure by using PersistentVolumes
and PersistentVolumeClaims
- Have PersistentVolumes of the desired (or the default) storage class dynamically
provisioned for each PersistentVolumeClaim
- Prevent the dynamic provisioner from interfering when you want the
