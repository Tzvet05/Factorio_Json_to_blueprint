#pragma once

/* ----- INCLUDES ----- */

#include <stdbool.h>

/* ----- MACROS ----- */

// Zlib
#define COMPRESSION_LEVEL	9
#define CHUNK_SIZE		262144

/* ----- TYPES DECLARATIONS ----- */

typedef struct	parr	t_parr;

/* ----- PROTOTYPES ----- */

// compress/
//	compress.c
bool	blueprint_compress(t_parr *dst, t_parr *src);
