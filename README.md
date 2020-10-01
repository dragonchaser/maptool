# MAPTOOL

Maptool is a small tool to generate nethack-style ASCII dungeons.
It is a WIP at the moment so expect breaking changes and bugs.

**LICENSE:** MIT see [LICENSE](https://github.com/dragonchaser/maptool/blob/master/LICENSE) file in this repository.

## GEM usage

```
require 'maptool'

#Default value from CLI

cols = (args[:cols] || 10)
rows = (args[:rows] || 10)
empty_weight = (args[:prob] || 0.02)
precision = (args[:prec] || 2)
precision = 14 if precision > 14
precision = 2 if precision < 2

# cols, rows, empty_weight, and precision are required
mt = Maptool.new(cols, rows, empty_weight, precision, args[:border], args[:verbose], args[:superverbose])
mt.run!
mt.print_map
```

## CLI usage

```
Usage: ./maptool.rb [options]
    -r, --rows=ROWS                  Dungeon rows (default: 10)
    -c, --cols=COLS                  Dungeon cols (default: 10)
    -e, --empty=PROBABILTY           Probablility of creating an empty tile (default: 0.02)
    -p, --precision=PRECISION        Precision used for calculationg weighted probablities with -e (default: 2, will resort to defaults if <2 || > 14)
    -b, --border                     Print tile border (default: false)
    -v, --verbose                    Verbose mode
    -V, --superverbose               Super verbose mode
    -h, --help                       Prints this help
```

## Web Interface usage
To start the server, run `ruby app.rb` To view the interface, navigate to `localhost:4567`

## examples

### with border

```
.......................................
.            .            .    |~~|    .
.            .            . +--+~~+--+ .
.            .            . |~~~~~~~~| .
.    +-------.------------.-+~~~~~~~~+-.
.    |~~~~~~~.~~~~~~~~~~~~.~~~~~~~~~~~~.
.    |~~~~~~~.~~~~~~~~~~~~.~~~~~~~~~~~~.
.    |~~+----.------------.-+~~~~~~~~+-.
.    |~~|    .            . |~~~~~~~~| .
.    |~~|    .            . +--+~~+--+ .
.    |~~|    .            .    |~~|    .
........................................
.    |~~|    .            .    |~~|    .
.    |~~|    .            .    |~~|    .
.    |~~|    .            .    |~~|    .
.----+~~+----.------------.----+~~+----.
.~~~~~~~~~~~~.~~~~~~~~~~~~.~~~~~~~~~~~~.
.~~~~~~~~~~~~.~~~~~~~~~~~~.~~~~~~~~~~~~.
.----+~~+----.----+~~+----.----+~~+----.
.    |~~|    .    |~~|    .    |~~|    .
.    |~~|    .    |~~|    .    |~~|    .
.    |~~|    .    |~~|    .    |~~|    .
........................................
.    |~~|    .    |~~|    .    |~~|    .
.    |~~|    .    |~~|    .    |~~|    .
.    |~~|    .    |~~|    .    |~~|    .
.    |~~|    .    |~~|    .    |~~|    .
.    |~~|    .    |~~|    .    |~~|    .
.    |~~|    .    |~~|    .    |~~|    .
.    |~~|    .    |~~|    .    |~~|    .
.    |~~|    .    |~~|    .    |~~|    .
.    |~~|    .    |~~|    .    |~~|    .
.    |~~|    .    |~~|    .    |~~|    .
........................................
```

### without border

```
------------            ------------
~~~~~~~~~~~~            ~~~~~~~~~~~~
~~~~~~~~~~~~            ~~~~~~~~~~~~
----+~~+----            ----+~~+----
    |~~|                    |~~|
    |~~|                    |~~|
    |~~|                    |~~|
    |~~|        |~~|        |~~|
    |~~|     +--+~~+--+  +--+~~+--+
    |~~|     |~~~~~~~~|  |~~~~~~~~|
----+~~+-----+~~~~~~~~+--+~~~~~~~~+-
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
----+~~+-----+~~~~~~~~+--+~~~~~~~~+-
    |~~|     |~~~~~~~~|  |~~~~~~~~|
    |~~|     +--+~~+--+  +--+~~+--+
    |~~|        |~~|        |~~|
    |~~|        |~~|        |~~|
 +--+~~+--+     |~~|        |~~|
 |~~~~~~~~|     |~~|        |~~|
-+~~~~~~~~+-----+~~+--------+~~+----
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-+~~~~~~~~+-----+~~+--------+~~+----
 |~~~~~~~~|     |~~|        |~~|
 +--+~~+--+     |~~|        |~~|
    |~~|        |~~|        |~~|
```
