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

## Ignoring upper bounds

Put this in `cabal.project`:

```
allow-newer: hashable:ghc-bignum
```

This lets `hashable` use a newer `ghc-bignum`.

## Using packages from a different version of GHC in Nix

Use e.g. ``pkgs.haskell.packages.ghc921.ormolu_0_4_0_0`` where
``pkgs`` is the Nixpkgs package set.  You don't need the version
number on the package itself; but if you're using a nonstandard
compiler version, you're probably trying to use a newer version of the
package than is the default in Nixpkgs.
