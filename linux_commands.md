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

# SCP - Secure Copy Protocol

SCP is a command-line utility for securely transferring files between hosts on a network. It uses SSH for data transfer and provides the same authentication and security as SSH.

Basic syntax: `scp [options] source destination`

Common options:
* `-r` = recursively copy entire directories
* `-P` = specify the port to connect to on the remote host (note: uppercase P)
* `-p` = preserve modification times, access times, and modes from the original file
* `-q` = quiet mode, suppresses progress meter and non-error messages
* `-v` = verbose mode, provides detailed information about the transfer process

```bash
scp test.txt user@host:/path/to/remote/file # Copy test.txt to remote host
scp -r /local/dir user@host:/remote/dir # Recursively copy a directory to remote host
scp -P 2222 test.txt user@host:/path/to/remote/file # Copy test.txt to remote host using port 2222
scp -p test.txt user@host:/path/to/remote/file # Preserve file attributes while copying
scp -q test.txt user@host:/path/to/remote/file # Copy test.txt to remote host in quiet mode
scp -v test.txt user@host:/path/to/remote/file # Copy test.txt to remote host in verbose mode
```

Example output of `scp -v test.txt user@host:/path/to/remote/file`

```shell
Executing: program /usr/bin/ssh host scp -v -t /path/to/remote/file
OpenSSH_8.2p1, OpenSSL 1.1.1d  10 Sep 2019
debug1: Connecting to host [IP_ADDRESS] port 22.
debug1: Connection established.
debug1: identity file /Users/username/.ssh/id_rsa type 0
user@host's password:
debug1: Authentication succeeded (password).
Sending file modes: C0644 12345 test.txt
Sink: C0644 12345 test.txt
test.txt
```

## Important Notes

- **You will be prompted to enter password** for the remote user account on the remote host unless you have set up SSH keys for passwordless authentication or are using an alternative authentication method like kerberos.
- The **remote host must have SSH server running** and configured to accept connections.
- **You need necessary permissions** to read the source file and necessary permissions to write to the destination directory on the remote host.

# Netcat

`nc` The "Swiss Army Knife" of networking, is a tool for reading from and writing to network connections using TCP or UDP. It can be used for various tasks such as port scanning, banner grabbing, file transfers, and even creating simple chat applications.

Basic syntax: `nc [options] [hostname] [port]`

Common options:
* `-l` = listen mode, for inbound connections
* `-p` = local port number to bind to
* `-u` = use UDP instead of TCP
* `-zv` = zero-I/O mode, used for scanning (verbose)

# curl

`curl` is a commnad-line tool used to transfer data between a client and a server using various protocols like HTTP, HTTPS, FTP, etc. The best practice is to always use HTTPS unless instructed otherwise. For API testing, `curl` is often used with tools like `jq` to parse JSON responses.

Basic syntax: `curl [options] [URL]`

## Supported curl protocols:
* HTTP/HTTPS
* FTP/FTPS
* SMTP
* IMAP
* POP3
* LDAP
* more, see `curl --help` for a full list.

Common uses:
* `curl http://example.com` = fetch the content of a webpage
* `curl -O http://example.com/file.txt` = download a file from a URL
* `curl -o index.html http://example.com` = save the content of a webpage to a file named `index.html`
* `curl -I http://example.com` = fetch the HTTP headers of a webpage
* `curl -X POST -d "param1=value1&param2=value2" http://example.com/api` = Specifiy HTTP method (GET, POST, PUT, DELETE)
* `curl -H "Authorization: Bearer YOUR_TOKEN" http://example.com/api` = Add custom headers to the request
* `curl -L http://example.com` = Follow redirects
* `curl -u username:password http://example.com` = Use basic authentication
* `curl -k https://example.com` = Allow insecure SSL connections, not recommended for production use
* `curl --max-time 10 http://example.com` = Set a maximum time for the request to complete
* `curl --retry 3 http://example.com` = Retry the request up to 3 times on failure

And many more...
