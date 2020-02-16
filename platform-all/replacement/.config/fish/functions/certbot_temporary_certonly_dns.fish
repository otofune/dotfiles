function certbot_temporary_certonly_dns
  if test (count $argv) -ne 1
    echo "You need to pass one domain only"
    return 1
  end
  jd  -C 'mkdir certificates' \
      -C 'mkdir logs' \
      -c "docker run \
        --mount type=bind,src=(pwd)/certificates,dst=/workspace/config \
        --mount type=bind,src=(pwd)/logs,dst=/workspace/logs \
        --user (id -u):(id -g) \
        --register-unsafely-without-email \
        -it --rm \
        certbot/certbot \
          --config-dir /workspace/config \
          --logs-dir /workspace/logs \
          --work-dir /tmp \
          certonly \
          --manual --preferred-challenges dns \
          --domain $argv"
end
