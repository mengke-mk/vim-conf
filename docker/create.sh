set -x
docker run -itd  \
      --tmpfs /run --tmpfs /run/lock \
      --tmpfs /tmp --cap-add SYS_ADMIN --device=/dev/fuse \
      -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
      --security-opt apparmor:unconfined \
      $1 \
      /sbin/init 

