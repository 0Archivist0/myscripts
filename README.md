# myscripts
Inside these files are scripts that were wrote for verious reasons

## 1) auto-iso 
  -This script creates a custom bootable ISO image of Ubuntu by downloading a minimal Ubuntu image, removing unneeded files, adding a 
  provided Bash script, and building a custom bootable ISO image. The script also installs the xorriso package as a dependency, which is required
  for creating the ISO image. The resulting ISO image includes a custom boot option that can be selected during boot.

  After creating the ISO image, the script tests for the existence of a specified file. If the file exists, it runs the script; if it doesn't exist,
  it opens a Bash session for the user. The user can customize the variables at the top of the script to fit their specific needs, such as ISO_NAME, 
  MOUNT_DIR, ISO_DIR, SCRIPT_NAME, and FILEPATH.
 
 ## 2) spam-filter
    -This is a shell script that filters emails by moving them to different folders based on certain conditions. Here's what it does:

    Changes directory to the /var/mail/ folder.
    Defines a whitelist of safe email addresses or domains.
    Creates a log file at /var/log/spam-filter.log and logs the start time.
    Redirects all output to the log file.
    Loops through each mailbox in the current directory.
    Changes directory to the current mailbox.
    Loops through each email in the current mailbox.
    If the email is in the whitelist, it moves the email to the inbox folder.
    If the email is not in the whitelist, it checks if it is spam or junk.
    If the email is spam/junk, it moves the email to the spam folder.
    If the email is not spam/junk and not in the whitelist, it moves the email to the inbox folder.
    Changes directory back to the mail directory.
    Logs the end time in the log file.
