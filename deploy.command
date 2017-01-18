#!/usr/bin/env bash

BUCKET_NAME="sls-website-sample";
PUBLIC_POLICY="public.json";

printf "enable Static Website Hosting.\n"
aws s3 website s3://${BUCKET_NAME} --index-document index.html

printf "put bucket policy.\n"

cat << EOF > ${PUBLIC_POLICY}
{
    "Version": "2012-10-17",
    "Id": "PublicRead",
    "Statement": [
        {
            "Sid": "ReadAccess",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${BUCKET_NAME}/*"
        }
    ]
}
EOF

aws s3api put-bucket-policy --bucket ${BUCKET_NAME} --policy file://${PUBLIC_POLICY}

printf "copy static files...\n"
aws s3 sync ./static s3://${BUCKET_NAME}/ --exclude ".DS_Store"

printf "deploy serverless project...\n"
cd ./functions
sls deploy
cd ..