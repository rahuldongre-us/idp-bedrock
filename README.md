# idp-bedrock

Should have aws configure to use with CLI

## Installation 

```bash
  python --version
  python -m pip install boto3
```

```bash
    unzip terraform_*.zip
    sudo mv terraform /usr/local/bin/
    terraform -v
```
Ensure both Python and Terraform are installed.

### VS code steps.

 Click on the search window.
 
 ![Search](https://github.com/wasatchinfotech/idme-fed-auth/blob/main/images/vs1.jpg?raw=true)

 Select Python:Create Environment

 ![Python Selection](https://github.com/wasatchinfotech/idme-fed-auth/blob/main/images/vs2.jpg?raw=true)

 Select Environment Type
 
 ![Virtual Environment](https://github.com/wasatchinfotech/idme-fed-auth/blob/main/images/vs3.jpg?raw=true)

 Python Interpreter version selection.

 ![Python Version](https://github.com/wasatchinfotech/idme-fed-auth/blob/main/images/vs4.jpg?raw=true)

 VS Virtual Environment.
 
 ![Editor Venv](https://github.com/wasatchinfotech/idme-fed-auth/blob/main/images/vs5.jpg?raw=true)

 Project Structure.
 
 ![Project Structure](https://github.com/wasatchinfotech/idme-fed-auth/blob/main/images/vs5.jpg?raw=true)

 AWS Bedrock Model Access
 
 ![AWS Bedrock Model Access](https://github.com/wasatchinfotech/idme-fed-auth/blob/main/images/vs5.jpg?raw=true)

### Final Steps

    chmod +x aws-infra.sh 

    ./aws-infra.sh

    This should create AWS resources.

    To test locally

    aws lambda invoke --function-name <function-name> response.json

    Should be resulted, if no errors, in response.json with output. 

    {
        "StatusCode": 200,
        "ExecutedVersion": "$LATEST"
    }

    