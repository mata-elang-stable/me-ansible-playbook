# Mata Elang Ansible

## Prerequisite

- Python >= 3.8
- Ansible >= 2.13
- sshpass

All Mata Elang components are already included in the `tasks` folder.

## Offline Installation
You can use this Ansible Playbook to install Mata Elang in an offline way. But you need to get online first to prepare the required files.

### Offline Requirements
These requirements are only applied to host where you run the Ansible Playbook.
 - Docker: [Install Docker in Ubuntu](https://docs.docker.com/engine/install/ubuntu/)
 - Python >= 3.8
 - Ansible >= 2.13
 - sshpass
 - wget (for running download.sh script)

### Downloading Required Files for Offline Installation
We already provide a script to download all required files in a single execution. This script needs a bash to run.
1. Execute `download.sh`. This will download around 8.5GB.
    ```bash
    bash download.sh
    ```
2. Download GeoLite2-Citye.mmdb.
    You need to download Maxmind Database from the website. Please refer to our [wiki here](https://github.com/mata-elang-stable/mataelang-platform/wiki/hadoop#install-geolite2).

You can always download the required files manually and store them in the `files` directory.

## Usage
1. Clone this repository.
2. Download GeoLite2-City.mmdb from Maxmind. You can look at our [wiki](https://github.com/mata-elang-stable/mataelang-platform/wiki/hadoop#install-geolite2) how to get it.
3. Edit the inventory
Copy `inventory.example` file to `inventory`. This file defines the grouping for each hostname that is going to be installed by Ansible Playbook. You need to define the SSH user and password. If you have a different user for each IP and group, you can look at the example below.

    - Example
        #### Sensor host
        ```
        Username: ubuntu
        Password: ubuntu
        Network Interface 1: eth0 172.16.3.110
        Network Interface 2: eth1 172.16.4.110
        ```
        
        #### Defense Center host
        ```
        Username: ubuntu
        Password: ubuntu
        Network Interface 1: eth0 172.16.4.111
        ```
        
        #### Configuration Result

        ```conf
        [all:vars]
        ansible_ssh_user=ubuntu
        ansible_ssh_password=ubuntu
        ansible_become_password=ubuntu
        force=False

        [mosquitto]
        172.16.4.111

        [kafka]
        172.16.4.111

        [hadoop]
        172.16.4.111

        [spark]
        172.16.4.111

        [opensearch]
        172.16.4.111

        [sensor]
        172.16.4.110 sensor_id=sensor1 sensor_network_interface=eth0 sensor_home_net=172.16.3.0/24
        ```

    - For example, if you have different Linux user for the sensor group

        ```conf
        [all:vars]
        ansible_ssh_user=ubuntu
        ansible_ssh_password=ubuntu
        ansible_become_password=ubuntu
        force=False

        [mosquitto]
        172.16.4.111

        [kafka]
        172.16.4.111

        [hadoop]
        172.16.4.111

        [spark]
        172.16.4.111

        [opensearch]
        172.16.4.111

        [sensor]
        172.16.4.110 sensor_id=sensor1 sensor_network_interface=eth0 sensor_home_net=172.16.3.0/24

        [sensor:vars]
        ansible_ssh_user=sensor1
        ansible_ssh_password=ubuntu
        ansible_become_password=ubuntu
        ```
        
4. Edit default variable
You can freely adjust the default variable in `defaults/main.yml`. You can use the default configuration.

5. Run the Ansible Playbook
    ```sh
    ansible-playbook -i inventory site.yaml
    ```

6. Download OpenSearch Dashboard template
    You need to download this template file from any host where you want to access the dashboard, this file does not need to copy to the server or defense center host.
    URL: https://raw.githubusercontent.com/mata-elang-stable/mataelang-docs/main/opensearch/mata-elang-template.ndjson\

    ```bash
    wget https://raw.githubusercontent.com/mata-elang-stable/mataelang-docs/main/opensearch/mata-elang-template.ndjson
    ```

7. Access the OpenSearch Dashboard
    After the installation process is done, you can access the dashboard at http://defense-center-ip:5601.

## How to create Docker Image tar file
1. Pull the image
```sh
docker pull imagename:imagetag
```

2. Save the image to archive file
```sh
docker save -o imagename_imagetag.tar imagename:imagetag
```

## How to force reinstall (Data will be erased!)

You can reinstall all components by adding the `force=True` at `[all:vars]` section in the inventory file.

```conf
[all:vars]
ansible_ssh_user=username
ansible_ssh_password=password
ansible_become_password=password
force=True
```
