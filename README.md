# UbuntuP-GameOver(Lay)
Using CVE-2023-2640 CVE-2023-3262 to escalate previlege

### CVE 2023-2640
https://nvd.nist.gov/vuln/detail/CVE-2023-2640 

On Ubuntu kernels carrying both c914c0e27eb0 and "UBUNTU: SAUCE: overlayfs: Skip permission checking for trusted.overlayfs.* xattrs", an unprivileged user may set privileged extended attributes on the mounted files, leading them to be set on the upper files without the appropriate security checks.


### CVE 2023-32629
https://nvd.nist.gov/vuln/detail/CVE-2023-32629

Local privilege escalation vulnerability in Ubuntu Kernels overlayfs ovl_copy_up_meta_inode_data skip permission checks when calling ovl_do_setxattr on Ubuntu kernels

### Vulnerable Kernel version
Ubuntu `6.2.0`, `5.19.0` and `5.4.0`

### Usage
```sh
./exp.sh
```
Running the script in a low privilege will get you root access.
Tested on Ubuntu version 5.19.0, 5.4.0 and 6.2.0

### Example
![image](https://github.com/SanjayRagavendar/Ubuntu-GameOver-Lay/assets/91368803/98af437d-1d2e-4e60-a130-0c3d4755f6b0)
