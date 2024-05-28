  function prompt_aws_credentials_expiration() {
      if [ -z ${AWS_CREDENTIAL_EXPIRATION+x} ];
        then return;
      fi
      startTimeSeconds=$(date -jf "%Y-%m-%dT%H:%M:%S%z" $(echo ${AWS_CREDENTIAL_EXPIRATION%:*}${AWS_CREDENTIAL_EXPIRATION##*:}) +%s)
      endTimeSeconds=$(date +%s)
      diffSeconds="$(($startTimeSeconds-$endTimeSeconds))"
      d=$((diffSeconds))
      local isNegative=$((d < 0))
      local text="$((d % 60))s"
      if (( d >= 60 || d <= -60 )); then
        text="$((d / 60 % 60))m $text"
        if (( d >= 3600 || d <= -3600 )); then
          text="$((d / 3600 % 24))h $text"
          if (( d >= 86400 || d <= -86400 )); then
            text="$((d / 86400))d $text"
          fi
        fi
      fi
      # 208 if positive, red if negative
      foreground=$((isNegative ? 160 : 208))
      icon=$isNegative ?  : 
      p10k segment -i  -f $foreground -t "$icon $text"
  }
