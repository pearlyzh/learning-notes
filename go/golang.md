# Go

## Characteristics
- Naturally non-blocking
- Compiled directly to machine code
- M:N Scheduling Model
- Is a divergence language 

## Goroutine
- https://medium.com/@riteeksrivastava/a-complete-journey-with-goroutines-8472630c7f5c
- https://wwws.ardanlabs.com/blog/2018/08/scheduling-in-go-part1.html
- https://wwws.ardanlabs.com/blog/2018/08/scheduling-in-go-part2.html
- https://raksyll.osrg/scheduler/

### Compare tso Green Thread
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