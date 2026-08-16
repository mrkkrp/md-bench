# Benchmark comparing markdown libraries

The benchmark renders a real markdown document (the README of
[`megaparsec`](https://github.com/mrkkrp/megaparsec), about 19 KB) to HTML
with each library, measuring the whole job: parsing plus rendering.

See: https://github.com/mmark-md/mmark#performance

## Running it

The `cabal.project` file points at a checkout of `mmark` next to this one,
so that the unreleased version can be measured. Adjust or remove that entry
to benchmark the released version instead.

```console
$ cabal bench bench-speed
$ cabal bench bench-memory
```

## License

Copyright © 2017–present Mark Karpov

Distributed under BSD 3 clause license.
