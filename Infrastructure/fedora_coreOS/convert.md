
mkpasswd --method=yescrypt
docker run -i --rm quay.io/coreos/butane:release --strict < 1_basic.bu > 1_basic.ign
python3 -m http.server

sudo coreos-installer install /dev/sda --ignition-url http://192.168.1.8:8000/coreos.ign --insecure-ignition