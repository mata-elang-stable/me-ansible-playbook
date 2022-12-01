# How to use this playbook

### Requirements
 - Ansible
 - Target Instances (you can separate Spark Master and Worker into different instance)
 - ssh


### How to run
1. If you choose to not let this script to download the Spark archive, you can simple set `spark_download_over_internet` to `no` in the `defaults/main.yml` file. Then don't forget to copy the Spark archive into `files` folder with the following format file : `spark-{{ spark_version }}-bin-hadoop{{ spark_hadoop_version }}.tgz`.
1. Adjust the `inventory` file to fit with the current environment
1. If you are ready, you can play the playbook with the following command:
    ```bash
    ansible-playbook -i inventory site.example.yml --ask-become-password
    ```
1. You can access the spark master dashboard to `http://spark-master:8080`