# Go

## Characteristics
- Naturally non-blocking
- Compiled directly to machine code
- M:N Scheduling Model
- Is a divergence language 

## Memory management
- https://appliedgo.com/blog/how-to-do-escape-analysis

## Goroutine
- https://medium.com/@riteeksrivastava/a-complete-journey-with-goroutines-8472630c7f5c
- https://wwws.ardanlabs.com/blog/2018/08/scheduling-in-go-part1.html
- https://wwws.ardanlabs.com/blog/2018/08/scheduling-in-go-part2.html
- https://raksyll.osrg/scheduler/
- Beautiful ideas:
	- https://www.youtube.com/watch?v=YHRO5WQGh0k
- https://medium.com/a-journey-with-go/go-goroutine-os-thread-and-cpu-management-2f5a5eaf518a
- https://betterprogramming.pub/deep-dive-into-concurrency-of-go-93002344d37b

### Compare to Green Thread
- https://sofstwareengineering.stackexchange.com/questions/222642/are-go-langs-goroutine-pools-just-sgreen-threads

## Pass by Value
 - Pass by referrence: https://www.ibm.com/docs/en/zos/2.4.0?topic=calls-pass-by-reference-c-only
 - Snippets:
```
type Person struct {
	firstName string
	lastName  string
}

// Pass by value of a pointer, like Java
func changeName(p *Person) {
	p.firstName = "Bob"
}

func main() {
	person := Person {
		firstName: "Alice",
		lastName:  "Dow",
	}

	changeName(&person)
	fmt.Println(person) // Output:Bob Dow
}

```

## Goroutines are Coroutines
- https://stackoverflow.com/questions/37469995/goroutines-are-cooperatively-scheduled-does-that-mean-that-goroutines-that-don

## Tips:
- Addressable: https://stackoverflow.com/a/30745101/6085492
- Make vs New: https://stackoverflow.com/questions/9320862/why-would-i-make-or-new

# Go Journey
## Build
- `go mod download` vs `go mod tidy`: go mod download is downloading all of the modules in the dependency graph, which it can determine from reading only the go.mod files. It doesn't know which of those modules are actually needed to satisfy a build, so it doesn't pull in the checksums for those modules (because they may not be relevant). go mod tidy has to walk the package graph in order to ensure that all imports are satisfied. So it knows, for a fact, without doing any extra work, that the modules it walks through are needed for a go build in some configuration.
- `google.golang.org/protobuf/cmd/protoc-gen-go` vs `google.golang.org/grpc/cmd/protoc-gen-go-grpc`: 