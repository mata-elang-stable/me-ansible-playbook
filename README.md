# Mata Elang Ansible

## Prerequisite

- [x] Install Python 3.8
- [x] Install ansible
- [x] Install sshpass

All Mata Elang components are already included inside `tasks` folder.

## Usage

**1. Edit `inventory` file.**
<p>copy the `inventory.example` file to `inventory`. This file define the grouping for each hostname that going to installed with ansible automation. Each group need to defined the username, password, and the root password for the SSH process in ansible</p>

This is an example line for ansible inventory file:
```
[all:vars]
ansible_ssh_user=username
ansible_ssh_password=password
ansible_become_password=password

[mosquitto]
192.168.59.103

[kafka]
192.168.59.103

[hadoop]
192.168.59.103

[spark]
192.168.59.103

[opensearch]
192.168.59.103

[sensor]
192.168.59.103 sensor_id=sensor1 sensor_network_interface=enp0s8
192.168.59.104 sensor_network_interface=enp0s8
```
**2. Edit default variable**
<p>Open `defaults` -> 'main.yml' file and edit necessary variable for each component that necessary. The current configuration for variables are default configuration.</p>

**3. Start Ansible Process**
<p>Open the terminal with this current project directory and start the ansible using this command:</p>

```bash
ansible-playbook -i inventory site.yaml
```

## Force reinstall (Data will be erased!)

You can do reinstall all components by adding `force=True` at `[all:vars]` section in inventory file.

```
[all:vars]
ansible_ssh_user=username
ansible_ssh_password=password
ansible_become_password=password
force=True
```
