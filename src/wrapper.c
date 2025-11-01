#include <string.h>
#include "parr.h"
#include "compress.h"
#include "base64.h"

char*	blueprint_json_to_string(char* json)
{
	t_parr	compressed, uncompressed = (t_parr){.len = strlen(json), .obj_size = sizeof(*json),
		.arr = json};
	if (blueprint_compress(&compressed, &uncompressed) == 1)
		return (NULL);
	return (blueprint_base64(&compressed));
}
