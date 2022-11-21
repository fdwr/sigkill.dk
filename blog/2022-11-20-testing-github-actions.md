---
title: A quick note on testing custom GitHub Actions
description: You can import the action in its own test suite to test it.
---

I was working on a (very simple) GitHub Action [this
one](https://github.com/diku-dk/install-futhark) and was uncertain how
to test it.  It turns out the obvious solution works: create a
workflow file as usual in the action repository itself which then has
a step where it *uses itself by name* and specifies `HEAD` as the
revision.  Example:

    steps:
      - id: test
        uses: diku-dk/install-futhark@HEAD

It's sort of obvious why it works, which I always like, but I couldn't
find this trick documented anywhere.  [The
tutorial](https://docs.github.com/en/actions/creating-actions/creating-a-composite-action)
suggests creating a release of the action and testing it from another
repository, which is of course horribly unergonomic.  I don't know if
the above can be improved (it doesn't handle branches for example),
but it was good enough for simple things.
