Example - SSH Linux
=============

This example shows how to establish a new connection to an linux box using ssh and how to issue a commands to the target shell and parse the results.

The New Connection command has a connection type called ssh. This connection type accepts parameters for the userid, password or user id and shared credential and address of the machine to connect to.

Prerequisites
-------------

You must have a linux instance that has ssh enabled and port 22 accepting traffic. You will also need a local username and password or a user name and private key for this machine.

Also, if your linux server requires that public key authentication be used, you must setup your private key in ClearCode as a `Shared Credential`.  See Managing Shared Credentials for more information on setting up SSH Private Keys in ClearCode.

Importing the Task
------------------

Import the example task into Automate using the Task, Import a Backup File menu choice. Paste the following link into the "Enter a URL:" box, then click "Load", then "Import".

https://raw.githubusercontent.com/clearcode-labs/automate-samples/master/linuxssh/Example-SSH-Linux.json

Walkthrough
-----------

Once the tasks have been imported, you may notice Comments in the task or Notes on individual steps. Refer to these as well. 

The first step checks that either a password or shared credential name has been passed in as a parameter to the task at run time. The task will error out with the message seen in the box. 

The next `If` command runs one `New Connection` command or the other based on whether a shared credential or password is used. The New Connection command will attempt to establish a SSH connection to the target address given the credentials provided. It the shared credential value is used, it will use the private key as part of the authentication.

For a complete list of connection parameters and more information on the New Connection command see (New Connection)[https://github.com/cloudsidekick/cato/wiki/task-command-reference#new-connection].

The next command in the `Command Line` command. The Connection box has the named connection alias defined in the first step. The Command box has the linux command line command to pass over the wire. This first Command Line example is an example of what is called a "Here Document" redirected to the bash shell. Here Documents allow you to pass multiple lines-worth of commands to the target shell and have them execute immediately. Here Documents can also be used to write multiple lines to a file using redirection. 

Click on the Options button at the bottom of the command. There are three optional fields for the Command Line command. The timeout value is in seconds. The default for this command is 20 seconds. If the timeout value is triggered, the task will error. The Positive and Negative Response override the default values internal to the Task Engine in what it looks for when trying to figure out if the command sent is finished on the target. Now would be a good time to discuss how the Command Line command works behind the scenes. 

When the Task Engine sends a Command Line command to the target shell, it uses an open source library called Expect. The command is sent, then the Task Engine waits for one of three things to happen: a positive response, a negative response or a timeout. 

When the Task Engine logs into the target using SSH it immediately resets the shell prompt to "PROMPT>". Every command it issues it waits for the string "PROMPT>" to come back from the target. When it gets the prompt back, it puts everything after the send command (plus an appended newline) up to the prompt string into a **buffer**. More on the buffer processing later. 

If the Command Line command needs to interact with an application on the target box, the prompt may be different. This is where you can override the expected prompt by putting the prompt into the "Positive Response" option. Regular expressions can be used. 

For example, if you are interacting with a program that prompts for an ip address with a space and colon and another space, you would put the following in the Positive Response input field:

    Ip Address : $

Where the dollar sign is the regular expression for end of line. 

The Negative Response is never matched unless it is overridden for a Command. If you want to watch the output and immediately end the task when a particular string is matched, enter it in the Negative Response field. Again, regular expressions can be used. 

The use of Negative Respone is rare.

For long running commands, make sure to set the timeout value higher than it needs to be for the command to finish. 

In the next step we again use the Command Line command. This time it is a single "ls" command. In step 2, we created files in /tmp. In step 3 we are listing the files and capturing the output into variables. 

Click on the `Variables` button on the bottom of the step. You will see that the "filename" variable is being populated. Click on `Manage Variables`. The Manage Variables box will popup and display the Row and Column delimiters (both line feed aka newline) in this case. The filename variable is populated from the results of column 1. 

This tells the Task Engine buffer processor to chop the output into rows and columns. This example shows that each row will be considered the whole column 1 (because the row delimiter and column delimiter are equal). Options for buffer processing could include not specifying a row delimiter which would chop the output up into a single row, multiple column output. Positional and Regular expression processing is also available.

In this case we are populating the filename variable with the list of filenames that where created in the previous step. This will actually create an array named filename which we can then spin through and process. 

The next step is a `Loop` that uses the count of the elements in the filename array to determine the upper ceiling of the loop. Inside the loop, another Command Line command is called which removes the file we created two steps prior.

Run the task and provide the address of the target linux machine with the username and password or shared credential of the private key. If the connection takes more than a couple of seconds (make sure to click the refresh button), click on the "view logfile" link in the upper right side of the Task Run window. You should see the output of the actual task run log with any behind the scenes output. Possible problems will be incorrect username, address, password, or something with the Shared Credential setup. 
