# tf-unmanaged


Sample for an unmanaged instance group with 2 VMs, each one with a static public IP.

There is also an internal load balancer with a static IP pointing to the unmanaged instance group.

To test, ssh into client-vm and do:
socat STDIO TCP:[ILB ip]:800

