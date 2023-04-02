in the two folders are scripts for makeing ubuntu iso files to fit the <> statment 


<I need to create a bootable ISO or ramdisk. The resulting image needs to be bootable from the C KVM API, and meet the following requirements:

1. Needs to be self-contained (no dependencies)  and bootable.
2. Needs to run a Bash script as the last part of the boot process, using root account. No additional configurations. No installations, just live ISO. Just boot into the Bash script  automatically (DEFAULT BASH).  The script needs to be stored within the ISO.
3. The image needs to be based on some recent version of Ubuntu, with fairly recent versions of packages.
4. Please get rid of any desktop, unnecessary software. Just terminal. It needs to be as small as possible, preferably less than 500MB
5. The Bash script, run as the last part of the boot process, needs to do the following:
A. Tests if a file $FILEPATH exists
B. If the file $FILEPATH exists, print message "File $FILEPATH exists, running." and run it
C. If the file doesnt exists, print message "File $FILEPATH doesnt exist", and run regular Bash session for the user as the last step of the boot process.
Obviously, all needs to be open-source. No license restrictions.

Deliverables:
1. ISO / ramdisk image file, bootable from the C KVM API, no libvirt, just pure C KVM API
2.  Building script, which builds the ISO, or -- if this is preferred - detailed documentation showing how to build the ISO, and then how to run it, in order to test
3.  When reviewing the work, the build script (or the docs) will be used in order to build the image and verify.>

folder one is called draft scripts and folder two contains the final script with a read me to instruct on how to use it

