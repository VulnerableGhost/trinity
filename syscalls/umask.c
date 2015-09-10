/*
 * SYSCALL_DEFINE1(umask, int, mask)
 */
#include "sanitise.h"

struct syscallentry syscall_umask = {
	.name = "umask",
	.num_args = 1,
	.arg1name = "mask",
};
