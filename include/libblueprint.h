#pragma once

/* ----- MACROS ----- */

#define API_EXPORT	__attribute__((visibility("default")))

/* ----- PROTOTYPES ----- */

API_EXPORT char	*blueprint_json_to_string(char *json);
