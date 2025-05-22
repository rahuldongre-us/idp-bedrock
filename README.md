# Intelligent Document Processing 

Intelligent Document Processing with Amazon Bedrock and Anthropic Claude

Amazon Bedrock is a fully managed service that provides access to high-performing foundation models (FMs) from leading AI companies, including Anthropic's Claude 3 model family. Anthropic's Claude 3 models, such as Opus, Sonnet, and Haiku, excel at understanding complex enterprise content, including charts, graphs, technical diagrams and reports. 

By integrating Claude 3 Sonnet with Amazon Bedrock, organizations can automate intelligent document processing (IDP) workflows at scale. This integration enables the extraction of valuable insights from unstructured content—such as documents, images, video, and audio—transforming them into structured formats for further analysis and decision-making.

This serverless architecture leverages the scalability and cost-effectiveness of AWS services while harnessing the cutting-edge intelligence of Anthropic Claude 3 Sonnet. By combining the robust infrastructure of AWS with Anthropic’s foundation models, this solution enables organizations to streamline their document processing workflows, extract valuable insights and enhance overall operational efficiency.

This project will run serverless lambda which access S3 bucket created by Terraform, invoke Bedrock model to generate data from image.

## 🚀 Features

- 🧾 Document Understanding via Claude 3 Sonnet (Amazon Bedrock)
- ☁️ Fully Serverless architecture (S3, Lambda)
- 📄 Input: Scanned or uploaded documents
- 🧠 Output: Structured JSON with key-value data
- 🔁 Real-time, event-driven data flow

- 🧩 Plug-and-play for document-heavy workflows (finance, legal, healthcare)

## 💼 Use Cases

-  Invoice automation
-  Contract analytics
-  Healthcare forms processing
-  KYC & compliance document workflows
-  Back-office document digitization

## Run Locally

Clone the project

```bash
  git clone https://github.com/rahuldongre-us/idp-bedrock.git
```

Go to the project directory

```bash
  cd idp-bedrock
```

## Installation 

Ensure both Python and Terraform are installed.

```bash
  python --version
  python -m pip install boto3
```

```bash
  unzip terraform_*.zip
  sudo mv terraform /usr/local/bin/
  terraform -v
```

### VS code steps.

 Click on the search window.
 
 ![Search](https://github.com/wasatchinfotech/idme-fed-auth/blob/main/images/vs1.jpg?raw=true)

 Select Python:Create Environment

 ![Python Selection](https://github.com/wasatchinfotech/idme-fed-auth/blob/main/images/vs2.jpg?raw=true)

 Select Environment Type
 
 ![Virtual Environment](https://github.com/wasatchinfotech/idme-fed-auth/blob/main/images/vs3.jpg?raw=true)

 Python Interpreter version selection.

 ![Python Version](https://github.com/wasatchinfotech/idme-fed-auth/blob/main/images/vs4.jpg?raw=true)

 Project Structure.
 
 ![Project Structure](https://github.com/rahuldongre-us/idp-bedrock/blob/main/assets/project-structure.png?raw=true)

 AWS Bedrock Model Access
 
 ![AWS Bedrock Model Access](https://github.com/rahuldongre-us/idp-bedrock/blob/main/assets/aws-bedrock-model-access.png?raw=true)


## Deployment

Should have aws configure to use with CLI

To deploy this project run

Run following command on the project root.

This should create AWS resources.
```bash
  chmod +x aws-infra.sh 
  ./aws-infra.sh
```

To test locally, should generate response.json file with results.

```bash
 aws lambda invoke --function-name <function-name> response.json
  {
      "StatusCode": 200,
      "ExecutedVersion": "$LATEST"
  }
``` 
## Documentation

AWS Bedrock - [AWS Bedrock](https://aws.amazon.com/bedrock/)

Terraform - [Terraform](https://developer.hashicorp.com/terraform) 

AWS Blogs - [AWS Blogs](https://aws.amazon.com/blogs/machine-learning/)

 
    
