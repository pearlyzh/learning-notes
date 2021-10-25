# Backstory
- Prior to TCP/IP, it was the era of circuit switching, which
required dedicated connection between two parties for communication
to happen. TCP/IP came up with its packet switching design, which was
more open and peer-to-peer with no need to preestablish a dedicated line
between parties.
- When the Internet was made accessible to the public through the
World Wide Web (WWW) in the early 1990s, it was supposed to be
more open and peer-to- peer. This is because it was built atop the open
and decentralized TCP/IP.
- Slowly and gradually, people get used to
what technology offers. People are just fine if an international transaction
takes days to settle, or it is too expensive, or it is less reliable.
### Bank transaction
- Technology enabled someone from India to make a monetary
transaction with someone in the United Kingdom, but with some cost.
- It takes days to settle such transactions and is expensive as well. A bank was
always needed to impose trust and ensure security for such transactions
between two or more parties
- What if technology could enable trust and security without these intermediary and centralized systems? Blockchain proves to be that missing piece of the Internet revolution puzzle

## What the hell is it?
- It is a system of records to transact value (**NOT JUST MONEY!**) in a peer-to-peer fashion.
- There is no need for a trusted intermediary such as banks, brokers, or other escrow services to serve as a trusted third party.
- It is a shared, decentralized, and open ledger of transactions. This ledger database is replicated across a large number of nodes.
- Just the way TCP/IP was designed to achieve an open system, blockchain technology was designed to enable true decentralization. In an effort to do so, the creators of Bitcoin open-sourced it so it could inspire many decentralized applications.
- Every node on the blockchain network has an identical copy of the
blockchain. The other part of a block is the "body content" that has a
validated list of transactions, their amounts, the addresses of the parties
involved, and some more details. So, given the latest block, it is feasible to
access all the previous blocks in a blockchain

# Centralized vs. Decentralized Systems
- Whether a system is centralized or decentralized, it can still be
distributed.
- **Technical Architecture**: A system can be centralized or decentralized
from a technical architecture point of view.
- **Political perspective**: This perspective indicates the control that an
individual, or a group of people, or an organization as a whole has on a
system. If the computers of the system are controlled by them, then the
system is naturally centralized
- **Logical perspective**: A system can be logically centralized or
decentralized based on how it appears to be, irrespective of whether it
is centralized or decentralized technically or politically
- The objective of blockchain was to enable decentralization. So, it is
architecturally decentralized by design. Also, it is
decentralized from a political viewpoint, as nobody
controls it. However, it is logically centralized, as there
is one common agreed state and the whole system
behaves like a single global computer.

# Layers of Blockchain
## Application Layer
- This is the layer where you code up the desired functionalities
and make an application out of it for the end users. It usually involves
a traditional tech stack for software development such as client-side
programming constructs, scripting, APIs, development frameworks, etc.

## Execution Layer
- is where the executions of instructions ordered by the
Application Layer take place on all the nodes in a blockchain network. 
- The instructions could be simple instructions or a set of multiple instructions in the form of a **smart contract**
- Ethereum and Hyperledger, on the other hand, allow complex executions. Ethereum’s code or its smart contracts written in solidity gets compiled to Bytecode or Machine Code that gets executed on its own Ethereum Virtual Machine.

## Semantic Layer
- Whether one is spending a legitimate transaction, whether it is a double-spend attack, whether one is authorized to make this transaction, etc., are validated in this layer.
- To be able to spend a Bitcoin, you have to consume one or more previous transactions and there is no notion of Accounts. This means that when someone makes a transaction, they use one of the previous transactions where they had received at least the amount they are spending now
- Ethereum, on the other hand, has the system of Accounts. This means that the account of the one making the transaction and that of the one receiving it both get updated.
- In this layer, the rules of the system can be defined, such as data
models and structures. The data structures such as the Merkle tree are defined in this layer with the Merkle root in the block header to maintain a relation
between the block headers and the set of transactions in a block

## Propagation Layer
- Is the peer-to-peer communication layer that allows the nodes to discover each
other, and talk and sync with each other with respect to the current state of the network.
- When a transaction is made, we know that it gets broadcast to
the entire network

## Consensus Layer
- The primary purpose of this layer is to get all the nodes to agree
on one consistent state of the ledger.
- There are many different variants of consensus protocols such as Proof of Stake (PoS), deligated PoS (dPoS), Practical Byzantine Fault Tolerance (PBFT), etc

# How it works
Technically, blockchain is a brilliant amalgamation of the concepts from **cryptography**, **game theory**, and **computer science** engineering.

## Cryptography
- Confidentiality: Only the intended or authorized
recipient can understand the message. It can also be
referred to as privacy or secrecy.
- Data Integrity: Data cannot be forged or modified by
an adversary intentionally or by unintended/accidental
errors. Though data integrity cannot prevent the
alteration of data, it can provide a means of detecting
whether the data was modified.
- Authentication: The authenticity of the sender is
assured and verifiable by the receiver.
- Non-repudiation: The sender, after sending a message,
cannot deny later that they sent the message. This
means that an entity (a person or a system) cannot
refuse the ownership of a previous commitment or an
action.

### Symmetric Key Cryptography
- **Kerckhoff’s principle** states that a cryptosystem should be secured even if
everything about the system is publicly known, except the key. Also, the
general assumption is that the message transmission channel is never
secure, and messages could easily be intercepted during transmission
- **m ⊕ k = c and c ⊕ k = m**
- Stream Ciphers vs. Block Cipher
    - Stream ciphers convert one symbol of plaintext into one symbol of ciphertext. This means that the encryption is carried out one bit or byte of plaintext at a time.
        - For such a system to remain secure, the pseudorandom keystream generator has to be **secure and unpredictable**.
        - The most widely used stream cipher is RC4 (Rivest Cipher 4) for various protocols such as SSL, TLS, and Wi-Fi WEP/WPA etc. It was revealed that there were vulnerabilities in RC4, and it was recommended by Mozilla and Microsoft not to use it where possible.
    - Block cipher on the other hand is based on the idea of partitioning
the plaintext into relatively larger blocks of fixed-length groups of bits,
and further encoding each of the blocks separately using the same key
    - DES:
        - The 56-bit key length was susceptible to brute force attack and the S-boxes used for substitution in each round were also prone to cryptanalysis attack because of some inherent weaknesses. Because of these reasons, the Advanced Encryption Standard (AES) has replaced the DES to the extent possible.
        - It has been proven that it is vulnerable to brute force attack and could be broken in less than a day. Given Moore’s Law, it could be broken a lot quicker in the future, so its usage has been deprecated quite a bit because of the key length
    - AES:
        - Solve DES limitations
        - It had the limitation of long processing time. Assume that you are sending just a 1 megabyte file (8388608 bits) by encrypting with AES. Using a 128-bit AES algorithm, the number of steps required for this encryption will be 8388608/128 = 65536
- Challenges in Symmetric Key
    - The key must be shared by the sender and receiver before any communication. It requires a secured key establishment mechanism in place.
    - The sender and receiver must trust each other, as they use the same symmetric key. If a receiver is hacked by an attacker or the receiver deliberately shared the key with someone else, the system gets compromised.
    - A large network of, say, n nodes require key n(n–1)/2 key pairs to be managed.
    - It is advisable to keep changing the key for each communication session.
    - Often a trusted third party is needed for effective key management, which itself is a big issue.
### Cryptographic Hash Functions
- It is a one-way function that converts input data of arbitrary length and produces a fixed-length output.
- The output is usually termed "hash value" or "message digest."
- Collision resistance: It implies that it is infeasible to
find two different inputs, say, X and Y, that hash to the
same value.
- Preimage resistance: This property means that it is
computationally impossible to invert a hash function; i.e., finding the input X from the output H(X) is infeasible. Therefore, this property can also be called "hiding" property.
- One of the oldest hash functions or compression function is the MD4
hash function. It belongs to the message digest (MD) family
- Another such hash function family is the Secure Hash Algorithm
(SHA) family. There are basically four algorithms in this family, such as
SHA-0, SHA-1, SHA-2, and SHA-3

### Asymmetric key cryptography
- Also known as "public key cryptography," is a revolutionary concept introduced by Diffie and Hellman. With this technique, they solved the problem of key distribution in a symmetric cryptography system by introducing digital signatures.
    - **c = E[PukBob, *E(PrkAlice, m)*]**
    - **m = D[PukAlice, *D(PrkBob, c)*]**
#### RSA
- RSA algorithm, named after Ron Rivest, Adi Shamir, and Leonard Adleman
is possibly one of the most widely used cryptographic algorithms. It was the foundation to generate asymmetric keys.

#### Digital Signature Algorithm (DSA)
- The DSA was designed by the NSA as part of the Digital Signature Standard
(DSS) and standardized by the NIST.
- A typical DSA scheme consists of three algorithms: (1) key generation,
(3) signature generation, and (3) signature verification.
- Achieve:
    - Authenticity: Signed by private key and verified by
    public key
    - Data integrity: Hashes will not match if the data is
    altered.
    - Non-repudiation: Since the sender signed it, they
    cannot deny later that they did not send the message.

#### Elliptic Curve Cryptography
