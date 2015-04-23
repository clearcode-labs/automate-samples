automate-samples
==========

Example Tasks for ClearCode Automate

This repo contains sample Tasks that can be used as a tutorial for learning Automate Task development. 

Each directory has a README file which will walk you through the sample Task. 

To import these samples you can either import them at the command line or via the ClearCode user interface.

**Import All at the Command Line** 

NOTE: this option works on OSX and Linux, not Windows

Clone this repo locally on the ClearCode linux server from GitHub.

    cd $HOME
    git clone git://github.com/clearcode-labs/automate-samples.git

Make sure you have the `.cclclient.conf` file setup properly. Refer to the installation instructions you received.

Then change into the `automate-samples` directory and run the import script. 

    cd automate-samples
    ./import_all.sh

**Import Select Task Samples at Command Line**

Follow the previous instructions for cloning the sample repo up to the point where you run the import_all_.sh script. Instead change into the directory that contains the task you want to import and run the following command example. 

    cd winrm
    ccl-import-backup --force -f Example-Winrm.json

**Import Through the User Interface**

Import the task files individually directly from Github.

    On the Github website, drill into an example directory, such as looping. 
    
e.g.:

    https://github.com/clearcode-labs/automate-samples/tree/master/looping

Click on the `.json` file found in the directory.  
    
e.g.:

    Example-Looping.json

On this page, click the `Raw` button right above the code. This will redirect you to the raw json file representing the task. 

    https://raw.github.com/clearcode-labs/automate-samples/master/looping/Example-Looping.json

Copy the link out of your browser's address field. 

Then in Automate go to `Tasks`, `Import a Backup File`.  Paste the raw url to the file in the URL input box and press enter. The big box in the middle should populate with json. 

Next click the `Import` button. 

**Final Thoughts**

Regardless of which option is used, you can now edit and run the task in your environment. Refer to the README file in each directory for the task walkthrough. 

Please send suggestions / questions to support@clearcodelabs.com
