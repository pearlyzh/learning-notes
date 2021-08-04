# Common notes
## Experience
- Twitter at scale: https://blog.twitter.com/engineering/en_us/topics/infrastructure/2017/the-infrastructure-behind-twitter-scale.html
- Hypothetic:
	- Meet demand:
		- Functional Requirement:
			- What it should do, such as allowing data to be stored, retrieved, searched, and processed in various ways
		- Non-functional requirement:
			- General properties like security, reliability, compliance, scalability, compatibility, and maintainability.
	- Data intensive Application:
		- Reliability:
			- Making systems work correctly, even when faults occur.
		- Scalability:
			- Having strategies for keeping performance good, even when load increases.
		- Describing load
			- Describing performance
			- Coping with load
		- Maintainability:
			- In essence it’s about making life better for the engineering and operations teams who need to work with the system.
			- Operability
			- Simplicity
			- Evolvability
		- Resiliency is the ability of a system to gracefully handle the failures and recover from failures as soon as it can

## Database
- Transaction:
	- ACID
		- Atomicity:
			- If the writes are grouped together into an atomic transaction, and the transaction cannot be completed (committed) due to a fault, then the transaction is aborted and the database must discard or undo any writes it has made so far in that transaction
		- In the context of ACID, consistency refers to an application-specific notion of the database being in a “good state.”
		- Isolation Level:
			- https://medium.com/@huynhquangthao/mysql-testing-isolation-levels-650a0d0fae75
			- Transaction isolation is primarily about avoiding race conditions due to concurrently executing transactions
			- Read commited:
				- No dirty read and writes (e.g. Alice and Bob buy the same car, two operations must be performed)
				- Implement: The database remembers both the old committed value and the new value set by the transaction that currently holds the write lock. While the transaction is ongoing, any other transactions that read the object are simply given the old value. Only when the new value is committed do transactions switch over to reading the new value.
			- Snapshot Isolation and Repeatable Read: 
				- Non-repeatable read or Read Skew (e.g. To Alice it now appears as though she only has a total of $900 in her accounts—it seems that $100 has vanished into thin air).
				- Implement: Multiversion concurency control
			- Preventing Lost updates:
				- SELECT * FROM figures WHERE name = 'robot' AND game_id = 222 FOR UPDATE;
				- Usual approach which can cause Lost updates: Read-Modify-Write cycle
				- Atomic write operation: UPDATE counters SET value = value + 1 WHERE key = 'foo';
			- Prevent Write Skew (Both Alice and Bob are doctors who are on their call-shifts...)
				- It is neither a dirty write nor a lost update, because the two transactions are updating two different objects (Alice’s and Bob’s oncall records, respectively)
				- Materializing conflicts: Just a work-around solution. It turns the concurrency control mechanism leak into the application data model.
			- Prevent all of the above shits:
				- Serializable Isolation level:
					- Implementing:
						- Literally executing transactions in a serial order
						- Optimistic concurrency control techniques such as serializable snapshot isolation
- MySQL:
	- InnoDB: https://stackoverflow.com/questions/4358732/is-incrementing-a-field-in-mysql-atomic
	- B-tree vs B+-tree
		- https://stackoverflow.com/questions/870218/differences-between-b-trees-and-b-trees
		- https://towardsdatascience.com/why-we-need-indexes-for-database-tables-25198145a8ca
		- https://www.quora.com/-What-are-the-differences-between-B+Tree-and-B-Tree
		- https://dba.stackexchange.com/questions/204561/does-mysql-use-b-tree-btree-or-both
		- Branching factor: The number of references to child pages in one page of the B-tree
		- Preferable in many relational databases, transaction isolation is implemented using locks on ranges of keys, and in a B-tree index, those locks can be directly attached to the tree
	- Internals:
		- https://dev.mysql.com/doc/internals/en/optimizer-primary-optimizations.html
- Cassandra:
	- Is Column family, not column oriented:
		- https://stackoverflow.com/questions/13010225/why-many-refer-to-cassandra-as-a-column-oriented-database
	- Column-based vs row-based:
		- https://dataschool.com/data-modeling-101/row-vs-column-oriented-databases/
	- Hinted handoff:
		- By analogy, if you lock yourself out of your house, you knock on the neighbor’s door and ask whether you may stay on their couch temporarily.
- TiDB:
	- TiKV FAQ: https://tikv.org/docs/4.0/reference/faq/#:~:text=What%20is%20the%20relationship%20between,transactions%20of%20a%20relational%20database (ToRead)
	- TiKV
- Indexes:
	- Using B-tree: https://stackoverflow.com/questions/2362667/how-b-tree-indexing-works-in-mysql
	- Additional structure that is derived from the primary data. Many databases allow you to add and remove indexes, and this doesn’t affect the contents of the database; it only affects the performance of queries.
	- Acts as a signpost and helps you to locate the data you want.
		- Hash Indexes
		- Log-structured Indexes
	- LSM-Trees
		- SS-Table: we require that the sequence of key-value pairs is sorted by key.
			- Merging segments: The approach is like the one used in the merge-sort algorithm.
			- Still need an in-memory index to tell you the offsets for some of the keys, but it can be sparse: one key for every few kilobytes of segment file is sufficient, because a few kilobytes can be scanned very quickly
			- Constructing:
				- When a write comes in, add it to an in-memory balanced tree data structure (for example, a red-black tree). This in-memory tree is sometimes called a mem-table.
	- Log-structured storage engine:
		- Are a comparatively recent development. Their key idea is that they systematically turn random-access writes into sequential writes on disk, which enables higher write throughput due to the performance characteristics of hard drives and SSDs
- OLTP:
	- typically user-facing, which means that they may see a huge volume of requests. Disk seek time is often the bottleneck here.
- OLAP:
	- Disk bandwidth (not seek time) is often the bottleneck here, and column-oriented-storage is an increasingly popular solution for this kind of workload.

## Caching
- Redis:
	- Distributed locking:
		- https://redislabs.com/ebook/part-2-core-concepts/chapter-6-application-components-in-redis/6-2-distributed-locking/
		- https://www.quora.com/Distributed-Systems/Why-do-people-need-a-distributed-lock/answer/Sean-Owen?__snids__=52301574
	- RedLock Algorithm
## Language
- Declararive vs Imperative padigram:
	- https://stackoverflow.com/a/1784687/6085492
- Golang:
	- Naturally non-blocking
	- Compiled directly to machine code
	- M:N Scheduling Model
	- Is a divergence language 
	- https://medium.com/@riteeksrivastava/a-complete-journey-with-goroutines-8472630c7f5c
	- https://www.ardanlabs.com/blog/2018/08/scheduling-in-go-part1.html
	- https://www.ardanlabs.com/blog/2018/08/scheduling-in-go-part2.html
	- https://rakyll.org/scheduler/
	- Golang goroutines vs green thread:
		https://softwareengineering.stackexchange.com/questions/222642/are-go-langs-goroutine-pools-just-green-threads
- Java:
	- JVM:
		- https://ajay-yadav109458.medium.com/jvm-overview-21458b81ac4
	- Docs:
		- http://web.mit.edu/6.005/www/fa15/
	- Gargabe Collector:
		- Memory Leak
	- Framework:
		- Spring:
			- How it works internally:
				- The DispatcherServlet itself is a contract of Servlet (implementation of Servlet interface)
				- Servlet container contain and manage a servlet life cycle
				- https://stackoverflow.com/questions/44172261/how-spring-boot-application-works-internally#:~:text=From%20the%20run%20method%2C%20the,inside%20JVM%20which%20is%20known
			- Boot vs Cloud vs MVC:
				- Boot: a framework for setting up an application quickly, enables us to focus just on the business code (reduce botter-plate configuration code)
				- MVC: One of projects in Spring framework which supports building web oriented application (based on Servlet)
			- Spring Cloud: provides tools for developers to quickly build some of the common patterns in distributed systems
			- Servlet:
				- An interface in javax.servlet package
				- init() - service() - destroy()
			- Servlet Container:
				- https://stackoverflow.com/questions/3106452/how-do-servlets-work-instantiation-sessions-shared-variables-and-multithreadi
			- Design pattern:
				- https://www.baeldung.com/spring-framework-design-patterns
	- Finalize
		- https://www.geeksforgeeks.org/g-fact-24-finalfinally-and-finalize-in-java/
	- JMX
		- https://www.baeldung.com/java-management-extensions
		- https://www.journaldev.com/1352/what-is-jmx-mbean-jconsole-tutorial
	- Multiple inheritance:
		- https://qr.ae/TfazUC
		- https://qr.ae/TfexsR
	- Service Loader
	- Annotation:
		- An annotation is a marker which associates information with a program construct, but has no effect at run time.
	- Concurrency tutorial:
		- https://winterbe.com/posts/2015/04/07/java8-concurrency-tutorial-thread-executor-examples/
	- Patterns:
		- Dependency Injection (the implementation of IoC): https://martinfowler.com/articles/injection.html
	- Locking:
		- Internals: https://stackoverflow.com/questions/17368595/java-lock-concept-how-internally-works#:~:text=Each%20object%20in%20Java%20is,a%20lock%20on%20that%20monitor.
	- Interview:
		- https://howtodoinjava.com/spring-core/spring-ioc-vs-di/

## Networking
- Security:
	- CORS (Cross-site origins):
		- CORS and XSS:
			- https://stackoverflow.com/questions/28527790/does-cors-and-xss-have-any-connection
		- https://portswigger.net/web-security/cors
	- Storing passwords:
		- https://security.stackexchange.com/questions/211/how-to-securely-hash-passwords
	- Ways:
		- Integrity
		- Authentication
		- Non-reputation
		- Asymhttps://www.cloudflare.com/learning/ssl/what-is-asymmetric-encryption/
	- TLS:
		https://medium.facilelogin.com/nuts-and-bolts-of-transport-layer-security-tls-2c5af298c4be
		https://www.cloudflare.com/learning/ssl/what-happens-in-a-tls-handshake/
	- Atacking:
		- XSS:
			- https://portswigger.net/web-security/cross-site-scripting#:~:text=How%20does%20XSS%20work%3F,their%20interaction%20with%20the%20application.
			- Reflected cross-site scripting: https://insecure-website.com/status?message=<script>/*+Bad+stuff+here...+*/</script>
			- 
		- XSS vs CSRF:
			- https://medium.com/@l4mp1/difference-between-xss-and-csrf-attacks-ff29e5abcd33
			- XSS executes a malicious script in your browser, CSRF sends a malicious request on your behalf (for example, you logged into your fb account and your cookies has the your fb token, then you click on a strange link and realize that you have just liked the porn fucking page on fb)
- TCP:
	- https://www.youtube.com/watch?v=794V9oc3ZmI
	vs UDP:
		https://en.wikipedia.org/wiki/Datagram
	handshake
	- TCP internals:
		- https://www.oreilly.com/library/view/http-the-definitive/1565925092/ch04s01.html
		- https://sookocheff.com/post/networking/how-does-tcp-work/#:~:text=senders%20and%20receivers.-,TCP%20Segments,and%20an%20optional%20extension%20field.
	- BUFFER:
		- https://www.brianstorti.com/tcp-flow-control/
		- https://stackoverflow.com/questions/49648017/what-happens-in-tcp-when-the-internal-buffer-fills-up
	- Check TCP local config properties:
		- https://stackoverflow.com/questions/23592608/how-can-i-detect-tcp-dead-connection-in-linux-on-c
	- Maximum transmission unit:
		- https://en.wikipedia.org/wiki/Maximum_transmission_unit
		- https://stackoverflow.com/questions/11129212/tcp-can-two-different-sockets-share-a-port/11129641#:~:text=Multiple%20connections%20on%20the%20same,system%20resources%20allow%20it%20to.
	- Flow of control:
		- https://www.brianstorti.com/tcp-flow-control/#:~:text=TCP%20's%20flow%20control%20is,data%20than%20it%20can%20handle%3B&text=It%20will%20then%20periodically%20send,size%2C%20it%20resumes%20the%20transmission.
 - HTTP/1.1 - HTTP/2 - HTTP/3:
	- Visualization:
		https://freecontent.manning.com/animation-http-1-1-vs-http-2-vs-http-2-with-push/
	- HTTP Head of line blocking
	- TCP Head of line blocking
	- QUIC
- Encapsulation:
	- https://searchnetworking.techtarget.com/answer/How-are-TCP-IP-and-HTTP-related
- TCP/IP - OSI model:
	- https://stackoverflow.com/a/9329173/6085492
- TCP vs UDP:
	- Message oriented vs stream oriented: https://stackoverflow.com/questions/17446491/tcp-stream-vs-udp-message

## Communication
- Restful standard
- Java RMI:
	- https://stackoverflow.com/questions/2728495/what-is-the-difference-between-java-rmi-and-rpc
- RPC
	- https://www.smashingmagazine.com/2016/09/understanding-rest-and-rpc-for-http-apis/
- gRPC
	- Base on HTTP2
	- Use Protobuf standard for data present
		- https://grpc.io/docs/guides/concepts/
	- https://cs.mcgill.ca/~mxia3/2019/02/23/Using-gRPC-in-Production/
	- Flow control: https://www.youtube.com/watch?v=EEEGBwEA8yA
	- stream ID in a connection reaches max value (2^32) https://github.com/grpc/grpc/issues/957
- Asynchronous:
	- Messaging:
		- AMQ
		- 0MQ
		- RabbitMQ

## Mechanism
- Consistent Hashing:
	- https://itnext.io/introducing-consistent-hashing-9a289769052e
	- https://www.toptal.com/big-data/consistent-hashing#:~:text=Consistent%20Hashing%20is%20a%20distributed,without%20affecting%20the%20overall%20system.
- Encoding vs Serializing:
	- https://stackoverflow.com/questions/3784143/what-is-the-difference-between-serializing-and-encoding
- Non Blocking
	- Callback
	- Event loop
	- Worker thread
	- Netty:
		http://webcache.googleusercontent.com/search?q=cache:http://seeallhearall.blogspot.com/2012/05/netty-tutorial-part-1-introduction-to.html
- "Zero-copy": "Zero-copy" describes computer operations in which the CPU does not perform the task of copying data from one memory area to another. This is frequently used to save CPU cycles and memory bandwidth when transmitting a file over a network.[1]
	- https://en.wikipedia.org/wiki/Zero-copy
- Concurrency:
	- https://nikgrozev.com/2015/07/14/overview-of-modern-concurrency-and-parallelism-concepts/
- Parallelism
- ACID
- Little endian vs Big endian: 
	https://searchnetworking.techtarget.com/definition/big-endian-and-little-endian
	https://betterexplained.com/articles/understanding-big-and-little-endian-byte-order/
- Networking:
	- https://techdifferences.com/difference-between-flow-control-and-congestion-control.html
	- Congestion control:
		https://stackoverflow.com/questions/49648017/what-happens-in-tcp-when-the-internal-buffer-fills-up
	- Flow control
	- Onion routing:
		- Torch is an implementation of
		- Go through many of hops that encrypted-decrypted (and in contrary) data in many layers

## Data Structure
- Graph theory:
	- BFS vs DFS: https://stackoverflow.com/questions/3332947/when-is-it-practical-to-use-depth-first-search-dfs-vs-breadth-first-search-bf
	- 
- Probabilistic:
	- Hyperloglog
	- Count min sketch
	- Bloom filter
- Disruptor
	- Ring buffer
- Data storage:
	- https://medium.com/databasss/on-disk-io-part-3-lsm-trees-8b2da218496f

- Tree:
	- Traversal:
		- In-order: Left - Root- Right
		- Pre-order: Root - Left - Right
		- Post-order: Left - Right - Root

## Algorithm
- Big O:
	- Common runtimes example: https://www.bigocheatsheet.com/
	- In plain English: https://stackoverflow.com/questions/487258/what-is-a-plain-english-explanation-of-big-o-notation
- Quick-sort:
	- https://stackoverflow.com/questions/10425506/intuitive-explanation-for-why-quicksort-is-n-log-n

## OS
- Is a platform
- Linux
	- https://www.cs.uic.edu/~jbell/CourseNotes/OperatingSystems/
	- cgroups:
		- Linux kernel
		- Enable you to limit system resources to defined user groups or processes:
			- https://linuxhint.com/limit_cpu_usage_process_linux/
- Component:
	- Driver
	- In Unix, that interface is a file (or, more precisely, a file descriptor). A file is just an ordered sequence of bytes. Because that is such a simple interface, many different things can be represented using the same interface: an actual file on the filesystem, a communication channel to another process
	- File system:
		- Linux: Everything is a file, actually, a stream of bytes: https://unix.stackexchange.com/questions/225537/everything-is-a-file#:~:text=The%20%22Everything%20is%20a%20file%22%20phrase%20defines%20the%20architecture%20of,filesystem%20layer%20in%20the%20kernel.&text=In%20linux%20there%20are%207%20file%20types:
		- https://www.howtogeek.com/117939/htg-explains-what-everything-is-a-file-means-on-linux/
			- /proc:
			- /use:
			- /dev:
			- /etc: https://unix.stackexchange.com/questions/5665/what-does-etc-stand-for
	- Scheduler
		- Thread vs Proccess
		- Switch context
- Stuffs:
	- Abstractions (process, thread, file, socket, memory)
	- Mechanisms (create, schedule, open, write, allocate)
	- Policies (LRU, EDF).
	- State machine replication
- OS kernel vs User kernel
- Interupt Signals: http://faculty.salina.k-state.edu/tim/ossg/Introduction/OSworking.html
- Thread vs Proccess:
	- https://unix.stackexchange.com/questions/364660/are-threads-implemented-as-processes-on-linux
	- https://stackoverflow.com/a/809049/6085492
- Memory management:
	- Segmented Mem:
		- Segmented, Paged and Virtual Memory: https://www.youtube.com/watch?v=p9yZNLeOj4s
- Re-entrant function:
	- Function is called reentrant if it can be interrupted in the middle of its execution and then safely called again ("re-entered") before its previous invocations complete execution.
	- https://stackoverflow.com/questions/34758863/what-is-reentrant-function-in-c#:~:text=A%20re%2Dentrant%20function%20is,are%20safely%20encapsulated%20between%20threads.
- Kernel Re-entrant:
	- https://stackoverflow.com/questions/1163846/what-is-a-reentrant-kernel
- File:
	- an information container structured as a sequence of bytes
- Semaphores:
	- The down( ) method decreases the value of the semaphore. If the new value is less than 0, the method adds the running process to the semaphore list and then blocks (i.e., invokes the scheduler). The up( ) method increases the value of the semaphore and, if its new value is greater than or equal to 0, reactivates one or more processes in the semaphore list.
- Kernel control path:
	- denotes the sequence of instructions executed by the kernel to handle a system call, an exception, or an interrupt
- Security:
	- Buffer overflow exploits:
		- https://searchsecurity.techtarget.com/tip/1048483/Buffer-overflow-attacks-How-do-they-work

## Hardware
- CPU
	- cycles
	- cores
	- multithread
	- https://stackoverflow.com/questions/680684/multi-cpu-multi-core-and-hyper-thread
	- Cache coherence:
		- https://stackoverflow.com/questions/30958375/memory-barriers-force-cache-coherency
		- https://en.wikipedia.org/wiki/MESI_protocol
- RAM
- I/O Device
- Sequential vs Random IO: https://stackoverflow.com/questions/2100584/difference-between-sequential-write-and-random-write

## Distributed Things
 - https://www.youtube.com/watch?v=OKHIdpOAxto&list=PLeKd45zvjcDFUEv_ohr_HdUFe97RItdiB&index=10
- FAQ:
	- Should microservices share the same database? https://qr.ae/pGITa3
- Byzantine Problem:
	- http://www.cs.cornell.edu/courses/cs6410/2018fa/slides/18-distributed-systems-byzantine-agreement.pdf
- Pattern:
	- 10 Design patterns for DS:
		- https://ravindraelicherla.medium.com/10-design-patterns-every-software-architect-must-know-b33237bc01c2
	- Circuit Breaker:
		- https://martinfowler.com/bliki/CircuitBreaker.html
	- SAGA vs 2PC:
		- https://developers.redhat.com/blog/2018/10/01/patterns-for-distributed-transactions-within-a-microservices-architecture/
- Why distributed
	- It's inherently distributed
		- e.g. sending a message from your phone to your friend's phone.
	- Better reliability
		- even if one node fails, the system as a whole keeps functioning
	- Better performance
		- get data from a nearby node rather than one half way round the world
	- Solve bigger problems
		- e.g. huge amount of data, cannot fit in one node.
- Replication:
	- https://avikdas.com/2020/04/13/scalability-concepts-read-after-write-consistency.html#:~:text=Read%2Dafter%2Dwrite%20consistency%20is,the%20old%20bio%20shows%20up.
	- Purposes:
		- To keep data geographically close to your users (and thus reduce latency)
		- To allow the system to continue working even if some of its parts have failed (and thus increase availability)
		- To scale out the number of machines that can serve read queries (and thus increase read throughput)

	- Synchronous vs Asynchronous
	- Replication Lag symptom:
		- Reading your own writes (comment then refresh the page and that comment disapears)
		- Monotonic reads (the score is 3-3, then it becomes 3-2)
		- Consistent prefix reads (the answer appears first then the question)
	- Multi
- Partitioning:
	- For very large datasets or very high query throughput is not sufficient, we need to break the data up into _partitions_ (_sharding_).
	- Purpose:
		- Scalability
	- Partition of key-value data:
		- Our goal with partitioning is to spread the data and the query load evenly across nodes.
		- If partition is unfair, we call it _skewed_. It makes partitioning much less effective. A partition with disproportionately high load is called a _hot spot_.
		- The simplest approach is to assign records to nodes randomly. The main disadvantage is that if you are trying to read a particular item, you have no way of knowing which node it is on, so you have to query all nodes in parallel.
	- Partition by key range:
		- Assign a continuous range of keys, like the volumes of a paper encyclopaedia. Boundaries might be chose manually by an administrator, or the database can choose them automatically. On each partition, keys are in sorted order so scans are easy.
		- The downside is that certain access patterns can lead to hot spots.
	- Partitioning by hash of key
		- A good hash function takes skewed data and makes it uniformly distributed. There is no need to be cryptographically strong (MongoDB uses MD5 and Cassandra uses Murmur3). You can assign each partition a range of hashes. The boundaries can be evenly spaced or they can be chosen pseudorandomly (_consistent hashing_).
		- Unfortunately we lose the ability to do efficient range queries. Keys that were once adjacent are now scattered across all the partitions. Any range query has to be sent to all partitions.
	- Partitioning and secondary indexes
		- The situation gets more complicated if secondary indexes are involved. A secondary index usually doesn't identify the record uniquely. They don't map neatly to partitions.
	- Strategies for rebalancing:
		- How not to do it: Hash mod n. The problem with mod N is that if the number of nodes N changes, most of the keys will need to be moved from one node to another.
		- Fixed number of partitions: Create many more partitions than there are nodes and assign several partitions to each node. If a node is added to the cluster, we can steal a few partitions from every existing node until partitions are fairly distributed once again. The number of partitions does not change, nor does the assignment of keys to partitions. The only thing that change is the assignment of partitions to nodes. This is used in Riak, Elasticsearch, Couchbase, and Voldemport. You need to choose a high enough number of partitions to accomodate future growth. Neither too big or too small.
		- Dynamic partitioning. The number of partitions adapts to the total data volume. An empty database starts with an empty partition. While the dataset is small, all writes have to processed by a single node while the others nodes sit idle. HBase and MongoDB allow an initial set of partitions to be configured (pre-splitting).
		- Partitioning proportionally to nodes. Cassandra and Ketama make the number of partitions proportional to the number of nodes. Have a fixed number of partitions per node. This approach also keeps the size of each partition fairly stable.
	- Request routing:
		- Many distributed data systems rely on a separate coordination service such as ZooKeeper to keep track of this cluster metadata. Each node registers itself in ZooKeeper, and ZooKeeper maintains the authoritative mapping of partitions to nodes. The routing tier or the partitioning-aware client, can subscribe to this information in ZooKeeper. HBase, SolrCloud and Kafka use ZooKeeper to track partition assignment. MongoDB relies on its own config server. Cassandra and Riak take a different approach: they use a gossip protocol.
- Stateless vs stateful:
	- Cross-origin resource sharing (CORS): https://www.codecademy.com/articles/what-is-cors
	- JWT: 
		- bearer authentication (token authentication) is an open standard
		- https://jwt.io/introduction/
	- Oauth2:
		+ Used to grant authorizations for 3rd parties application, allow them to have some roles to interact with your own resources of a domain, through the tokens
- Visualization: http://thesecretlivesofdata.com/raft/
- CAP: 
	http://martin.kleppmann.com/2015/05/11/please-stop-calling-databases-cp-or-ap.html
	https://www.repository.cam.ac.uk/bitstream/handle/1810/267054/1509.05393v2.pdf?sequence=1&isAllowed=y
- CRDT: https://www.figma.com/blog/how-figmas-multiplayer-technology-works/?fbclid=IwAR3_bKwHI4-iY8T-iVSjlU3wQIxv0K7uRW2FaJkVcve6HsHjQrL91RB8DSI
- The log: https://engineering.linkedin.com/distributed-systems/log-what-every-software-engineer-should-know-about-real-time-datas-unifying
- Idempotent and Deterministic: 
	- Idempotency does not imply determinacy (as a function can alter state on the first call while being idempotent on subsequent calls), but all pure deterministic functions are inherently idempotent (as there is no internal state to persist between calls). Impure deterministic functions are not necessarily idempotent.
	- https://stackoverflow.com/questions/40296211/what-is-the-difference-between-an-idempotent-and-a-deterministic-function
- Consensus:
	- means deciding something in such a way that all nodes agree on what was decided, and such that the decision is irrevocable
	- Paxos protocol family:
		Too complicated
		https://medium.com/coinmonks/paxos-made-simple-3b83c05aac37
		https://www.youtube.com/watch?v=JEpsBg0AO6o&feature=youtu.be
	- Raft vs paxos:
		- An alternative version
		http://thesecretlivesofdata.com/raft/
		https://github.com/benbjohnson/thesecretlivesofdata
		https://blockonomi.com/paxos-raft-consensus-protocols/
		https://raft.github.io/#implementations
	- https://medium.com/datadriveninvestor/from-distributed-consensus-algorithms-to-the-blockchain-consensus-mechanism-75ee036abb65
- Consistency:
	- Distributed consistency is mostly about coordinating the state of replicas in the face of delays and faults
	- Level:
		- Linearizability:
			- It makes a database behave like a variable in a single threaded program
			- a.k.a strong consistency, immediate consistency, or external consistency
			- The basic idea is to make a system appear as if there were only one copy of the data, and all operations on it are atomic
			- There might be several requests waiting to be handled, but the datastore ensures that every request is handled atomically at a single point in time, acting on a single copy of the data, along a single timeline, without any concurrency.
			- Usage:
				- Locking and leader election
				- Constraints and uniqueness guarantees
					- such that if two people try to concurrently create a user or a file with the same name, one of them will be returned an error
- Concurrent:
	- Are concurrent if neither happens before the other (i.e., neither knows about the other)
	- Mean that the timeline branches and merges again—and in this case, operations on different branches are incomparable
- Decentralized: 
	https://decentralizedthoughts.github.io/
	https://medium.com/distributed-economy/what-is-the-difference-between-decentralized-and-distributed-systems-f4190a5c6462
- State machine replication:
	- The consensus algorithm must ensure that if any state machine applies set x to 3 as the nth command, no other state machine will ever apply a different nth command. As a result, each state machine processes the same series of commands and thus produces the same series of results and arrives at the same series of states.
	- In ZaloPay, the service (direct-discount, voucher,...) acts like a logic layer, not contains a services state (which is stored in the shared resources like MySQL, Cassandra, Redis, Kafka). More details in: https://en.wikipedia.org/wiki/State_machine_replication
	- Deterministic: 
	- Architecture: https://www.google.com/search?q=state+machine+replication&safe=active&sxsrf=ACYBGNTwIx2ukCcZS90sp1iu_kRmdYLoCQ:1579443308842&source=lnms&tbm=isch&sa=X&ved=2ahUKEwjt6Pbq7I_nAhWF7nMBHUTMBXAQ_AUoAXoECBAQAw&biw=1440&bih=724#imgrc=_DNfSp4Zs1WPNM:
- Flow of control: https://www.youtube.com/watch?v=EEEGBwEA8yA
- Distributed transaction:
	- SEATA:
		- https://github.com/seata/seata
- Synchronous Versus Asynchronous Networks:
	- Synchronous: When you make a call over the telephone network, it establishes a circuit: a fixed, guaranteed amount of bandwidth is allocated for the call, along the entire route between the two callers.
		- even as data passes through several routers, it does not suffer from queueing, because the 16 bits of space for the call have alreadybeen reserved in the next hop of the network. And because there is no queueing, the maximum end-to-end latency of the network is fixed. We call this a bounded delay.
- Fencing tokens:
	- For getting a distributed lock
- System Models:
	- Consisting of:
		- Network behaviour (e.g. message loss)
		- Node behaviour (e.g. crash)
		- Timing behaviour (e.g. latency)
	- NETWORK behaviour:
		- Reliable links:
			- A message is received if and only if it is sent. Messages maybe reordered.
		- Fair-loss links:
			- Messages may be lost, duplicated, or reordered.
			- If you keeep trying, a message will eventually gets through.
			- Can be made to "Reliable links" by using dedup and retry mechanism.
		- Arbitrary links
			- A malicious adversary may interfere with messages (modify, drop, spoof, replay, eavesdrop)
			- Can be made to "Fair-loss links" with TLS enabled.
	- NODE behaviour:
		- Crash-stop (fail-stop):
			- A node is faulty if is crashed (at any moment).
			- After crashing, it stops executing forever.
		- Crash-recovery (fail-recovery):
			- A node may crash at any moment, losing all of its in-memory state.
			- It may resume executing sometime later.
		- Byzantine (fail-arbitrary):
			- If it deviates from the algorithm.
			- Faulty nodes may do anything, including crashing or malicious behaviour.
	- Synchrony (timing) assumptions:
		- Synchronous:
			- Message latency no greater than a known upper bound. Node executes algorithm at a known speed.
		- Partially 
			- The system is Synchronous for some finite periods of time, synchronous otherwise.
		- Asynchronous:
			- Messages can be delayed arbitrarily.
			- Node can be paused execution arbitrarily.
				- OS scheduling issues
				- GC pauses
				- Page faults, swaping memory
			- Not timing guarantees at all.
- Clock synchronisation:
	- Network time protocol: NTP
	- Physical clock: count number seconds elapsed
		- Monotonic clock: 
			- Time since a fixed date (e.g. 1 Junauary 1970 epoch)
			- May suddenly move forwards or backwards (NTP stepping)
		- Time of day clock: 
			- Time since arbitrary point (e.g. when a machine booted up)
			- Always moves forwards
	- Logical clock: count number of events occured
		- https://www.youtube.com/watch?v=x-D8iFU1d-o&list=PLeKd45zvjcDFUEv_ohr_HdUFe97RItdiB&index=11
		- Is used to capture causal dependencies
		- Lamport clocks:
		- Vector clocks:
- Broadcast ordering:
- Ordering: https://scattered-thoughts.net/writing/causal-ordering/#:~:text=A%20%2D%3E%20B%20(event%20A,causally%20ordered%20before%20event%20B)&text=We%20are%20used%20to%20thinking,or%20B%20%2D%3E%20A).
	- We are used to thinking of ordering by time which is a total order - every pair of events can be placed in some order. In contrast, causal ordering is only a partial order - sometimes events happen with no possible causal relationship i.e. not (A -> B or B -> A).



## Architecture
- Service mesh
- Event-Driven Architecture:
	- https://www.confluent.io/blog/event-sourcing-cqrs-stream-processing-apache-kafka-whats-connection/#:~:text=CQRS%20involves%20splitting%20an%20application,gets%20information%20without%20changing%20state.&text=The%20way%20event%20sourcing%20works,event%20log%20or%20Kafka%20topic.
	- https://www.youtube.com/watch?v=STKCRSUsyP0
	- 4 patterns:
		- Event notification
		- Event-carried state transfer
		- Event Sourcing
		- CQRS


## Beautiful Tool - Mindset
- Kafka:
	- Compare with RabbitMQ: https://betterprogramming.pub/rabbitmq-vs-kafka-1779b5b70c41
	- https://data-flair.training/blogs/kafka-architecture/
	- https://medium.com/streamthoughts/apache-kafka-rebalance-protocol-or-the-magic-behind-your-streams-applications-e94baf68e4f2
        - Perfect explanation: https://medium.com/swlh/apache-kafka-in-a-nutshell-5782b01d9ffb
- Another perfect one: https://medium.com/better-programming/thorough-introduction-to-apache-kafka-6fbf2989bbc1
- Container and Orchestration
	- Docker
	- K8S:
		- https://thenewstack.io/how-do-applications-run-on-kubernetes/
- Jenkins CI/CD
- Zoo Keeper:
	- Is a distributed coordination service
	- Leader election
	- Configuration management
	- Node coordination


## Experience
- Life:
	- https://medium.com/kaizen-habits/6-better-things-to-do-after-6-p-m-thatll-enrich-your-life-6cf56f37618b
- Trade off: https://martinfowler.com/articles/microservice-trade-offs.html
- Mistakes:
	- https://towardsdatascience.com/10-things-youre-doing-wrong-in-java-7608e2f050c7
- Micro-services:
	- https://www.youtube.com/watch?v=GBTdnfD6s5Q
	- https://medium.com/swlh/stop-this-microservices-madness-8e4e0695805b
	- Use this as a means to obtain a disired outcome rather than for the sake of using a new technology
	- Shouldnot be a default option. If you think a service architecture could help, just try it with one of the modules from a very simple monilith typology and let it involve from there
	- The top 3 reasons for using microservices are:
		- Zero-downtime independent deployability
		- Isolation of data and of processing around that data
		- Refect the organizational structure
	- Strive for independent deployment because:
		- It's easier to limit the impact of each release when using microservices
		- As a team size increases it gets exponentially harder to coordinate a deployment
	- We tend to violate monolith architecture by no respecting the modules. Breaking them into services makes it harder to do so
	- A lot of the complexity of breaking complex systems lies tha data. After extracting the microservice you need to understand what part of the old database this system uses.
	- There has to be a willingness to change as an organization if you want to make the most out of using microservices
