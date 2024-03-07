# AZ-Blob-Tool
This Bash script provides a streamlined process for uploading files to Azure Blob Storage. It iterates over an array of files, uploading each one to a specified storage account and container. Before uploading, each file is encrypted if neccessary, enhancing the security of your data. After successful upload, the encrypted local copy of the file is removed, ensuring your local environment remains clean. The script includes error checking after each upload to provide immediate feedback on the success of the operation. 

## Prerequisites 
1. Make sure that you have a Microsoft Azure Account, if you don't have one you can sign up for one through Microsoft: https://azure.microsoft.com/en-us/.
2. Blob storage resource is needed to store the files on Azure. 
3. AZ CLI must be installed in terminal. https://learn.microsoft.com/en-us/cli/azure/install-azure-cli 
4. OpenSSL must be installed to use encryption. 
5. Bash Shell. 

## Installation
1. Install this repo locally:
``` 
git clone https://github.com/Pferguson7/azure-storage-upload-cli
```
2. Change permissions: 
```
chmod 755 blob-storage.sh
```
3. To make the script executable from any directory: 
``` 
mv /path/to/blob-storage.sh /usr/local/bin/
```
 - Replace ''path/to/bin/blob-storage.sh'' with the full path to the file on your local system. 
## Usage 
```
./blob-storage.sh <filename1> <filename2>
```

## Troubleshooting 
1. Verify Azure CLI Installation
 - Verify that AZ CLI is installed, also verify that you have the proper permissions

2. Check Azure Resources
 - For proper execution blob storage needs to be one of your rersources. If you have the storage resource also verify that you have the permissions to use the current containers. 

3. Update the script
 - Check for updates in the repo. Updates will be made soon. 
