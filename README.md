collapse
========

This utility exists to be placed inside an inotifywait loop.
Frequently, all you care about is that a change has happened in
your project, and you have some app-specific way of determining
what needs to be done (whether that is make, cabal, or something
else.)

What you _do_ need is to only have one notification come through.
This is what collapse is for.

It is a utility I wish did not have to exist: if you find a way
of doing it using available bash tools, please let me know and
I will happily junk this.


Usage
=====

I use this with Haskell projects.


given a Haskell project with a cabal test Hspec target named "tests", I run this
at the top level:

```
 ((inotifywait -m -r .  -e CLOSE_WRITE |grep --line-buffered '\.hs$'   | grep -v --line-buffered flymake | collapse | while read x; do 
    echo ":reload\n:main --rerun" ; 
  done) & 
  export IJOB=$!  ;  
  cat -;  
  pkill -TERM -P $IJOB)  | cabal repl tests
```

Along with some forthcoming changes to hspec to do with behaviour of
main --rerun when tests go from failing to correct, this will run only
the currently failing tests. It is also very fast, as an interpreter
stays open, meaning no time is taken in running cabal setup code or
linking.

