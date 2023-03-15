# librop

librop is a C library that contains a multitude of user-defined ROP (Return-oriented programming) gadgets. 
Designed to be used with [ROPfuscator](https://github.com/ropfuscator/ropfuscator), librop facilitates the availability of ROP gadgets for advanced exploitation and binary obfuscation.

## Installation

### Using CMake

To install `librop` using CMake, follow these steps:

```bash
git clone https://github.com/yourusername/librop.git
cd librop
mkdir build && pushd build
cmake .. && cmake --build .
popd
```

### Using Nix (with flakes support)

To compile `librop` with Nix ensure that you have flakes enabled in your Nix installation. If you haven't enabled flakes yet, you can follow the instructions in the [Nix Flakes documentation](https://nixos.wiki/wiki/Flakes) to set it up.

```bash
nix build github:ropfuscator/librop
```