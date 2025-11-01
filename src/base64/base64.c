#include <stdlib.h>
#include <string.h>
#include "libbase64.h"
#include "parr.h"
#include "base64.h"
#include "blueprint.h"
#include "error.h"

char*	blueprint_base64(t_parr* src)
{
	size_t	len_head = strlen(BLUEPRINT_STRING_HEAD);
	char*	blueprint_string = malloc((src->len * 4 + 2) / 3 + 1 + len_head
		+ BASE64_MARGIN_ENCODE);
	if (blueprint_string == NULL)
	{
		fprintf(stderr, "%s: %s: %s: %s\n",
			EXECUTABLE_NAME, LIB_LIBC, FUNC_MALLOC, ERROR_FAILED_ALLOC);
		return (NULL);
	}
	memcpy(blueprint_string, BLUEPRINT_STRING_HEAD, len_head);
	size_t	len;
	base64_encode(src->arr, src->len, &blueprint_string[len_head], &len, 0);
	blueprint_string[len_head + len] = '\0';
	return (blueprint_string);
}
