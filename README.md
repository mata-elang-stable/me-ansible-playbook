# Mata-Elang Ansible

## Prerequisite

- [x] Install Python 3.8
- [x] Install ansible
- [x] Install sshpass

All mata elang components are already included inside `roles` folder that described below:

- `hadoop` folder contain the automation folder for implementing the Mata Elang Hadoop component.
- `kafka_docker` folder contain the automation folder for implementing the Mata Elang Kafka component.
- `opensearch_docker` folder contain the automation folder for implementing the Mata Elang  OpenSearch component.
- `snort_sensor` folder contain the automation folder for implementing the Mata Elang Sensor Snort component.
- `spark_docker` folder contain the automation folder for implementing the Mata Elang Spark and Kaspacore component.

## Usage

**1. Edit `inventory` file.**
<p>copy the `inventory.example` file to `inventory`. This file define the grouping for each hostname that going to installed with ansible automation. Each group need to defined the username, password, and the root password for the SSH process in ansible</p>

This is an example line for ansible inventory file:
```
(e.g. 192.168.56.104) ansible_ssh_user=<your_username> ansible_ssh_password=<your_password> ansible_become_password=<your_become_password>
```
**2. Edit default variable**
<p>Open `defaults` -> 'main.yml' file and edit necessary variable for each component that necessary. The current configuration for variables are default configuration.</p>

**3. Start Ansible Process**
<p>Open the terminal with this current project directory and start the ansible using this command:</p>

```bash
ansible-playbook -i inventory site.yaml
```
