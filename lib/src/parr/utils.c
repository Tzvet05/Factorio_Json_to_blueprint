#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include "parr.h"

size_t	parr_get_len(void *parr)
{
	return (((t_parr *)parr)->len);
}

size_t	parr_get_size(void *parr)
{
	return (((t_parr *)parr)->obj_size);
}

bool	parr_alloc_arr(void *parr, size_t len, size_t size)
{
	void	*arr = malloc(len * size);
	if (arr == NULL)
		return (1);
	((t_parr *)parr)->len = len;
	((t_parr *)parr)->obj_size = size;
	((t_parr *)parr)->arr = arr;
	return (0);
}

void	parr_copy_arr(void *parr, void *src, size_t i_start, size_t len, size_t size)
{
	memcpy((uint8_t *)((t_parr *)parr)->arr + i_start * size, ((t_parr *)src)->arr, len * size);
}
