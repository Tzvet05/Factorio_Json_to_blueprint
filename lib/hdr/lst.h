#pragma once

/* ----- INCLUDES ----- */

#include <stdbool.h>

/* ----- STRUCTURES ----- */

// Linked list
typedef struct lst
{
	void		*content;
	struct lst	*next;
}	t_lst;

/* ----- PROTOTYPES ----- */

// lst/
//	new_back.c
bool	lst_new_back(t_lst **lst, void *content);
//	to_obj.c
bool	lst_to_obj(void *dst, t_lst *lst, size_t (*get_len)(void*), size_t (*get_size)(void*),
	bool (*alloc)(void*, size_t, size_t), void (*cpy)(void*, void*, size_t, size_t, size_t));
//	clear.c
void	lst_clear(t_lst **lst, void (*del)(void*));
