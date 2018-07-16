INVENTORY := inventory/static/hosts.yml

test: run_test clean

check: run_check clean

setup_test:
	@echo "## Start Ansible target container."
	docker-compose up -d

run_test: setup_test
	@echo "## Run ansible-playbook"
	-ansible-playbook --diff -i ${INVENTORY} site.yml
	@echo You can check provisioned container with \"docker exec -it ansible_target /bin/bash\" before clean.

run_check: setup_test
	@echo "## Run asible-playbook with check option"
	-ansible-playbook --check --diff -i ${INVENTORY} site.yml

clean:
	@echo "## Clean test components."
	docker-compose stop
	docker-compose rm -f
