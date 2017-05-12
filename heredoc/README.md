These instructions are for setting up a Continuum Automate environment with the ability to download code from git, run some processes such as compiles or tests. 

This sample also covers a topic called a "here document" running a bash script. This is the recommended way to run a batch of commands on linux over ssh. 

For more on here documents, see the following link:

http://tldp.org/LDP/abs/html/here-docs.html

Tutorial Steps:

1. Create an Asset named "localhost" with ssh credentials. 

Even though Automate will be logging into itself, it will do so using ssh. Create an Asset in Automate with the name localhost, address "localhost" and whatever login credentials that can ssh in. I would suggest for the purposes of POC and for this example use "continuum". 

Relevant documentation:

https://community.versionone.com/VersionOne_Continuum/Continuum_Automate/Tasks/Continuum_Automate_Task_Assets

2. Install "git" client on the machine. Since you will be pulling software down from git you will want the client installed. 

Instructions:

https://git-scm.com/book/en/v2/Getting-Started-Installing-Git

3. For this sample, git will clone an open source repository, read only. However for most internal IT project, you will need to have credentials set for the git client. If this is the case, setup your git client config so that credentials are built in (i.e. not prompted for). There are other ways of doing it such as storing the credentials in Continuum, but doing them with git config in the client is easiest for now. You should be able to go to /tmp and clone a repo that you are targeting. Once successful go ahead and remove it, that was a test only. 

The following link is helpful for setting up the git client credentials, it may be a little different if not using GitHub. 

https://help.github.com/articles/set-up-git/

4. Import the sample task in this tutorial. The easiest way will be to import using the following instructions. 

Navigate to Automate, Import a Backup File. In the "Enter a URL" box paste the following link:

jjjjj

Click Load, then Import. Edit the Task. 

5. View the task and understand the steps. 

6. Run the task using the Run tab, Run button then Run Now. A log will popup, resolve any errors with connectivity or otherwise and try again. 

7. Now make a copy of the task and modify it to suite your needs. 

