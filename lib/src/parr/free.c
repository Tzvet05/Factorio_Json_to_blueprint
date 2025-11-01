#include <stdlib.h>
#include "parr.h"

void	parr_free(void* parr)
{
	free(((t_parr *)parr)->arr);
	free(parr);
}
