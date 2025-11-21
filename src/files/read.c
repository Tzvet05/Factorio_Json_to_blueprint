#include <sys/stat.h>
#include <stdlib.h>
#include "file.h"
#include "error.h"

char	*read_file(t_file *file)
{
	if (file_open(file, FOPEN_READ_MODE) == 1)
	{
		fprintf(stderr, "%s: %s: %s: %s: %s: \"%s\"\n",
			EXECUTABLE_NAME, ERROR_FUNCTION, LIB_LIBC, FUNC_FOPEN, ERROR_OPEN_FILE,
			file->name);
		return (NULL);
	}
	struct stat	file_status;
	if (stat(file->name, &file_status) != 0)
	{
		fprintf(stderr, "%s: %s: %s: %s: %s: \"%s\"\n",
			EXECUTABLE_NAME, ERROR_FUNCTION, LIB_LIBC, FUNC_STAT, ERROR_FILE_STATUS,
			file->name);
		file_close(file);
		return (NULL);
	}
	char	*buffer = malloc(((size_t)file_status.st_size + 1) * sizeof(char));
	if (buffer == NULL)
	{
		fprintf(stderr, "%s: %s: %s: %s: %s\n",
			EXECUTABLE_NAME, ERROR_FUNCTION, LIB_LIBC, FUNC_MALLOC, ERROR_ALLOC);
		file_close(file);
		return (NULL);
	}
	buffer[file_status.st_size] = '\0';
	fread(buffer, 1, (size_t)file_status.st_size, file->stream);
	if (ferror(file->stream) != 0)
	{
		fprintf(stderr, "%s: %s: %s: %s: %s: \"%s\"\n",
			EXECUTABLE_NAME, ERROR_FUNCTION, LIB_LIBC, FUNC_FREAD, ERROR_READ_FILE,
			file->name);
		free(buffer);
		file_close(file);
		return (NULL);
	}
	file_close(file);
	return (buffer);
}
