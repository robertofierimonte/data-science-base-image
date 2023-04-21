# Data Science Base Image

Base Docker image for CI/CD Data Science workflows.
  
Author: [Roberto Fierimonte](mailto:roberto.fierimonte@gmail.com)

This project aims to provide a reproducible environment against which to run Data Science tests and workflows.

## How to use the image

1. Create a `.env` file by coping the example provided: `cp .env.example .env`
2. Fill the required environment variables in the `.env` file
3. Login into Dockerhub: `make login`
4. Build the image: `make build-image`
5. Push the image: `make push-image`