Ref: https://discussion.fedoraproject.org/t/beginners-guide-to-fedora-coreos/143037
1. Generate RSA SSH key
2. mkpasswd --method=yescrypt
3. docker run -i --rm quay.io/coreos/butane:release --strict < 1_basic.bu > 1_basic.ign
4. python3 -m http.server

5. sudo coreos-installer install /dev/sda --ignition-url http://192.168.1.8:8000/coreos.ign --insecure-ignition