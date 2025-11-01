#include <stdlib.h>
#include "libbase64.h"
#include "parr.h"
#include "error.h"

char*	blueprint_base64(t_parr* src)
{
	char*	blueprint_string = malloc((src->len * 4 + 2) / 3 + 1);
	if (blueprint_string == NULL)
	{
		fprintf(stderr, "%s: %s: %s: %s\n",
			EXECUTABLE_NAME, LIB_LIBC, FUNC_MALLOC, ERROR_FAILED_ALLOC);
		return (NULL);
	}
	size_t	len;
	base64_encode(src->arr, src->len, blueprint_string, &len, 0);
	blueprint_string[len] = '\0';
	return (blueprint_string);
}
