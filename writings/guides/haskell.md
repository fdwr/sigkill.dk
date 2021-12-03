# Various Haskell things that I can never remember

## Making Cabal fetch a dependency from a version control repository

[Upstream documentation
here.](https://cabal.readthedocs.io/en/3.6/cabal-project.html#specifying-packages-from-remote-version-control-locations)

TLDR: put this in `cabal.project`:

```
source-repository-package
    type: git
    location: https://github.com/hvr/HsYAML.git
    tag: e70cf0c171c9a586b62b3f75d72f1591e4e6aaa1
```

The `tag` is the Git commit.
