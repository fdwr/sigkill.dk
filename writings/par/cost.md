---
title: Parallel Cost Models
---

# Parallel Cost Models

A *cost model* is a framework used to describe the *cost* of a program
or algorithm, often measured in the number of instructions executed or
steps taken.  Often we describe the cost in using [big-O
notation](https://en.wikipedia.org/wiki/Big_O_notation). For example,
we may say that merge sort requires *O(n log(n))* comparisons to sort
a sequence.  Most programmers have some sort of informal cost model
that they use for reasoning about the performance of their program.
Usually this is just counting the "steps" taken.  Sometimes we
acknowledge that some steps are more expensive than others (e.g. a
memory access compared to an integer addition), but often we do not.
Unfortunately, counting the number of steps is not a good way to
describe a *parallel* algorithm.  This is because we are not just
interested in the total number of steps, but also how well the
algorithm might take advantage of a parallel computer.  To describe
such algorithms, we use a *parallel cost model*.

Consider adding together the integers from 1 to 9, both inclusive.  If
we simply add together the numbers in order starting from 1, the
dependency graph of the intermediates and final result looks like this:

```
1 2 3 5 6 7 8 9
 \| | | | | | |
  3 | | | | | |
   \| | | | | |
    6 | | | | |
     \| | | | |
     11 | | | |
       \| | | |
       17 | | |
         \| | |
         24 | |
           \| |
           32 |
             \|
             41
```

This involves a total of 7 additions.  If we counted from 1 to *n*, we
would need *n-1* additions.  We say that this algorithm has a total
*work* of *O(n)*.  The work is just the count of all steps, exactly as
we are used to quantify the performance of algorithms.  However, in a
parallel cost model we also measure the *span* (sometimes called
*depth*).  The span is the length of the longest path in the
dependency tree from the final result to an input value.  In this
case, the span is 7.  Or, generalising, the span is *O(n)*.

But now consider if instead of adding the numbers from left to right,
we repeatedly added them pairwise, making our dependency graph a
balanced tree structure:

```
1 2 3 5 6 7 8 9
\ / \ / \ / \ /
 3   8   13  17
  \  /    \  /
   11      30
     \    /
      \  /
       41
```

There are still 7 additions, and the work is still *O(n)*.  But now
the longest path has only 3 edges, and generalising to summing *n*
numbers, we can show that the span is *O(log2(n))*.  Imagine that we
were executing this on a parallel computer with an unlimited amount of
processors.  At each step of the parallel computer, we could evaluate
*every* node in the dependency graph for which its predecessors have
already been evaluated.  In the tree above, it would correspond to
evaluating an entire "level" of the summation tree for every step.  On
such a computer, evaluation would require only 3 steps - or for adding
*n* numbers, *O(log2(n))* steps.  *The span tells us how many steps
the algorithm would need on an infinitely parallel computer!*
(Asymptotically.)

Of course, infinitely parallel computers do not exist.  However,
Brent's Lemma (see references) tells us that we can simulate a machine
with *x* processors on a machine with only *y* processors at a cost
proportional to *x/y*.  Essentially, the cost is proportional to the
amount of "missing" parallelism, relative to what the algorithm could
exploit.  This means that the span is a useful way of quantifying the
parallel scalability of an algorithm, even though we will only ever
execute it on finitely parallel computers.

## Work Effiency

If a parallel algorithm has the same asymptotic work as the best known
sequential algorithm, then we say that it is *work-efficient*.  For
example, the [Hillis-Steele algorithm for parallel prefix
sum](https://en.wikipedia.org/wiki/Prefix_sum#Algorithm_1:_Shorter_span,_more_parallel)
requires *O(n log(n))* work, while a sequential algorithm requires
*O(n)* work.  For prefix sums, a [work-efficient algorithm is
known](https://en.wikipedia.org/wiki/Prefix_sum#Algorithm_2:_Work-efficient),
but there are problems for which no work-efficient parallel algorithm
is known.

A parallel algorithm that is not work efficient can still be
practically useful.  Perhaps the ability to exploit a parallel
computer outweighs the wasted work.  But eventually, for sufficiently
large input, the best sequential algorithm will outperform a parallel
algorithm that is not work-efficient.

## References

* [Programming Parallel
  Algorithms](http://www.cs.cmu.edu/~scandal/cacm.html), by Guy
  Blelloch (1996)

* [The Parallel Evaluation of General Arithmetic
  Expressions](https://maths-people.anu.edu.au/~brent/pub/pub022.html),
  by Richard P. Brent (1974)
