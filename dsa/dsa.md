# Data Structures and Algorithms

## Back Tracking
- A general approach to backtracking questions in Java (Subsets, Permutations, Combination Sum, Palindrome Partitioning): https://leetcode.com/problems/subsets/discuss/27281/A-general-approach-to-backtracking-questions-in-Java-(Subsets-Permutations-Combination-Sum-Palindrome-Partitioning)

## Graph theory
- BFS vs DFS: https://stackoverflow.com/questions/3332947/when-is-it-practical-to-use-depth-first-search-dfs-vs-breadth-first-search-bf 

## Probabilistic
- Hyperloglog
- Count min sketch
- Bloom filter: 
    - https://towardsdatascience.com/system-design-bloom-filter-a2e19dcd4810
- Skip list:
    - https://www.cs.cmu.edu/~ckingsf/bioinfo-lectures/skiplists.pdf
## Disruptor
- Ring buffer
- Mechanical Sympathy: 
    - https://www.youtube.com/watch?v=Qho1QNbXBso
    - If you want performance, don's share cache line
- Key concepts:
    - https://itnext.io/understanding-the-lmax-disruptor-caaaa2721496
    - The LMAX Disruptor solution is faster than Java ArrayBlockingQueue and LinkedBlockingQueue.
    - A mechanical sympathy (good understanding of the underlying hardware) should make you a better developer.
    - Sharing memory between threads is prone to problems, you need to do it carefully.
    - CPU caches are faster than main memory but a bad understanding of how they work (cache lines etc.) can ruin your performance.
## Data storage:
- https://medium.com/databasss/on-disk-io-part-3-lsm-trees-8b2da218496f

## Tree:
- Traversal:
    - In-order: Left - Root- Right
    - Pre-order: Root - Left - Right
    - Post-order: Left - Right - Root

## Big O:
- Common runtimes example: https://www.bigocheatsheet.com/
- In plain English: https://stackoverflow.com/questions/487258/what-is-a-plain-english-explanation-of-big-o-notation

## Sorting 
- Quick-sort: https://stackoverflow.com/questions/10425506/intuitive-explanation-for-why-quicksort-is-n-log-n

## Comprehensive Guide
- https://leetcode.com/discuss/general-discussion/494279/comprehensive-data-structure-and-algorithm-study-guide

## Daily life
- Elevator Algorithm: https://softwareengineering.stackexchange.com/questions/331692/what-algorithm-is-used-by-elevators-to-find-the-shortest-path-to-travel-floor-or

## Monotonic Stack
- https://labuladong.gitbook.io/algo-en/ii.-data-structure/monotonicstack
- https://leetcode.com/problems/daily-temperatures/submissions/

## 2D array
 - m as the number of rows, n as the number of cols, so if we need to find the ith-indexed (0 indexed) element in the array, use this formula: row-index = i / n, col-index = i % n
### Searching
 - For peak element, we can do binary search so that if a[mid] < a[mid + 1], we know that the peak should be on the right side, and vice versa. If we are using the formula mid = left + (right - left) / 2, then we need to be careful to do comparison between mid and its neighbour, in this case, nums[mid] should be compare to nums[mid + 1]. Because if the array (or subarray) has just 2 elements, we will not end up comparing nums[mid] with an outsider element which is nums[mid - 1]

### String to Int
 - We need to be aware of the MAX/MIN integer check when we are building the result. This is the condition that we know the result will anyway be bigger or equal MAX_INT or smaller or equal MIN_INT:
    - The result is bigger than the MAX_INT / 10 **or** The result is equals to MAX_INT / 10 **but** the next number to be added to the result is bigger than or equals to the last number of MAX_INT(7). For MIN_INT, the next number should be smaller than 8

### Tree level traversal
For a fuIl binary tree, if parent node has position = i, then left-child's position = 2i and right-child's position = 2i + 1

### FP
https://qr.ae/pvd0we