# My Cloud Resume Challenge (Back-End)

Welcome to my Cloud Resume Challenge implementation! This repository showcases my skills in cloud computing, infrastructure as code, and web development through the creation of a cloud-based resume website.

## About the Project

The Cloud Resume Challenge, created by Forrest Brazeal, provides a practical opportunity to demonstrate proficiency in various technologies and services. In my implementation, I utilized the following tools and frameworks:

- **AWS (Amazon Web Services)**: I chose AWS as my cloud provider for its comprehensive suite of services and robust infrastructure.

- **Serverless Framework**: I leveraged the Serverless Framework to define and deploy serverless resources for my website. It simplifies the management of AWS resources and promotes scalability.

- **Terraform/Terraform Cloud**: I utilized Terraform, a cloud-agnostic cloud automation tool to provision my front-end resources in AWS.

- **GitHub Actions**: Configured Github Actions for CI/CD implementation. Changes commited on the main branch are automatically deployed to my website.

## Serverless Infrastructure Used

- **AWS DynamoDB**: DynamoDB was used to store visitor count on my website

- **AWS Lambda**: Updating the database's visitor count is done by invoking serverless lambda function

- **AWS API Gateway**: API Gateway is used to invoke my lambda function to update the dynamodb visitor count

## Domain Provider

- **Go Daddy**: Purchased a domain name in godaddy to be used for my CloudFront and API Gateway domain name

## Conclusion

Thank you for visiting my Cloud Resume Challenge implementation! I hope this project effectively showcases my cloud skills and demonstrates my ability to develop a professional online presence. Feel free to explore the code, make suggestions, or reach out if you have any questions.

## Cloud Resume Link

[Link to my Cloud Resume](https://resume.arfeljunvelasco.live)
