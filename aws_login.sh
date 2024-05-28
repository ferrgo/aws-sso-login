#!/bin/bash
if [[ -z "$AWS_SSO_SESSION_NAME" || -z "$AWS_SSO_ACCOUNT_PROFILE" ]]; then
    echo "Please set the AWS_SSO_SESSION_NAME and AWS_SSO_ACCOUNT_PROFILE environment variables"
else
    echo "AWS_SSO_SESSION_NAME: $AWS_SSO_SESSION_NAME"
    echo "AWS_SSO_ACCOUNT_PROFILE: $AWS_SSO_ACCOUNT_PROFILE"
    
    # Check if still logged in and only export credentials
    if aws sts get-caller-identity --query "Account" --profile $AWS_SSO_ACCOUNT_PROFILE;  then 
        echo "[AWS_SSO_LOGIN] Session still valid" ;
    else 
        echo "[AWS_SSO_LOGIN] Logging in..."
        aws sso login --sso-session $AWS_SSO_SESSION_NAME
    fi
    echo "[AWS_SSO_LOGIN] Exporting credentials"
    eval $(aws configure export-credentials --profile $AWS_SSO_ACCOUNT_PROFILE --format env)
    echo "This session wil expire at: $AWS_CREDENTIAL_EXPIRATION"
fi
