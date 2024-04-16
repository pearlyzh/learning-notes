## Fitness function
 - How can architects ensure that the design principles they define become reality if they aren't the ones to implement them? -> architecture governance
 - architectural fitness function: any mechanism that performs an objective integrity assessment of some architecture characteristic or combination of architecture characteristics.
 - architects may also want to validate the macro structure of the architecture as well as the micro, for example, when designing a layered architecture: https://www.archunit.org/userguide/html/000_Index.html#_asserting_architectural_constraints
 - While most fitness functions should be automated and run continually, some will necessarily be manual. A manual fitness function requires a person to handle the validation

# Coupling versus Cohesion
 - https://itnext.io/complexity-coupling-and-cohesion-a74db76c968d

## Colloquial definitions
 - Service: A service is a cohesive collection of functionality deployed as an independent executable 
 - Coupling: Two artifacts (including services) are coupled if a change in one might require a change in the other to maintain proper functionality
 - Component: An architectural building block of the application that does some sort of business or infrastructure function, usually manifested through a package structure (Java), namespace (C#), or a physical grouping of source code files within some sort of directory structure.
 - Synchronous communication: Two artifacts communicate synchronously if the caller must wait for the response before proceeding.
 - Asynchronous communication: Two artifacts communicate asynchronously if the caller does not wait for the response before proceeding. Optionally, the caller can be notified by the receiver through a separate channel when the request has completed.
 - Orchestrated coordination: A workflow is orchestrated if it includes a service whose primary responsibility is to coordinate the workflow.
 - Choreographed coordination: A workflow is choreographed when it lacks an orchestrator; rather, the services in the workflow share the coordination responsibilities of the workflow.
 - Atomicity: A workflow is atomic if all parts of the workflow maintain a consistent state at all times
 - Contract: We use the term contract broadly to define the interface between two software parts, which may encompass method or function calls, integration architecture remote calls, dependencies, and so on. Anywhere two pieces of software join, a contract is involved