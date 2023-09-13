# Hardware Posit Arithmetic Units
[![CircleCI](https://circleci.com/gh/thoughtworks/hardposit-chisel3.svg?style=svg)](https://circleci.com/gh/thoughtworks/hardposit-chisel3)

This project contains hardware units required for performing floating-point arithmetic operations on numbers represented in the Unum Type-III Posit standard. The parameterized modules have been described in Chisel and can generate synthesizable RTL for posits of any size.

**DISCLAIMER**: 
These units are works in progress and are not completely free of bugs or fully optimized.

## About Posit Arithmetic
Universal Numbers, or unums, are a collection of number systems which features better efficiency and mathematically correct arithmetic properties compared to the IEEE-754 floating-point standard. Unums are capable of expressing real numbers and ranges of real numbers. The newest version Unum Type-III called [Posits] is a hardware-friendly representation designed as a drop-in replacement for IEEE floats.

Posits behave much like a floating-point number of fixed size, rounding to the nearest expressible value if the result of a calculation is not expressible exactly. It offers more accuracy, and a larger dynamic range than IEEE floats with the same number of bits. Posit arithmetic tries to resolve the short-comings of IEEE floats using a dynamic representation that minimizes unusable representations and exceptional cases.

For more information about Universal numbers and Posit arithmetic and to follow community discussions:

[Posit Hub] \
[Unum-computing Google group]

## Unit Testing

The posit arithmetic modules have been unit tested using Chisel IO testers. For better coverage a random test generator is also available enabled by the [universal] C++ template library. The test generator supplies tests to the hardware units which are simulated using [verilator]. 

#### Prerequisites:

- Install ```cmake```(version 3.14 or later). Refer to https://cmake.org/download/ for installation.
- Install ```sbt```. Refer to https://www.scala-sbt.org/download.html
- Install ```verilator```. On MacOS you can install it using ```brew install verilator```. Refer to https://www.veripool.org/projects/verilator/wiki/Installing


To test the units using verilator:
```sh
$ git clone https://github.com/thoughtworks/hardposit-chisel3
$ cd hardposit-chisel3
$ git submodule update --init --recursive
$ make
```

To test the units using chiseltest:

```sh
$ sbt test
```

##  Contributions
We are working towards a complete posit implementation including support for *quire* and all the fused operations mandated by the posit arithmetic standard and optimizing the existing units. Feel free to open an issue or pull request if you find any bugs or possible improvements in the design.

[Posit Hub]: <https://posithub.org/>
[Posits]: <https://posithub.org/docs/Posits4.pdf>
[Unum-computing Google group]: <https://groups.google.com/forum/#!forum/unum-computing>
[universal]: <https://github.com/stillwater-sc/universal>
[cmake]: <https://cmake.org/>
[verilator]: <https://www.veripool.org/wiki/verilator>

