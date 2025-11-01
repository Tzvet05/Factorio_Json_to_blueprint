#pragma once

/* ----- INCLUDES ----- */

#include <stdio.h>

/* ----- MACROS ----- */

// Executable name
#define EXECUTABLE_NAME	"blueprint"

// Failing libraries
#define LIB_LIBC	"libc library"
#define LIB_ZLIB	"zlib library"

// Failing functions
//	libc
#define FUNC_MALLOC	"malloc function"
//	zlib
#define FUNC_ZLIB_DEFLATEINIT	"deflateInit function"
#define FUNC_ZLIB_DEFLATE	"deflate function"

// Error strings
//	zlib
#define ERROR_ZLIB_DEFLATEINIT	"failed to initialize the compression engine"
#define ERROR_ZLIB_DEFLATE	"failed to compress a block"
//	Allocation
#define ERROR_FAILED_ALLOC	"failed memory allocation"
