#!/bin/bash

#USAGE: First Argument is MFA ARN (from My Security Credentials page), Second is Role you want to assume ARN, Third is your token code from your authenticator.
#./awsMFAAssumeRole.sh arn:aws:iam::111122223333:mfa/username 123456

AWS_PAGER="" #Do not block console with command output

echo -e "\033[0;31mRun this with '.' or 'source'\n\033[0;37m"

echo "Fetching session token..."
SESSION_TOKEN=$(aws sts get-session-token --serial-number $1 --token-code $2)

export AWS_ACCESS_KEY_ID=$(echo $SESSION_TOKEN | jq -r .Credentials.AccessKeyId)
export AWS_SECRET_ACCESS_KEY=$(echo $SESSION_TOKEN | jq -r .Credentials.SecretAccessKey)
export AWS_SESSION_TOKEN=$(echo $SESSION_TOKEN | jq -r .Credentials.SessionToken)
