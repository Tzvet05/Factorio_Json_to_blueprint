#pragma once

/* ----- INCLUDES ----- */

#include <stdbool.h>

/* ----- STRUCTURES ----- */

// Pascal-style-string-like array
typedef struct parr
{
	void	*arr;
	size_t	obj_size;
	size_t	len;
}	t_parr;

/* ----- PROTOTYPES ----- */

// parr/
//	tools.c
size_t	parr_get_len(void *parr);
size_t	parr_get_size(void *parr);
bool	parr_alloc_arr(void *parr, size_t len, size_t size);
void	parr_copy_arr(void *parr, void *src, size_t i_start, size_t len, size_t size);
//	clear.c
void	parr_clear(t_parr *parr, void (*del)(void*));
//	free.c
void	parr_free(void *parr);
