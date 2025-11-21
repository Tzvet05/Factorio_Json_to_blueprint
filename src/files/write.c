#include <string.h>
#include "file.h"
#include "error.h"

bool	write_file(t_file *file, char *string)
{
	if (file_open(file, FOPEN_WRITE_MODE) == 1)
	{
		fprintf(stderr, "%s: %s: %s: %s: %s: \"%s\"\n",
			EXECUTABLE_NAME, ERROR_FUNCTION, LIB_LIBC, FUNC_FOPEN, ERROR_OPEN_FILE,
			file->name);
		return (1);
	}
	fwrite(string, strlen(string), sizeof(*string), file->stream);
	if (ferror(file->stream) != 0)
	{
		fprintf(stderr, "%s: %s: %s: %s: %s: \"%s\"\n",
			EXECUTABLE_NAME, ERROR_FUNCTION, LIB_LIBC, FUNC_FWRITE, ERROR_WRITE_FILE,
			file->name);
		file_close(file);
		return (1);
	}
	file_close(file);
	return (0);
}
