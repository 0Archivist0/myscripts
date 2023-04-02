Automated Email Spam Filter

This script is designed to automate the filtering of spam emails in your inbox. Before running the script, there are a few things you need to do:

   1) Update the whitelist: The script contains a WHITELIST array variable that lists safe email addresses/domains. You should update this array with your own safe email addresses/domains. For example, if your email domain is example.com, you can add it to the whitelist like this:

    WHITELIST=("example.com")

    2)Update the mail directory: The script assumes that the mail is stored in the /var/mail/ directory. If your mail is stored in a different directory, you should update the cd command at the beginning of the script to point to your mail directory.

    3)Update the destination folders: The script moves spam/junk emails to a .spam/ folder and safe emails to a .inbox/ folder. If you want to use different folder names or locations, you should update the mv commands in the script accordingly.

After making these changes, make sure to make the script executable by running the following command:

sudo chmod 755 spam-filter.sh

Then, to run the script, simply execute the following command:

sudo ./spam-filter.sh

Note: The script logs its output to /var/log/spam-filter.log, so you can review this file to see the results of the script.


