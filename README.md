# Factorio Json to blueprint string

Executable & dynamic library that converts a C-style string into a compressed, pastable C-style string.

This is useful for Factorio blueprint creation, as it can convert a string containing a Json Factorio blueprint item into a pastable blueprint string that can be directly imported in-game.

## SETUP

Clone and go into the repository using
```sh
git clone --recurse-submodules git@github.com:Tzvet05/Factorio_Json_to_blueprint.git && cd Factorio_Json_to_blueprint/
```

Compile the executable using
```sh
make
```

Compile the library using
```sh
make lib
```

### Makefile rules

`make` compiles the dependency libraries and the executable.

`make lib` compiles the dependency libraries and the library.

`make all` compiles the dependency libraries, the executable and the library.

`make fclean` removes everything that got compiled.

`make clean` removes everything that got compiled except the executable, the library and their dependency dynamic library.

`make cleanblueprint` removes the executable and library's object files.

`make re` removes everything that got compiled and recompiles the dependency libraries, the executable and the library.

`make reblueprint` removes the executable and library's object files and recompiles the executable and the library.

## USAGE

### Executable

Run the executable using
`./blueprint {input} ({output})`

`{input}` is the mandatory input file containing the text to convert.
You must have reading permissions for it.

`{output}` is the optional output file containing the converted text.
If it does not exist, the executable will create it and name it `string.txt`. If it already exists, you must have writing permissions for it.

### Library

The compiled dynamic library is named `libblueprint.so` and is located at the root of the repository.

Its associated header (for function prototypes) is named `libblueprint.h` and is located at `include/libblueprint.h`.

#### Prototype

The prototype of the exported function is included in the `libblueprint.h` header file.

The file contains the following prototype :

```c
char	*blueprint_json_to_string(const char *json);
```
Description :

This function converts a Json Factorio blueprint into a Factorio blueprint string

Arguments :
- A C-style, null-terminated string (the Json Factorio blueprint item)

Return value :
- A C-style, null-terminated string (the Factorio blueprint string)
- A `NULL` pointer (if an error occured)

## CREDITS

A special thanks to the contributors of :
- [zlib](https://github.com/madler/zlib) - Used to compress the Json blueprint object
- [base64](https://github.com/aklomp/base64) - Used to make the compressed Json blueprint object copyable
