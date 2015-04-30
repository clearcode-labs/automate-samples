Example - EC2 Windows
=============

This example will show you how to use AWS EC2 to automate Windows Server 2012 processes.

It also will illustrate the use of the features:

* AWS EC2 API interaction
* EC2 Security Group creation, ingress and deletion
* EC2 run instances and terminate instances
* EC2 Windows userdata boot script
* Extracting data from XML in variables
* Windows Remote Management (winrm) and firewall setup
* Remotely enabling IIS
* HTTP command smoke test
* Codeblocks


Prerequisites
-------------

This tutorial assumes that you are familiar with Amazon AWS EC2, have an account and have access to the AWS Console. Certain information will need to be gathered before starting this tutorial:

* AWS API key and secret key with the ability to start and terminate EC2 instances, create and delete security groups
* Select an EC2 Region (default in walkthrough is us-east-1)
* A Windows Server 2012 base image in that region (default in walkthrough is ami-cc93a8a4 in us-east-1)

> NOTE: In this tutorial we will use EC2 Classic Security Groups for simplicity's sake (not VPC)

Setup Cloud Credentials
-----------------------

Before beginning with importing and running the task, you must setup the AWS credentials in ClearCode. See http://docs.clearcodelabs.com/docs/automate/cloud/cloud-account.html


Importing the Task
------------------

Import the example task into Automate using the Task, Import a Backup File menu choice. Paste the following link into the "Enter a URL:" box, then click "Load", then "Import". 

https://raw.githubusercontent.com/clearcode-labs/automate-samples/master/ec2winrm/Example-EC2-Windows.json

Walkthrough
-----------

Once the task has been imported, you may notice Comments in the task or Notes on individual steps. Refer to these as well. 

Step one setups up from variables to use. If you want to use another region and/or AMI or size, change that here. 

> NOTE: This sample uses EC2 Classic Security Groups. If you change the instance type to one that does not support Classic Security Groups, the task may not run properly and will need alterations outside of the scope of this sample.

Step two generates a random 8 character string. This will be used as part of the EC2 security group that is created.

The next three steps create a security group, define it's inbound ports and start a virtual machine.

Next the "instanceId" from the RunInstances is extracted from the RunInstances response. This will be used for subsequent API calls. The next step outputs it to the log.

Next the task enters the codeblock "wait_for_boot". A codeblock is a subroutine within the task. The logic in this codeblock spins through a loop calls another codeblock. Inside this codeblock the EC2 DescribeInstance command is called using the instance id. If the EC2 Instance's DNS Name value is setup, the loop is broken out of. Otherwise there is a sleep and it tries again. At anytime if the boot of the instance fails, the task Errors. 

Returning to the MAIN codeblock, the logic tests for the WinRM http service to come online. There are also sleeps spinkled into the logic since it takes a while for the EC2 userdata boot script to run, processes to start and come online, etc. 

Once the WinRM service is responding, the `New Connection` command is used to establish authentication with the WinRM endpoint. Next a WinRM session is used to install IIS and .NET using Windows command line commands. Then the WinRM connection is disconnected.

Then next few commands are used to test that IIS came up properly. An `If` command is used to test the response body for a specific string pattern in the response. If the pattern exist, all is well. Otherwise things aren't well. In this example we are simply printing to the log the result. However typically this could be used to trigger further automation or alerts. 

Lasltly the task cleans up the EC2 resources created. A sleep is used before deleting the security group because the security group cannot be deleted until the instance is terminated. However this could also be another series of instance status checks to wait until the status is "terminated" then delete the security group.

Running
-------

Run this task without making modifications first. Then if desired, change the region and image AMI. Or, add in your own WinRM logic. 

> NOTE: this is a basic task with little error handling. If the task errors out it may leave EC2 resources in place and you will need to clean them up using the AWS console. Error handling is out of the scope of this tutorial. 
