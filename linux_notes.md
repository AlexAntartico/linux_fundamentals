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