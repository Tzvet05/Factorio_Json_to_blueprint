#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <sys/param.h>
#include "lst.h"
#include "parr.h"
#include "zlib.h"
#include "compress.h"
#include "error.h"

bool	blueprint_compress(t_parr *dst, t_parr *src)
{
	z_stream	stream = (z_stream){.zalloc = Z_NULL, .zfree = Z_NULL, .opaque = Z_NULL};
	if (deflateInit(&stream, COMPRESSION_LEVEL) != Z_OK)
	{
		fprintf(stderr, "%s: %s: %s: %s: %s\n",
			EXECUTABLE_NAME, ERROR_FUNCTION, LIB_ZLIB, FUNC_ZLIB_DEFLATEINIT,
			ERROR_ZLIB_DEFLATEINIT);
		return (1);
	}
	uint8_t	*buffer = malloc(CHUNK_SIZE);
	if (buffer == NULL)
	{
		fprintf(stderr, "%s: %s: %s: %s: %s\n",
			EXECUTABLE_NAME, ERROR_FUNCTION, LIB_LIBC, FUNC_MALLOC, ERROR_ALLOC);
		deflateEnd(&stream);
		return (1);
	}
	size_t	len_input, i_input = 0;
	int32_t	flush;
	t_parr	*parr;
	t_lst	*output = NULL;
	do
	{
		len_input = MIN(src->len * src->obj_size - i_input, CHUNK_SIZE);
		i_input += len_input;
		stream.avail_in = (uint32_t)len_input;
		if (len_input < CHUNK_SIZE)
			flush = Z_FINISH;
		else
			flush = Z_NO_FLUSH;
		stream.next_in = src->arr;
		do
		{
			stream.avail_out = CHUNK_SIZE;
			stream.next_out = buffer;
			if (deflate(&stream, flush) == Z_STREAM_ERROR)
			{
				fprintf(stderr, "%s: %s: %s: %s: %s\n",
					EXECUTABLE_NAME, ERROR_FUNCTION, LIB_ZLIB,
					FUNC_ZLIB_DEFLATE, ERROR_ZLIB_DEFLATE);
				deflateEnd(&stream);
				free(buffer);
				lst_clear(&output, parr_free);
				return (1);
			}
			parr = malloc(sizeof(t_parr));
			if (parr == NULL)
			{
				fprintf(stderr, "%s: %s: %s: %s: %s\n",
					EXECUTABLE_NAME, ERROR_FUNCTION, LIB_LIBC, FUNC_MALLOC,
					ERROR_ALLOC);
				deflateEnd(&stream);
				free(buffer);
				lst_clear(&output, parr_free);
				return (1);
			}
			parr->len = CHUNK_SIZE - stream.avail_out;
			parr->obj_size = 1;
			parr->arr = malloc(parr->len * parr->obj_size);
			if (parr->arr == NULL)
			{
				fprintf(stderr, "%s: %s: %s: %s: %s\n",
					EXECUTABLE_NAME, ERROR_FUNCTION, LIB_LIBC, FUNC_MALLOC,
					ERROR_ALLOC);
				deflateEnd(&stream);
				parr_free(parr);
				free(buffer);
				lst_clear(&output, parr_free);
				return (1);
			}
			memcpy(parr->arr, buffer, parr->len * parr->obj_size);
			if (lst_new_back(&output, parr) == 1)
			{
				fprintf(stderr, "%s: %s: %s: %s: %s\n",
					EXECUTABLE_NAME, ERROR_FUNCTION, LIB_LIBC, FUNC_MALLOC,
					ERROR_ALLOC);
				deflateEnd(&stream);
				parr_free(parr);
				free(buffer);
				lst_clear(&output, parr_free);
				return (1);
			}
		}
		while (stream.avail_out == 0);
	}
	while (flush != Z_FINISH);
	deflateEnd(&stream);
	free(buffer);
	bool	error = lst_to_obj(dst, output, parr_get_len, parr_get_size, parr_alloc_arr,
		parr_copy_arr);
	lst_clear(&output, parr_free);
	if (error == 1)
		fprintf(stderr, "%s: %s: %s: %s: %s\n",
			EXECUTABLE_NAME, ERROR_FUNCTION, LIB_LIBC, FUNC_MALLOC, ERROR_ALLOC);
	return (error);
}
