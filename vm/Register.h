#ifndef REGISTER_H
#define REGISETR_H

/**
 * simple union used for byte operations on registers
 */
typedef union {
	int value;
	short value_x;
	char value_hl[2];
} Register;

/**
 * eflags register according to the intel docs
 */
struct Eflag_register
{
	int cf   : 1;
	int pf   : 1;
	int af   : 1;
	int zf   : 2;
	int sf   : 2;
	int tf   : 1;
	int df   : 1;
	int of   : 1;
	int iopl : 1;
	int nt   : 1;
	int rf   : 1;
	int vm   : 1;
	int ac   : 1;
	int vif  : 1;
	int vip  : 1;
	int id   : 1;
};

#endif
