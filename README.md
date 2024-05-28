## AWS SSO Login script
Uses pre-configured AWS SSO profiles to login to AWS SSO accounts validating if session is still valid and refreshing it only if needed.

To configure a AWSS SSO see the run the `aws configure sso` command and follow the instructions. See the official doc to [learn more](https://docs.aws.amazon.com/cli/latest/userguide/sso-configure-profile-token.html#sso-configure-profile-token-auto-sso)

This will set a `sso-session` and a `profile` at your `~/.aws/config` file.

Export `AWS_SSO_SESSION_NAME` and `AWS_SSO_ACCOUNT_PROFILE` to your shell environment to use the script.

### Usage
Run on current shell sourcing the file to make sure the environment variables are set.
```bash
. path/to/script/aws_login.sh
```

An alias may be set
```bash
alias aws-login=". path/to/script/aws_login.sh"
```

### ZSH - P10k Prompt
AWS Expiration Time is exposed as a Env Var that may be used to show on ZSH Prompt

See [aws_expiration_prompt](./aws_p10k_sso_expiration_prompt.zsh) for that
