# chmod symbolic notation

Breakdown:
* `u` = user (owner)
* `g` = group
* `o` = others (everyone else)
* `+` = add permission
* `-` = remove permission
* `=` = set permission exactly

Letters for permissions:
* `r` = read
* `w` = write
* `x` = execute

Examples:
* `chmod u+x file` = add execute permission for owner
* `chmod g-w file` = remove write permission for group
* `chmod o=r file` = set read-only permission for others
* `chmod ug=rwx file` = set read/write/execute for owner/group

Equivalent to numeric:
* `chmod 775 file` = `chmod ug=rwx,o=r file`

# free

`free` command shows the amount of free and used RAM in the system.

Example:

```bash
fedora@earth:~$ which free  # The path to the free command
/usr/bin/free

fedora@earth:~$ rpm -qf $(which free)  # The package that provides the free command
procps-ng-8.3.1-1.fc41.x86_64

fedora@earth:~$ free -V  # The version of the free command
free from procps-ng 8.3.1

fedora@earth:~$ free -b  # Display the amount of memory in bytes
               total        used        free      shared  buff/cache   available
Mem:     32893583360 10984034304 14225260544   253415424  8413335552 21909549056
Swap:     8589930496           0  8589930496
fedora@earth:~$ free -k  # Display the amount of memory in kilobytes
               total        used        free      shared  buff/cache   available
Mem:        32122640    10703428    13914284      247476     8216920    21419212
Swap:        8388604           0     8388604
fedora@earth:~$ free -m  # Display the amount of memory in megabytes
               total        used        free      shared  buff/cache   available
Mem:           31369       10547       13491         250        8034       20821
Swap:           8191           0        8191
fedora@earth:~$ free -g  # Display the amount of memory in gigabytes
               total        used        free      shared  buff/cache   available
Mem:              30          10          13           0           7          20
Swap:              7           0           7
fedora@earth:~$ free -h  # Display the amount of memory in human-readable format
               total        used        free      shared  buff/cache   available
Mem:            30Gi        10Gi        13Gi       247Mi       7.8Gi        20Gi
Swap:          8.0Gi          0B       8.0Gi
fedora@earth:~$ free -t  # Display the total amount of memory
               total        used        free      shared  buff/cache   available
Mem:        32122640    10778768    13834676      253188     8226904    21343872
Swap:        8388604           0     8388604
Total:      40511244    10778768    22223280
fedora@earth:~$ free -ht  # Display the total amount of memory in human-readable format
               total        used        free      shared  buff/cache   available
Mem:            30Gi        10Gi        13Gi       245Mi       7.8Gi        20Gi
Swap:          8.0Gi          0B       8.0Gi
Total:          38Gi        10Gi        21Gi
```

My personal recomendation? `free -ht` is the best option, as it shows the total amount of memory in human-readable format. 

An explanation of the columns:
* `total` = total amount of physical memory
* `used` = memory used by the system
* `free` = memory not used by the system
* `shared` = memory used (mostly) by tmpfs
* `buff/cache` = memory used by the kernel for buffers and cache
* `available` = memory available for new processes

ie, in the last `free -ht` example, the system has 30GiB of total memory, 10GiB used, 13GiB free, 245MiB shared, 7.8GiB buffer/cache, and 20GiB available. The total memory is 38GiB, with 10GiB used and 21GiB free. 
