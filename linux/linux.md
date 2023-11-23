# Monolithic Kernel Versus Microkernel Designs

Monolithic kernels are the simpler design of the two, and all kernels were designed in this
manner until the 1980s. Monolithic kernels are implemented entirely as a single process
running in a single address space. Consequently, such kernels typically exist on disk as single
static binaries. All kernel services exist and execute in the large kernel address space.
Communication within the kernel is trivial because everything runs in kernel mode in the
same address space: The kernel can invoke functions directly, as a user-space application
might. Proponents of this model cite the simplicity and performance of the monolithic
approach. Most Unix systems are monolithic in design.

Microkernels, on the other hand, are not implemented as a single large process. Instead,
the functionality of the kernel is broken down into separate processes, usually called
servers. Ideally, only the servers absolutely requiring such capabilities run in a privileged execution
mode. The rest of the servers run in user-space. All the servers, though, are separated
into different address spaces. Therefore, direct function invocation as in monolithic
kernels is not possible. Instead, microkernels communicate via message passing: An interprocess
communication (IPC) mechanism is built into the system, and the various servers
communicate with and invoke “services” from each other by sending messages over the IPC
mechanism. The separation of the various servers prevents a failure in one server from
bringing down another. Likewise, the modularity of the system enables one server to be
swapped out for another.

# Process Management
 - A process is a program (object code stored on some media) in the midst of execution. Processes are, however, more than just the executing program code (often called the text section in Unix)