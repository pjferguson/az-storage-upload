<<<<<<< HEAD
git push origin main
=======
#!/bin/bash
files=("$@")


function user_input {
    while [[ -z $files ]]; do
        echo "Please enter the files you would like to upload. Press 'Q' to quit."
        read files 
        if [ "$files" == "Q" ]; then
            exit 1
            else
            files=($files)
        fi
    done
}

# Checking to see number of storage accounts
function which_account {
    storage_accounts=($(az storage account list --query "[].name" -o tsv))
    if [ ${#storage_accounts[@]} -eq 1 ]; then
        storage_account=${storage_accounts[0]}
    else
        az storage account list --output table
        echo "Which storage account would you like to upload this file to?"
        read storage_account
    fi
    which_container
} 

#Checking to see number of containers
function which_container {
    containers=($(az storage container list --account-name $storage_account --query "[].name" -o tsv))
    if [ ${#containers[@]} -eq 1 ]; then
        container=${containers[0]}
    else
        az storage container list --account-name $storage_account --output table
        echo "Which container would you like to get this file uploaded to?"
        read container
    fi
}

#Checking that the file exists locally
function validate_files {
    for file in "${files[@]}"; do 
        if [[ -f "$file" ]]; then
            continue
        else
            echo "Please make sure that ALL files exist locally :(!"
            exit 1
        fi
    done
}

#Uploading the file
function upload_file {
    for file in "${files[@]}"; do 
        az storage blob upload --account-name $storage_account --container-name $container --file $file --name $file
        checking_errors $?
    done
}

# Checking for errors
function checking_errors {
    if [ $1 -eq 0 ]; then
        for file in "${files[@]}"; do 
         echo "Your file: $file has been uploaded successfully!"
        done
    else
        echo "There was an error uploading the file. Please try again."
    fi
}

# Generate a random password
function generate_password {
    password=$(openssl rand -base64 32)
    echo $password > blob-storage-password.txt
}

# Encrypt the file
function encrypt_file {
    for file in "${files[@]}"; do 
        password=$(generate_password)
        openssl enc -aes-256-cbc -salt -in $file -out $file.enc -pass pass:$password
        echo "The file: "${file}" has been encrypted successfully!"
    done
}

# Uploading the encrypted file
function upload_encrypted_file {
    for file in "${files[@]}"; do 
        az storage blob upload --account-name $storage_account --container-name $container --file $file.enc --name $file.enc
        checking_errors $?
        # Remove the encrypted file after upload
        rm $file.enc
    done
}
function upload_encrypted_files {
    for file in "${files[@]}"; do 
        az storage blob upload --account-name $storage_account --container-name $container --file $file.enc --name $file.enc
        checking_errors $?
        rm $file.enc
    done
}



user_input
az login
which_account
validate_files
echo "Do you want to use encryption? (yes/no)"
read use_encryption

if [ "$use_encryption" == "yes" ]; then
    if [ ${#files[@]} -eq 1 ]; then 
        encrypt_file
        upload_encrypted_file 
    else
        upload_encrypted_files 
    fi
else
    upload_file 
fi
>>>>>>> 043d797ba27fac7089db8f8a4e18582dbc4a0aeb

