#!/usr/bin/env bash

aws_config=$(cat ~/.aws/config)

profile_regex_pattern="^\[(.*) (.*)\]"
profiles=()
sso_session_names=()
while read p; do
  if [[ $p =~ $profile_regex_pattern ]]; then
    if [[ ${BASH_REMATCH[1]} == "profile" ]]; then
        profiles+=(${BASH_REMATCH[2]})
    fi
    if [[ ${BASH_REMATCH[1]} == "sso-session" ]]; then
        sso_session_names+=(${BASH_REMATCH[2]})
    fi
  fi
done <~/.aws/config

echo "AWS profiles:"
for profile in "${profiles[@]}"; do
  echo "  $profile"
done
echo "AWS SSOSession profiles:"
for sso_session_name in "${sso_session_names[@]}"; do
  echo "  $sso_session_name"
done
