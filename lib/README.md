# Calyx Bindings for Hardposit

## Build Instructions

1. To generate the System Verilog from the Chisel modules, from the root folder run

```
# From the root folder of the project
sbt run gen P32 full

# For 64 bit posit and 16 bit posit
sbt run gen P32 full
```

For Posit 32, this will create a folder `P32` with one SV file per module.

2. Combine all the SV modules to create a single SV

```
# From lib/
make
```

## Examples

The examples folder contains examples of using the binding in Calyx Native

```
fud e --to dat vector_add.futil -s verilog.data vector_add.fuse.data --through verilog 
```

## Frontends

Calyx frontends will have to emit these primitive to use the Hardposit modules.
