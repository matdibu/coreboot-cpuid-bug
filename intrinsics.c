#include <stdio.h>
#include <stdint.h>
#include <cpuid.h>

struct cpuid_result {
	uint32_t eax;
	uint32_t ebx;
	uint32_t ecx;
	uint32_t edx;
};

/*
 * Generic CPUID function
 */
static inline struct cpuid_result cpuid(int op)
{
	struct cpuid_result result;

	__cpuid(op, result.eax, result.ebx, result.ecx, result.edx);

	return result;
}

int main()
{
	char name[32] = "hello!";
	printf("%16p\n", name);
	cpuid(0x80000002);
	printf("%16p\n", name);
	return 0;
}

