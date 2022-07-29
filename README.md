# coreboot-cpuid-bug
demo of faulty coreboot cpuid usage

# issue
rbx is not restored after the call to cpuid

# fix
add rbx to clobber, or use compiler intrinsics

# run
via __run_fixed.sh__

# example output
![example](https://github.com/matdibu/coreboot-cpuid-bug/blob/master/example.png?raw=true)

