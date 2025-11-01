#pragma once

/* ----- MACROS ----- */

// Base64
#define BASE64_MARGIN_ENCODE	5

/* ----- TYPES DECLARATIONS ----- */

typedef struct	parr	t_parr;

/* ----- PROTOTYPES ----- */

char*	blueprint_base64(t_parr* src);
