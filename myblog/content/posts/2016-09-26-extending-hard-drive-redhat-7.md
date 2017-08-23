---
title: 'Extending Hard Drive  RedHat 7'
author: Brett
type: post
date: 2016-09-26T05:19:53+00:00
url: /index.php/2016/09/26/extending-hard-drive-redhat-7/
categories:
  - Linux
tags:
  - Linux
  - Red Hat
  - rhel
  - Ubuntu

---
**Check current disk**<pre lang=linux> # fdisk -l Disk /dev/sda: 41.9 GB, 41943040000 bytes, 81920000 sectors Units = sectors of 1 \* 512 = 512 bytes Sector size (logical/physical): 512 bytes / 512 bytes I/O size (minimum/optimal): 512 bytes / 512 bytes Disk label type: dos Disk identifier: 0x000d1957 Device Boot Start End Blocks Id System /dev/sda1 \* 2048 1026047 512000 83 Linux /dev/sda2 1026048 81919999 40446976 8e Linux LVM </pre> 

**Extend Virtual disk**
  
Please see vendor for instrustions on how to do this.

**Partitioning the unallocated space: if you&#8217;ve increased the disk size**
  
Once you have extend the disk you will need to scan the device

Frist check the name(s) of your scsi devices.<pre lang=linux> ls /sys/class/scsi_device/ 0:0:0:0 2:0:0:0 </pre> 

Then rescan the scsi bus. Below you can replace the &#8216;0\:0\:0\:0&#8217; with the actual scsi bus name found with the previous command<pre lang=linux> echo 1 > /sys/class/scsi_device/0\:0\:0\:0/device/rescan </pre> 

**Partitioning the unalloced space: if you&#8217;ve added a new disk**

If you&#8217;ve added a new disk on the server, the actions are similar to those described above. But instead of rescanning an already existing scsi bus like show earlier, you have to rescan the host to detect the new scsi bus as you&#8217;ve added a new disk.<pre lang=linux> $ ls /sys/class/scsi_host/ host0 </pre> 

Your host device is called &#8216;host0&#8217;<pre lang=linux> $ echo "\- - -" > /sys/class/scsi_host/host0/scan </pre> 

**Create a new partition**

Once the rescan is done. You can check if the extra space can be seen on the disk.<pre lang=linux> # fdisk -l Disk /dev/sda: 53.7 GB, 53687091200 bytes, 104857600 sectors Units = sectors of 1 \* 512 = 512 bytes Sector size (logical/physical): 512 bytes / 512 bytes I/O size (minimum/optimal): 512 bytes / 512 bytes Disk label type: dos Disk identifier: 0x000d1957 Device Boot Start End Blocks Id System /dev/sda1 \* 2048 1026047 512000 83 Linux /dev/sda2 1026048 81919999 40446976 8e Linux LVM </pre> 

The server can now see the extra 10GB. Let&#8217;s create a partition<pre lang=linux> ~$ fdisk /dev/sda The number of cylinders for this disk is set to 1305. There is nothing wrong with that, but this is larger than 1024, and could in certain setups cause problems with: 1) software that runs at boot time (e.g., old versions of LILO) 2) booting and partitioning software from other OSs (e.g., DOS FDISK, OS/2 FDISK) Command (m for help): n </pre> 

Now enter &#8216;n&#8217;, to create a new partition.<pre lang=linux> Command action e extended p primary partition (1-4) p </pre> 

Now choose &#8220;p&#8221; to create a new primary partition<pre lang=linux> Partition number (3,4, default 3): 3 First sector (81920000-104857599, default 81920000): Hit Enter Using default value 81920000 Last sector, +sectors or +size{K,M,G} (81920000-104857599, default 104857599): Hit Enter Using default value 104857599 Partition 3 of type Linux and of size 11 GiB is set </pre> 

Now type **t** to change the partition type to Linux LVM<pre lang=linux> Command (m for help): t Partition number (1-4): 3 Hex code (type L to list codes): 8e Changed system type of partition 3 to 8e (Linux LVM) </pre> 

Type **w** to write your partitions to disk.<pre lang=linux> Command (m for help): w </pre> 

Run the following to scan for the newly created partition.<pre lang=linux> partprobe -s </pre> 

You can see the newly created partition with fdisk.<pre lang=linux> [root@localhost wrightb]# fdisk -l Disk /dev/sda: 53.7 GB, 53687091200 bytes, 104857600 sectors Units = sectors of 1 \* 512 = 512 bytes Sector size (logical/physical): 512 bytes / 512 bytes I/O size (minimum/optimal): 512 bytes / 512 bytes Disk label type: dos Disk identifier: 0x000d1957 Device Boot Start End Blocks Id System /dev/sda1 \* 2048 1026047 512000 83 Linux /dev/sda2 1026048 81919999 40446976 8e Linux LVM /dev/sda3 81920000 104857599 11468800 8e Linux LVM Disk /dev/mapper/rhel-root: 39.2 GB, 39220936704 bytes, 76603392 sectors </pre> 

**Extend the Logical Volime with the new partion**

Create the physical volume for your LVM<pre lang=linux> # pvcreate /dev/sda3 Physical volume "/dev/sda3" successfully created </pre> 

Find out what your Volume Group is called.<pre lang=linux> # vgdisplay \--- Volume group \--- VG Name rhel </pre> 

Extend that Volume Group by adding the physical volume.<pre lang=linux> # vgextend rhel /dev/sda3 Volume group "rhel" successfully extended </pre> 

With pvscan we can see our newly added physical volume<pre lang=linux> pvscan PV /dev/sda2 VG rhel lvm2 [38.57 GiB / 44.00 MiB free] PV /dev/sda3 VG rhel lvm2 [10.93 GiB / 10.93 GiB free] Total: 2 [49.50 GiB] / in use: 2 [49.50 GiB] / in no VG: 0 [0 ] </pre> 

Now we can extend Logical Volume<pre lang=linux> # lvextend /dev/mapper/rhel-root /dev/sda3 Size of logical volume rhel/root changed from 36.53 GiB (9351 extents) to 47.46 GiB (12150 extents). Logical volume root successfully resized. </pre> 

To resize the file system.<pre lang=linux> resize2fs /dev/mapper/rhel-root </pre> 

If you get the below error message you are using XFS FilesSystem<pre lang=linux> resize2fs /dev/mapper/rhel-root resize2fs 1.42.9 (28-Dec-2013) resize2fs: Bad magic number in super-block while trying to open /dev/mapper/rhel-root Couldn't find valid filesystem superblock. </pre> 

If you are using XFS Filesystem usage the below command to grow the file system.<pre lang=linux> # xfs_growfs /dev/mapper/rhel-root meta-data=/dev/mapper/rhel-root isize=256 agcount=4, agsize=2393856 blks = sectsz=512 attr=2, projid32bit=1 = crc=0 finobt=0 data = bsize=4096 blocks=9575424, imaxpct=25 = sunit=0 swidth=0 blks naming =version 2 bsize=4096 ascii-ci=0 ftype=0 log =internal bsize=4096 blocks=4675, version=2 = sectsz=512 sunit=0 blks, lazy-count=1 realtime =none extsz=4096 blocks=0, rtextents=0 data blocks changed from 9575424 to 12441600 </pre> 

Finished!!