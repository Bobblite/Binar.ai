# Binar.ai

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Description
A image recognition API to predict 4-digit handwritten binary numbers and convert them into decimal numbers. The entirety of the project was initially hosted on AWS using Elastic Beanstalk, Sagemaker, Lambda, and Gateway. It has since been archived as a repository (the repository you're on right now!) for keepsake purposes.

## How To Use
As this is an archived version, none of the source code here actually runs and should be used as a reference if need be. Instead, here are the list of important files and what they contain:
1. model-tf.tar.gz - This is the pre-trained model saved and ready to be loaded.
2. Binarai.ipynb - This was the notebook containing the code to load and deploy the model. This notebook was initially deployed on AWS Sagemaker.
3. lambda_function.py - This was the code snippet initially deployed on AWS Lambda. This snippet prepares the image data (4 images encoded to base64) to be used as input via an API.
4. webapp - This directory contains the file for a dummy web application used to interface with the API.
5. research - This directory contains all the files pertaining to the research and development of the model.

