cookiecutter --output-dir=/Users/malcolm/dev/bossjones/bossjones-playbook-suite/ \
gh:bossjones/cookiecutter-molecule \
role_name="bossjones.common" \
scenario_name="default" \
email="bossjones@theblacktonystark.com" \
github_user="bossjones" \
description="Ansible role full of common configuration options. part of the bossjones suite of ansible roles" \
description_short="Ansible role full of common configuration options. part of the bossjones suite of ansible roles" \
release_date="2018-01-08" \
year="2018" \
version="0.1.0" \
min_ansible_version="2.3.2.0" \
allow_duplicates="no" \
license="Apache" \
company="Tony Dark Labs" \
os_user="vagrant" \
author_name="Malcolm Jones" \
author="Malcolm Jones" \
author_email="bossjones@theblacktonystark.com" \
repo_name="boss-ansible-role-common" \
domain_name="theblacktonystark.com" \
run_ansible_as_root="no"


# ------
# New Repo from scratch
# ------
# create a repo for a new project
hub init

hub add . && hub commit -m "It begins."

hub create -d "Ansible role full of common configuration options. part of the bossjones suite of ansible roles" bossjones/boss-ansible-role-common

hub push origin master
#######################################################


# java

cookiecutter -f --output-dir=/Users/malcolm/dev/bossjones/bossjones-playbook-suite/ gh:bossjones/cookiecutter-molecule role_name="bossjones.java" scenario_name="default" email="bossjones@theblacktonystark.com" github_user="bossjones" description="Ansible role install java. Part of the bossjones suite of ansible roles" description_short="Ansible role install java. Part of the bossjones suite of ansible roles" release_date="2018-01-09" year="2018" version="0.1.0" min_ansible_version="2.3.2.0" allow_duplicates="no" license="Apache" company="Tony Dark Labs" os_user="vagrant" author_name="Malcolm Jones" author="Malcolm Jones" author_email="bossjones@theblacktonystark.com" repo_name="boss-ansible-role-java" domain_name="theblacktonystark.com" run_ansible_as_root="no"


# maven

cookiecutter -f --output-dir=/Users/malcolm/dev/bossjones/bossjones-playbook-suite/ gh:bossjones/cookiecutter-molecule role_name="bossjones.maven" scenario_name="default" email="bossjones@theblacktonystark.com" github_user="bossjones" description="Ansible role install maven. Part of the bossjones suite of ansible roles" description_short="Ansible role install maven. Part of the bossjones suite of ansible roles" release_date="2018-01-09" year="2018" version="0.1.0" min_ansible_version="2.3.2.0" allow_duplicates="no" license="Apache" company="Tony Dark Labs" os_user="vagrant" author_name="Malcolm Jones" author="Malcolm Jones" author_email="bossjones@theblacktonystark.com" repo_name="boss-ansible-role-maven" domain_name="theblacktonystark.com" run_ansible_as_root="no"


# swapfile

cookiecutter -f --output-dir=/Users/malcolm/dev/bossjones/bossjones-playbook-suite/ gh:bossjones/cookiecutter-molecule role_name="bossjones.swapfile" scenario_name="default" email="bossjones@theblacktonystark.com" github_user="bossjones" description="Ansible role to create swapfile. Part of the bossjones suite of ansible roles" description_short="Ansible role to create swapfile. Part of the bossjones suite of ansible roles" release_date="2018-01-09" year="2018" version="0.1.0" min_ansible_version="2.3.2.0" allow_duplicates="no" license="Apache" company="Tony Dark Labs" os_user="vagrant" author_name="Malcolm Jones" author="Malcolm Jones" author_email="bossjones@theblacktonystark.com" repo_name="boss-ansible-role-swapfile" domain_name="theblacktonystark.com" run_ansible_as_root="no"

# tuning

cookiecutter -f --output-dir=/Users/malcolm/dev/bossjones/bossjones-playbook-suite/ gh:bossjones/cookiecutter-molecule role_name="bossjones.tuning" scenario_name="default" email="bossjones@theblacktonystark.com" github_user="bossjones" description="Ansible role system tuning. Part of the bossjones suite of ansible roles" description_short="Ansible role to create tuning. Part of the bossjones suite of ansible roles" release_date="2018-01-09" year="2018" version="0.1.0" min_ansible_version="2.3.2.0" allow_duplicates="no" license="Apache" company="Tony Dark Labs" os_user="vagrant" author_name="Malcolm Jones" author="Malcolm Jones" author_email="bossjones@theblacktonystark.com" repo_name="boss-ansible-role-tuning" domain_name="theblacktonystark.com" run_ansible_as_root="no"

# update-hosts

cookiecutter -f --output-dir=/Users/malcolm/dev/bossjones/bossjones-playbook-suite/ gh:bossjones/cookiecutter-molecule role_name="bossjones.update-hosts" scenario_name="default" email="bossjones@theblacktonystark.com" github_user="bossjones" description="Ansible role update-hosts. Part of the bossjones suite of ansible roles" description_short="Ansible role to create update-hosts. Part of the bossjones suite of ansible roles" release_date="2018-01-09" year="2018" version="0.1.0" min_ansible_version="2.3.2.0" allow_duplicates="no" license="Apache" company="Tony Dark Labs" os_user="vagrant" author_name="Malcolm Jones" author="Malcolm Jones" author_email="bossjones@theblacktonystark.com" repo_name="boss-ansible-role-update-hosts" domain_name="theblacktonystark.com" run_ansible_as_root="no"

# pysyslog

cookiecutter -f --output-dir=/Users/malcolm/dev/bossjones/bossjones-playbook-suite/ gh:bossjones/cookiecutter-molecule role_name="bossjones.pysyslog" scenario_name="default" email="bossjones@theblacktonystark.com" github_user="bossjones" description="Ansible role install pysyslog. Part of the bossjones suite of ansible roles" description_short="Ansible role to create pysyslog. Part of the bossjones suite of ansible roles" release_date="2018-01-09" year="2018" version="0.1.0" min_ansible_version="2.3.2.0" allow_duplicates="no" license="Apache" company="Tony Dark Labs" os_user="vagrant" author_name="Malcolm Jones" author="Malcolm Jones" author_email="bossjones@theblacktonystark.com" repo_name="boss-ansible-role-pysyslog" domain_name="theblacktonystark.com" run_ansible_as_root="no"


###########################

cd bossjones.java
hub init
hub add . && hub commit -m "It begins."
hub create -d "Ansible role to install java. part of the bossjones suite of ansible roles" bossjones/boss-ansible-role-java
hub push origin master
cd -


cd bossjones.maven
hub init
hub add . && hub commit -m "It begins."
hub create -d "Ansible role to install maven. part of the bossjones suite of ansible roles" bossjones/boss-ansible-role-maven
hub push origin master
cd -

cd bossjones.swapfile
hub init
hub add . && hub commit -m "It begins."
hub create -d "Ansible role to setup swapfile. part of the bossjones suite of ansible roles" bossjones/boss-ansible-role-swapfile
hub push origin master
cd -

cd bossjones.pysyslog
hub init
hub add . && hub commit -m "It begins."
hub create -d "Ansible role to setup pysyslog. part of the bossjones suite of ansible roles" bossjones/boss-ansible-role-pysyslog
hub push origin master
cd -


cd bossjones.tuning
hub init
hub add . && hub commit -m "It begins."
hub create -d "Ansible role to setup base tuning. part of the bossjones suite of ansible roles" bossjones/boss-ansible-role-tuning
hub push origin master
cd -

cd bossjones.update-hosts
hub init
hub add . && hub commit -m "It begins."
hub create -d "Ansible role to setup base update-hosts. part of the bossjones suite of ansible roles" bossjones/boss-ansible-role-update-hosts
hub push origin master
cd -
