# include .mk

SHELL=/bin/bash

username                  := bossjones
test_container_name       := ubuntu-trusty
TEST_IMAGE_NAME           := $(username)/$(test_container_name)

# verify that certain variables have been defined off the bat
check_defined = \
    $(foreach 1,$1,$(__check_defined))
__check_defined = \
    $(if $(value $1),, \
      $(error Undefined $1$(if $(value 2), ($(strip $2)))))

list_allowed_args := name inventory

export PATH := ./bin:./venv/bin:$(PATH)

mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))

.PHONY: list help
# .PHONY: all dockerfile docker-compose test test-build lint clean pristine run run-single run-cluster build release-manager release-manager-snapshot push

# TODO: Modify this command if you want to use cookiecutter to create something from scratch again
# cookiecutter -f --output-dir=/Users/malcolm/dev/bossjones/bossjones-playbook-suite/ gh:bossjones/cookiecutter-molecule \
# role_name="boss-ansible-role-nvm" \
# scenario_name="default" \
# email="bossjones@theblacktonystark.com" \
# github_user="bossjones" \
# description="The boss-ansible-role-nvm role can be used to setup nvm from scratch. Part of the bossjones suite of ansible roles" \
# description_short="Ansible nvm role. Part of the bossjones suite of ansible roles" \
# release_date="2018-01-16" \
# year="2018" \
# version="0.1.0" \
# min_ansible_version="2.3.2.0" \
# allow_duplicates="no" \
# license="Apache" \
# company="Tony Dark Labs" \
# os_user="vagrant" \
# author_name="Malcolm Jones" \
# author="Malcolm Jones" \
# author_email="bossjones@theblacktonystark.com" \
# repo_name="boss-ansible-role-nvm" \
# domain_name="theblacktonystark.com" \
# run_ansible_as_root="no" \
# role_galaxy_name="bossjones.nvm" \
# use_gilt="yes" \
# use_delegated="no" \
# docker_container_flavor="xenial"


# # TODO: Modify this command if you want to use cookiecutter to create something from scratch again
# cookiecutter -f --output-dir=/Users/malcolm/dev/bossjones/bossjones-playbook-suite/ --config-file /Users/malcolm/dev/bossjones/cookiecutter-molecule/cookiecutter-custom-config.yaml gh:bossjones/cookiecutter-molecule \
# role_name="boss-ansible-role-sysctl" \
# repo_name="boss-ansible-role-sysctl" \
# role_galaxy_name="bossjones.sysctl" \
# run_ansible_as_root="yes" \
# use_gilt="yes" \
# use_delegated="no" \
# docker_container_flavor="trusty" \
# description="The boss-ansible-role-sysctl role can be used to setup sysctl from scratch. Part of the bossjones suite of ansible roles" \
# description_short="Ansible sysctl role. Part of the bossjones suite of ansible roles"

# hub init
# hub add . && hub commit -m "It begins."
# hub create -d "Ansible sysctl role. Part of the bossjones suite of ansible roles" bossjones/boss-ansible-role-sysctl
# hub push origin master

bootstrap-molecule-default:
	molecule init scenario --role-name $(current_dir) --scenario-name default

# NOTE: make this into a bash alias (pretty-yaml)
pretty-yaml:
	python -m pyaml /path/to/some/file.yaml

help:
	@echo "Convenience Make commands for provisioning a scarlett node"

list:
	@$(MAKE) -qp | awk -F':' '/^[a-zA-Z0-9][^$#\/\t=]*:([^=]|$$)/ {split($$1,A,/ /);for(i in A)print A[i]}' | sort

vagrant-provision:
	vagrant provision

vagrant-up:
	vagrant up

vagrant-ssh:
	vagrant ssh

vagrant-destroy:
	vagrant destroy

vagrant-halt:
	vagrant halt

vagrant-config:
	vagrant ssh-config

serverspec:
	bundle exec rake

serverspec-install:
	bundle install --path .vendor

download-roles:
	ansible-galaxy install -r install_roles.txt --roles-path roles/ -vvv

destroy:
	molecule destroy

install-cidr-brew:
	pip install cidr-brewer

install-test-deps:
	pip install ansible==2.2.3.0
	pip install docker-py
	pip install molecule --pre

ci:
	molecule test

test:
	molecule test --destroy=always

bootstrap: venv
travis: bootstrap venv ci

.PHONY: docker_build_ubuntu
docker_build_ubuntu: ## Builds SD Ubuntu docker container
	@docker build -t $(TEST_IMAGE_NAME):latest -f molecule/default/Dockerfile molecule/default

start_delegated_docker:
	docker run \
	-d \
	--privileged=true \
	--cap-add=SYS_ADMIN \
	-v /sys/fs/cgroup:/sys/fs/cgroup:ro \
	--name boss-ansible-role-docker-trusty \
	--hostname boss-ansible-role-docker-trusty \
	-it $(TEST_IMAGE_NAME):latest sleep infinity & wait

stop_delegated_docker:
	$(MAKE) docker_clean
	$(MAKE) docker_clean

# SOURCE: https://github.com/lispmeister/rpi-python3/blob/534ee5ab592f0ab0cdd04a202ca492846ab12601/Makefile
exited := $(shell docker ps -a -q -f status=exited)
kill   := $(shell docker ps | grep ubuntu-trusty | awk '{print $$1}')
# untagged := $(shell (docker images | grep "^<none>" | awk -F " " '{print $$3}'))
# dangling := $(shell docker images -f "dangling=true" -q)
# tag := $(shell docker images | grep "$(DOCKER_IMAGE_NAME)" | grep "$(DOCKER_IMAGE_VERSION)" |awk -F " " '{print $$3}')
# latest := $(shell docker images | grep "$(DOCKER_IMAGE_NAME)" | grep "latest" | awk -F " " '{print $$3}')

# clean: ## Clean old Docker images
# ifneq ($(strip $(latest)),)
# 	@echo "Removing latest $(latest) image"
# 	docker rmi "$(DOCKER_IMAGE_NAME):latest"
# endif
# ifneq ($(strip $(tag)),)
# 	@echo "Removing tag $(tag) image"
# 	docker rmi "$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_VERSION)"
# endif
# ifneq ($(strip $(exited)),)
# 	@echo "Cleaning exited containers: $(exited)"
# 	docker rm -v $(exited)
# endif
# ifneq ($(strip $(dangling)),)
# 	@echo "Cleaning dangling images: $(dangling)"
# 	docker rmi $(dangling)
# endif
# 	@echo 'Done cleaning.'


docker_clean:
ifneq ($(strip $(kill)),)
	@echo "Killing containers: $(kill)"
	docker kill $(kill)
endif
ifneq ($(strip $(exited)),)
	@echo "Cleaning exited containers: $(exited)"
	docker rm -v $(exited)
endif
travis-osx:
	$(MAKE) venv-osx
	$(MAKE) upgrade-setuptools
	$(MAKE) venv-osx
	$(MAKE) ci

# OSX Order of operations, make travis-osx; . venv/bin/activate; make upgrade-setuptools; make travis-osx;

upgrade-setuptools:
	pip install --ignore-installed --pre "https://github.com/pradyunsg/pip/archive/hotfix/9.0.2.zip#egg=pip" \
    && pip install --upgrade setuptools==36.0.1 wheel==0.29.0

which-pip:
	which pip

# enter virtualenv so we can use Ansible
activate:
	. venv/bin/activate

# The tests are written in Python. Make a virtualenv to handle the dependencies.
venv: requirements.txt
	@if [ -z $$PYTHON2 ]; then\
	    PY2_MINOR_VER=`python2 --version 2>&1 | cut -d " " -f 2 | cut -d "." -f 2`;\
	    if (( $$PY2_MINOR_VER < 7 )); then\
		echo "Couldn't find python2 in \$PATH that is >=2.7";\
		echo "Please install python2.7 or later or explicity define the python2 executable name with \$PYTHON2";\
	        echo "Exiting here";\
	        exit 1;\
	    else\
		export PYTHON2="python2.$$PY2_MINOR_VER";\
	    fi;\
	fi;\
	test -d venv || virtualenv --python=$$PYTHON2 venv;\
	pip install -r requirements.txt;\
	pip install -r requirements-dev.txt;\
	touch venv;\

# Compile python modules against homebrew openssl. The homebrew version provides a modern alternative to the one that comes packaged with OS X by default.
# OS X's older openssl version will fail against certain python modules, namely "cryptography"
# Taken from this git issue pyca/cryptography#2692
# The tests are written in Python. Make a virtualenv to handle the dependencies.
venv-osx: requirements.txt
	@if [ -z $$PYTHON2 ]; then\
	    PY2_MINOR_VER=`python2 --version 2>&1 | cut -d " " -f 2 | cut -d "." -f 2`;\
	    if (( $$PY2_MINOR_VER < 7 )); then\
		echo "Couldn't find python2 in \$PATH that is >=2.7";\
		echo "Please install python2.7 or later or explicity define the python3 executable name with \$PYTHON2";\
	        echo "Exiting here";\
	        exit 1;\
	    else\
		export PYTHON2="python2.$$PY2_MINOR_VER";\
	    fi;\
	fi;\
	test -d venv || virtualenv --python=$$PYTHON2 venv;\
	ARCHFLAGS="-arch x86_64" LDFLAGS="-L/usr/local/opt/openssl/lib" CFLAGS="-I/usr/local/opt/openssl/include" pip install -r requirements.txt;\
	ARCHFLAGS="-arch x86_64" LDFLAGS="-L/usr/local/opt/openssl/lib" CFLAGS="-I/usr/local/opt/openssl/include" pip install -r requirements-dev.txt;\
	touch venv;\

# [ANSIBLE0013] Use shell only when shell functionality is required
ansible-lint-role:
	bash -c "find .* -type f -name '*.y*ml' -print0 | xargs -I FILE -t -0 -n1 ansible-lint -x ANSIBLE0006,ANSIBLE0007,ANSIBLE0010,ANSIBLE0013 FILE"

yamllint-role:
	bash -c "find .* -type f -name '*.y*ml' -print0 | xargs -I FILE -t -0 -n1 yamllint FILE"

ping:
	$(call check_defined, inventory, Please set inventory)
	@ansible-playbook -i $(inventory) ping.yml

# SOURCE: https://medium.com/@shredder/using-ansible-tags-with-vagrant-provision-a4856966a987
# EXAMPLE: ansible-playbook -i inventory —private-key=~/.vagrant.d/insecure_private_key -u vagrant playbook.yml —tags=”phpconf”
run-playbook:
	echo "running playbook"
