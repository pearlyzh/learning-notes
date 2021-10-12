# Kubernetes

## DevOps and NoOps
- Ideally, you want the developers to deploy applications themselves without knowing
anything about the hardware infrastructure and without dealing with the ops
team. This is referred to as NoOps

## Containers
### Linux Container technologies
- Linux allows you to run multiple services on the same host machine, while not only
exposing a different environment to each of them, but also isolating them from each
other, similarly to VMs, but with much less overhead.
- Containers, on the other hand, all perform system calls on the exact same kernel running in the host OS. This single kernel is the only one performing x86 instructions on the host’s CPU.
- How about security, because containers all call out to the same kernel, and resource isolated as well?
    - Two mechanisms make this possible:
        - The first one, Linux Namespaces, makes sure each process sees its own personal view ofthe system (files, processes, network interfaces, hostname, and so on). 
        - The second one is Linux Control Groups (cgroups), which limit the amount of resources the process can consume (CPU, memory, network bandwidth, and so on).
### Isolate Resource with Linux Namespace
- By default, each Linux system initially has one single namespace. 
- All system resources, such as filesystems, process IDs, user IDs, network interfaces, and others, belong to the single namespace.
- We can create additional namespaces and organize resources across them. When running a process, you run it inside one of those namespaces. The process will only see resources that are inside the same namespace.
- Each namespace kind is used to isolate a certain group of resources (Mount, Process ID, Network, Inter-process communication, UTS, User ID)
- Limit resources:
    - This is achieved with cgroups, a Linux kernel feature that limits the resource usage of a process (or a group of processes).
    - A process
can’t use more than the configured amount of CPU, memory, network bandwidth

### Docker
 - It simplified the process of packaging up not only the application but also all its libraries and other dependencies, even the whole OS file system, into a simple, portable package. It sees the exact filesystem contents that you’ve bundled with it.
 - Images layer:
    - Different images can contain the exact same layers because every Docker image is built on top of another image and two different images can both use the same parent image as their base.
    - Two containers created from two images based on the same base layers can therefore read the same files. 
    - But **container image layers are read-only**. When a container is run, a new writable layer is created on top of the layers in the image.
    - We can’t containerize an application built for the x86 architecture and expect it to run on an ARM-based machine because it also runs Docker. We still need a VM for that.

## K8s from the bird's view
- Kubernetes enables you to run your software applications on thousands of computer
nodes as if all those nodes were a single, enormous computer. It abstracts away
the underlying infrastructure and, by doing so, simplifies development, deployment,
and management for both development and the operations teams.
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

## Core concepts
### Pods
 - Why multiple containers are better than one container running
Multiple processes?
    - If you run multiple unrelated processes in a single container, it is your responsibility to keep all those processes running, manage their logs, and so on. For example, you’d have to include a mechanism for automatically restarting individual processes if they crash. 
    - Also, all those processes would log to the same standard output, so you’d have a hard time figuring out what process logged what.
 - The flat inter-pod network
    - Communication between pods is always simple. 
    It doesn’t matter if two pods are scheduled onto a single or onto different worker nodes; in both cases the containers inside those pods can communicate with each other across the flat NATless network, much like computers on a local area network (LAN), regardless of the actual inter-node network topology. 
    - Like a computer on a LAN, each pod gets its own IP address and is accessible from all other pods through this network established specifically for pods.
- Splitting multi-tier apps into multiple pods
    - Splitting into multiple pods to enable individual scaling
    - The main reason to put multiple containers into a single pod is when the application consists of one main process and one or more complementary processes,