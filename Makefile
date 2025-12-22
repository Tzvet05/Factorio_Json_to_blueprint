# Compilation parameters

NAME_EXE :=	blueprint
NAME_LIB :=	lib$(NAME_EXE).so

CC :=	clang

LIB_BLUEPRINT :=	blueprint
LIB_ZLIB :=		z
LIB_BASE64 :=		base64

NAME_LIB_BLUEPRINT :=	lib$(LIB_BLUEPRINT).a
NAME_LIB_ZLIB :=	lib$(LIB_ZLIB).so
NAME_LIB_BASE64 :=	lib$(LIB_BASE64).o

CFLAGS =	-Wall -Wextra -Wconversion -Wpedantic
LDFLAGS =	-L$(DIR_LIB_BLUEPRINT) -L$(DIR_LIB_ZLIB)$(DIR_BUILD) -Wl,-rpath,$(DIR_LIB_ZLIB)$(DIR_BUILD)
LDLIBS =	-l$(LIB_BLUEPRINT) -l$(LIB_ZLIB) $(DIR_LIB_BASE64)$(DIR_LIB)$(NAME_LIB_BASE64)

CFLAGS_LIB =	-fPIC -fvisibility=hidden
LDFLAGS_LIB =	-Bsymbolic -shared

# Directories

DIR_HDR :=	hdr/
DIR_SRC :=	src/
DIR_OBJ :=	obj/

DIR_OBJ_EXE :=	exe/
DIR_OBJ_LIB :=	lib/

DIR_BUILD :=	build/
DIR_INCLUDE :=	include/
DIR_LIB :=	lib/

DIR_LIB_BLUEPRINT :=	lib/
DIR_LIB_ZLIB :=		submodules/zlib/
DIR_LIB_BASE64 :=	submodules/base64/

DIR_COM :=	compress/
DIR_BAS :=	base64/
DIR_FIL :=	files/
DIR_ARG :=	arguments/

# Colors

COLOR_DEFAULT :=	\033[0m
COLOR_GREEN :=		\033[1;38;5;2m
COLOR_BLUE :=		\033[1;38;5;4m
COLOR_WHITE :=		\033[1;38;5;15m

# Source headers

HDR :=	$(DIR_INCLUDE) \
	$(DIR_HDR) \
	$(DIR_LIB_BLUEPRINT)$(DIR_HDR) \
	$(DIR_LIB_ZLIB) \
	$(DIR_LIB_BASE64)$(DIR_INCLUDE)

# Source code

SRC :=		wrapper.c \
		$(DIR_COM)compress.c \
		$(DIR_BAS)base64.c

SRC_EXE :=	main.c \
		$(DIR_FIL)check.c \
		$(DIR_FIL)read.c \
		$(DIR_FIL)write.c \
		$(DIR_ARG)check.c \
		$(DIR_ARG)get.c \
		$(SRC)

SRC_LIB :=	$(SRC)

# Dynamic variables

$(NAME_LIB) : CFLAGS += $(CFLAGS_LIB)
$(NAME_LIB) : LDFLAGS += $(LDFLAGS_LIB)

# Compiled objects

OBJ_EXE :=	$(addprefix $(DIR_OBJ)$(DIR_OBJ_EXE), $(SRC_EXE:.c=.o))
OBJ_LIB :=	$(addprefix $(DIR_OBJ)$(DIR_OBJ_LIB), $(SRC_LIB:.c=.o))

# Compilation

$(NAME_EXE) : $(OBJ_EXE) $(NAME_LIB_BLUEPRINT) $(NAME_LIB_ZLIB) $(NAME_LIB_BASE64)
	@ $(CC) $(CFLAGS) $(LDFLAGS) $(OBJ_EXE) $(LDLIBS) -o $@
	@ echo "$(COLOR_WHITE)[$(NAME_EXE)] - $(COLOR_GREEN)Executable ($(NAME_EXE)) compiled.$(COLOR_DEFAULT)"

$(NAME_LIB) : $(OBJ_LIB) $(NAME_LIB_BLUEPRINT) $(NAME_LIB_ZLIB) $(NAME_LIB_BASE64)
	@ $(CC) $(CFLAGS) $(LDFLAGS) $(OBJ_LIB) $(LDLIBS) -o $@
	@ echo "$(COLOR_WHITE)[$(NAME_LIB)] - $(COLOR_GREEN)Dynamic library ($(NAME_LIB)) compiled.$(COLOR_DEFAULT)"

$(DIR_OBJ)$(DIR_OBJ_EXE)%.o : $(DIR_SRC)%.c
	@ mkdir -p $(dir $@)
	@ $(CC) $(CFLAGS) $(addprefix -I, $(HDR)) -c $^ -o $@

$(DIR_OBJ)$(DIR_OBJ_LIB)%.o : $(DIR_SRC)%.c
	@ mkdir -p $(dir $@)
	@ $(CC) $(CFLAGS) $(addprefix -I, $(HDR)) -c $^ -o $@

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

all : $(NAME_EXE) $(NAME_LIB)

lib : $(NAME_LIB)

fclean :
	@ make fclean -s -C $(DIR_LIB_BLUEPRINT)
	@ rm -rf $(DIR_LIB_ZLIB)$(DIR_BUILD)
	@ echo "$(COLOR_WHITE)[$(NAME_LIB_ZLIB)] - $(COLOR_BLUE)Objects cleaned.$(COLOR_DEFAULT)"
	@ echo "$(COLOR_WHITE)[$(NAME_LIB_ZLIB)] - $(COLOR_BLUE)Dynamic library ($(NAME_LIB_ZLIB)) cleaned.$(COLOR_DEFAULT)"
	@ make clean -s -C $(DIR_LIB_BASE64)
	@ echo "$(COLOR_WHITE)[$(NAME_LIB_BASE64)] - $(COLOR_BLUE)Object library ($(NAME_LIB_BASE64)) cleaned.$(COLOR_DEFAULT)"
	@ rm -rf $(DIR_OBJ)
	@ echo "$(COLOR_WHITE)[$(NAME_EXE) & $(NAME_LIB)] - $(COLOR_BLUE)Objects cleaned.$(COLOR_DEFAULT)"
	@ rm -f $(NAME_EXE)
	@ rm -f $(NAME_LIB)
	@ echo "$(COLOR_WHITE)[$(NAME_EXE) & $(NAME_LIB)] - $(COLOR_BLUE)Executable ($(NAME_EXE)) & dynamic library ($(NAME_LIB)) cleaned.$(COLOR_DEFAULT)"

clean :
	@ make fclean -s -C $(DIR_LIB_BLUEPRINT)
	@ find $(DIR_LIB_ZLIB)$(DIR_BUILD) -name "*" 2> /dev/null | tail -n +2 | grep -v "\.so" | xargs rm -rf
	@ echo "$(COLOR_WHITE)[$(NAME_LIB_ZLIB)] - $(COLOR_BLUE)Objects cleaned.$(COLOR_DEFAULT)"
	@ make clean -s -C $(DIR_LIB_BASE64)
	@ echo "$(COLOR_WHITE)[$(NAME_LIB_BASE64)] - $(COLOR_BLUE)Object library ($(NAME_LIB_BASE64)) cleaned.$(COLOR_DEFAULT)"
	@ rm -rf $(DIR_OBJ)
	@ echo "$(COLOR_WHITE)[$(NAME_EXE) & $(NAME_LIB)] - $(COLOR_BLUE)Objects cleaned.$(COLOR_DEFAULT)"

cleanblueprint :
	@ rm -rf $(DIR_OBJ)
	@ echo "$(COLOR_WHITE)[$(NAME_EXE) & $(NAME_LIB)] - $(COLOR_BLUE)Objects cleaned.$(COLOR_DEFAULT)"

reall : fclean all

reallblueprint : cleanblueprint all

re : fclean $(NAME_EXE)

reblueprint : cleanblueprint $(NAME_EXE)

relib : fclean lib

relibblueprint : clean lib

.PHONY : all lib fclean clean cleanblueprint reall reallblueprint re reblueprint relib relibblueprint
