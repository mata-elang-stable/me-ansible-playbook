#!/bin/bash

# Define URL
url_list=(
    https://corretto.aws/downloads/latest/amazon-corretto-11-x64-linux-jdk.tar.gz
    https://download.docker.com/linux/static/stable/x86_64/docker-20.10.9.tgz
    https://download.docker.com/linux/static/stable/x86_64/docker-rootless-extras-20.10.9.tgz
    https://github.com/docker/compose/releases/download/v2.14.2/docker-compose-linux-x86_64
    https://dlcdn.apache.org/hadoop/common/hadoop-3.3.4/hadoop-3.3.4.tar.gz
    http://security.ubuntu.com/ubuntu/pool/universe/s/shadow/uidmap_4.8.1-1ubuntu5.20.04.4_amd64.deb
    https://github.com/docker/docker-py/releases/download/6.0.1/docker-6.0.1-py3-none-any.whl
    https://files.pythonhosted.org/packages/8f/7b/42582927d281d7cb035609cd3a543ffac89b74f3f4ee8e1c50914bcb57eb/packaging-22.0-py3-none-any.whl
    https://github.com/urllib3/urllib3/releases/download/1.26.13/urllib3-1.26.13-py2.py3-none-any.whl
    https://files.pythonhosted.org/packages/f7/0c/d52a2a63512a613817846d430d16a8fbe5ea56dd889e89c68facf6b91cb6/websocket_client-0.59.0-py2.py3-none-any.whl
    https://github.com/psf/requests/releases/download/v2.28.1/requests-2.28.1-py3-none-any.whl
    https://files.pythonhosted.org/packages/db/51/a507c856293ab05cdc1db77ff4bc1268ddd39f29e7dc4919aa497f0adbec/charset_normalizer-2.1.1-py3-none-any.whl
    https://files.pythonhosted.org/packages/f3/3e/ca05e486d44e38eb495ca60b8ca526b192071717387346ed1031ecf78966/docker_compose-1.29.2-py2.py3-none-any.whl
    https://files.pythonhosted.org/packages/f4/2c/c90a3adaf0ddb70afe193f5ebfb539612af57cffe677c3126be533df3098/distro-1.8.0-py3-none-any.whl
    https://files.pythonhosted.org/packages/2d/10/ff4f2f5b2a420fd09e1331d63cc87cf4367c5745c0a4ce99cea92b1cbacb/python_dotenv-0.21.0-py3-none-any.whl
    https://files.pythonhosted.org/packages/a2/55/8f8cab2afd404cf578136ef2cc5dfb50baa1761b68c9da1fb1e4eed343c9/docopt-0.6.2.tar.gz
    https://files.pythonhosted.org/packages/ba/a7/2c12b543f853dae886286b824200eb9d7cd2466e3d14eff1799fbe8223b9/texttable-1.6.7-py2.py3-none-any.whl
    https://files.pythonhosted.org/packages/8d/ee/e9ecce4c32204a6738e0a5d5883d3413794d7498fe8b06f44becc028d3ba/dockerpty-0.4.1.tar.gz
    https://files.pythonhosted.org/packages/71/6d/95777fd66507106d2f8f81d005255c237187951644f85a5bd0baeec8a88f/paramiko-2.12.0-py2.py3-none-any.whl
    https://files.pythonhosted.org/packages/aa/48/fd2b197a9741fa790ba0b88a9b10b5e88e62ff5cf3e1bc96d8354d7ce613/bcrypt-4.0.1-cp36-abi3-manylinux_2_17_x86_64.manylinux2014_x86_64.whl
    http://security.ubuntu.com/ubuntu/pool/universe/p/python-pip/python-pip-whl_20.0.2-5ubuntu1.5_all.deb
    http://security.ubuntu.com/ubuntu/pool/main/p/python3-stdlib-extensions/python3-distutils_3.8.10-0ubuntu1~20.04_all.deb
    http://archive.ubuntu.com/ubuntu/pool/universe/w/wheel/python3-wheel_0.34.2-1_all.deb
    http://security.ubuntu.com/ubuntu/pool/universe/p/python-pip/python3-pip_20.0.2-5ubuntu1.5_all.deb
)

# Prepare Docker Images
image_list=(
    eclipse-mosquitto:2.0.15
    mataelang/kafka-mqtt-source:1.1
    confluentinc/cp-zookeeper:7.3.0
    confluentinc/cp-kafka:7.3.0
    provectuslabs/kafka-ui
    mataelang/snort-base:3.1.47.0-alpine-3
    docker pull mataelang/snort3-parser:1.1
    mataelang/spark:3.3.1-scala2.13
    opensearchproject/opensearch:2.4.0
    opensearchproject/opensearch-dashboards:2.4.0
    opensearchproject/logstash-oss-with-opensearch-output-plugin:8.4.0
)

do_download() {
    filename="$(basename "$1")"
    if test -f "files/$filename"; then
        return
    fi
    echo "=> Processing $filename"
    wget -q --show-progress --progress=bar:force -O "files/$filename" "$1"
}

do_docker_save() {
    tar_filename="files/docker_images/$(tr -s '/:' _ <<<"$1").tar"
    if test -f "$tar_filename"; then
        return
    fi
    echo "=> Processing $1"
    docker pull -q "$1"
    docker save -o "$tar_filename" "$1"
}

# Create directory
mkdir -p files/docker_images

# Start Download
for download_url in "${url_list[@]}"; do
    do_download "$download_url"
done

for image in "${image_list[@]}"; do
    do_docker_save "$image"
done
