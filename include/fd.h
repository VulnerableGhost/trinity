#pragma once

#include "list.h"

void setup_fd_providers(void);

unsigned int open_fds(void);

void process_fds_param(char *optarg);

struct fd_provider {
        struct list_head list;
	const char *name;
        int (*open)(void);
        int (*get)(void);
};
