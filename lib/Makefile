# Compilation parameters

NAME =		libblueprint.a

COMP =		clang

CFLAGS =	-Wall -Wextra -Wconversion -Wpedantic

# Directories

DIR_HDR =	hdr/
DIR_SRC =	src/
DIR_OBJ =	obj/

DIR_LST = 	lst/
DIR_PAR =	parr/

# Colors

COLOR_DEFAULT =	\033[0m
COLOR_GREEN =	\033[32;1m
COLOR_BLUE =	\033[34;1m
COLOR_WHITE =	\033[97;1m

# Source headers

HDR =	$(DIR_HDR)

# Source code

SRC =	$(DIR_LST)new_back.c \
	$(DIR_LST)to_obj.c \
	$(DIR_LST)clear.c \
	$(DIR_PAR)utils.c \
	$(DIR_PAR)free.c

# Compiled objects

OBJ = $(addprefix $(DIR_OBJ), $(SRC:.c=.o))

# Compilation

$(NAME) : $(OBJ)
	@ ar rcs $(NAME) $(OBJ)
	@ echo "$(COLOR_WHITE)[$(NAME)] - $(COLOR_GREEN)Archive ($(NAME)) compiled.$(COLOR_DEFAULT)"

$(DIR_OBJ)%.o : $(DIR_SRC)%.c
	@ mkdir -p $(dir $@)
	@ $(COMP) $(CFLAGS) $(addprefix -I,$(HDR)) -c $^ -o $@

# Rules

all : $(NAME)

fclean :
	@ rm -rf $(DIR_OBJ)
	@ echo "$(COLOR_WHITE)[$(NAME)] - $(COLOR_BLUE)Objects cleaned.$(COLOR_DEFAULT)"
	@ rm -f $(NAME)
	@ echo "$(COLOR_WHITE)[$(NAME)] - $(COLOR_BLUE)Archive ($(NAME)) cleaned.$(COLOR_DEFAULT)"

clean :
	@ rm -rf $(DIR_OBJ)
	@ echo "$(COLOR_WHITE)[$(NAME)] - $(COLOR_BLUE)Objects cleaned.$(COLOR_DEFAULT)"

re : fclean all

.PHONY : all fclean clean re
