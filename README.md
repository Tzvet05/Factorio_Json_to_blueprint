# Factorio Json to blueprint string

Dynamic library that converts a C-style string into a compressed, pastable C-style string.

This is useful for Factorio blueprint creation, as it can convert a string containing a Json Factorio blueprint object into a pastable blueprint string that can be directly imported in-game.

## SETUP

Clone and go into the repository using
```sh
git clone --recurse-submodules git@github.com:Tzvet05/Factorio_Json_to_blueprint.git && cd Factorio_Json_to_blueprint/
```

Compile the library using
```sh
make
```

### Makefile rules

`make (all)` compiles the dependency libraries and the library.

`make fclean` removes everything that got compiled.

`make clean` removes everything that got compiled except the library and its dependency dynamic library.

`make cleanblueprint` removes the library's object files.

`make re` removes everything that got compiled and recompiles the dependency libraries and the library.

`make reblueprint` removes the library's object files and recompiles the library.

## USAGE

The compiled dynamic library is named `libblueprint.so` and is located at the root of the repository.
Its associated header (for function prototypes) is named `libblueprint.h` and is located at `include/libblueprint.h`.

### Prototypes

The prototypes of all the exported functions are included in the `libblueprint.h` header file.

The file contains the following prototypes :

```c
char	*blueprint_json_to_string(char *json);
```
Description :

This function converts a Json Factorio blueprint into a pastable Factorio blueprint string

Arguments :
- A C-style, null-terminated string (the Json Factorio blueprint object)

Return value :
- A C-style, null-terminated string (the Factorio blueprint string)
- A `NULL` pointer (if an error occured)

## CREDITS

A special thanks to the contributors of :
- [cJSON](https://github.com/DaveGamble/cJSON) - Used for the parsing and building of Json objects
