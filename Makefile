# Compilation parameters

NAME =		libblueprint.so

CC =		clang

LIB_BLUEPRINT =	blueprint
LIB_ZLIB =	z
LIB_BASE64 =	base64

NAME_LIB_BLUEPRINT =	lib$(LIB_BLUEPRINT).a
NAME_LIB_ZLIB =		lib$(LIB_ZLIB).so
NAME_LIB_BASE64 =	lib$(LIB_BASE64).o

CFLAGS =	-fPIC -fvisibility=hidden -Wall -Wextra -Wconversion -Wpedantic
LDFLAGS =	-shared -L$(DIR_LIB_BLUEPRINT) -L$(DIR_LIB_ZLIB)$(DIR_BUILD) -Wl,-rpath,$(DIR_LIB_ZLIB)$(DIR_BUILD)
LDLIBS =	-l$(LIB_BLUEPRINT) -l$(LIB_ZLIB) $(DIR_LIB_BASE64)$(DIR_LIB)$(NAME_LIB_BASE64)

# Directories

DIR_HDR =	hdr/
DIR_SRC =	src/
DIR_OBJ =	obj/

DIR_BUILD =	build/
DIR_INCLUDE =	include/
DIR_LIB =	lib/

DIR_LIB_BLUEPRINT =	lib/
DIR_LIB_ZLIB =		submodules/zlib/
DIR_LIB_BASE64 =	submodules/base64/

DIR_COM =	compress/
DIR_BAS =	base64/

# Colors

COLOR_DEFAULT =	\033[0m
COLOR_GREEN =	\033[1;38;5;2m
COLOR_BLUE =	\033[1;38;5;4m
COLOR_WHITE =	\033[1;38;5;15m

# Source headers

HDR =	$(DIR_INCLUDE) \
	$(DIR_HDR) \
	$(DIR_LIB_BLUEPRINT)$(DIR_HDR) \
	$(DIR_LIB_ZLIB) \
	$(DIR_LIB_BASE64)$(DIR_INCLUDE)

# Source code

SRC =	wrapper.c \
	$(DIR_COM)compress.c \
	$(DIR_BAS)base64.c

# Compiled objects

OBJ = $(addprefix $(DIR_OBJ), $(SRC:.c=.o))

# Compilation

$(NAME) : $(OBJ) $(NAME_LIB_BLUEPRINT) $(NAME_LIB_ZLIB) $(NAME_LIB_BASE64)
	@ $(CC) $(CFLAGS) $(LDFLAGS) $(OBJ) $(LDLIBS) -o $(NAME)
	@ echo "$(COLOR_WHITE)[$(NAME)] - $(COLOR_GREEN)Dynamic library ($(NAME)) compiled.$(COLOR_DEFAULT)"

$(DIR_OBJ)%.o : $(DIR_SRC)%.c
	@ mkdir -p $(dir $@)
	@ $(CC) $(CFLAGS) $(addprefix -I,$(HDR)) -c $^ -o $@

# Libraries

$(NAME_LIB_BLUEPRINT) :
	@ make -s -C $(DIR_LIB_BLUEPRINT)

$(NAME_LIB_ZLIB) :
	@ cmake -B$(DIR_LIB_ZLIB)$(DIR_BUILD) -S$(DIR_LIB_ZLIB) > /dev/null
	@ make -s -C $(DIR_LIB_ZLIB)$(DIR_BUILD) > /dev/null
	@ echo "$(COLOR_WHITE)[$(NAME_LIB_ZLIB)] - $(COLOR_GREEN)Dynamic library ($(NAME_LIB_ZLIB)) compiled.$(COLOR_DEFAULT)"

$(NAME_LIB_BASE64) :
	@ make $(DIR_LIB)$(NAME_LIB_BASE64) -s -C $(DIR_LIB_BASE64) CFLAGS+="-fPIC -I$(DIR_LIB)"
	@ echo "$(COLOR_WHITE)[$(NAME_LIB_BASE64)] - $(COLOR_GREEN)Object library ($(NAME_LIB_BASE64)) compiled.$(COLOR_DEFAULT)"

# Rules

all : $(NAME)

fclean :
	@ make fclean -s -C $(DIR_LIB_BLUEPRINT)
	@ rm -rf $(DIR_LIB_ZLIB)$(DIR_BUILD)
	@ echo "$(COLOR_WHITE)[$(NAME_LIB_ZLIB)] - $(COLOR_BLUE)Objects cleaned.$(COLOR_DEFAULT)"
	@ echo "$(COLOR_WHITE)[$(NAME_LIB_ZLIB)] - $(COLOR_BLUE)Dynamic library ($(NAME_LIB_ZLIB)) cleaned.$(COLOR_DEFAULT)"
	@ make clean -s -C $(DIR_LIB_BASE64)
	@ echo "$(COLOR_WHITE)[$(NAME_LIB_BASE64)] - $(COLOR_BLUE)Object library ($(NAME_LIB_BASE64)) cleaned.$(COLOR_DEFAULT)"
	@ rm -rf $(DIR_OBJ)
	@ echo "$(COLOR_WHITE)[$(NAME)] - $(COLOR_BLUE)Objects cleaned.$(COLOR_DEFAULT)"
	@ rm -f $(NAME)
	@ echo "$(COLOR_WHITE)[$(NAME)] - $(COLOR_BLUE)Dynamic library ($(NAME)) cleaned.$(COLOR_DEFAULT)"

clean :
	@ make fclean -s -C $(DIR_LIB_BLUEPRINT)
	@ find $(DIR_LIB_ZLIB)$(DIR_BUILD) -name "*" | tail -n +2 | grep -v "\.so" | xargs rm -rf
	@ echo "$(COLOR_WHITE)[$(NAME_LIB_ZLIB)] - $(COLOR_BLUE)Objects cleaned.$(COLOR_DEFAULT)"
	@ make clean -s -C $(DIR_LIB_BASE64)
	@ echo "$(COLOR_WHITE)[$(NAME_LIB_BASE64)] - $(COLOR_BLUE)Object library ($(NAME_LIB_BASE64)) cleaned.$(COLOR_DEFAULT)"
	@ rm -rf $(DIR_OBJ)
	@ echo "$(COLOR_WHITE)[$(NAME)] - $(COLOR_BLUE)Objects cleaned.$(COLOR_DEFAULT)"

cleanblueprint :
	@ rm -rf $(DIR_OBJ)
	@ echo "$(COLOR_WHITE)[$(NAME)] - $(COLOR_BLUE)Objects cleaned.$(COLOR_DEFAULT)"

re : fclean all

reblueprint : cleanblueprint all

.PHONY : all fclean clean cleanblueprint re reblueprint
