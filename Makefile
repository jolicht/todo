include docker/mk/*.mk

.PHONY: backend-composer-install
backend-composer-install:: ##@backend Install composer dependencies in backend application
	$(shell_env) docker run --rm \
		--volume ${PWD}/todo-backend/src:/application \
		--user $(UID):$(GID) \
		-w /application \
		composer:1.10.4 install

.PHONY: backend-composer-shell
backend-composer-shell:: ##@backend Run composer container to run composer tasks in backend application
	$(shell_env) docker run --rm -ti \
		--volume ${PWD}/todo-backend/src:/application \
		--user $(UID):$(GID) \
		-w /application \
		composer /bin/bash

.PHONY: frontend-node-shell
frontend-node-shell:: ##@frontend Run node container to maintain vue application


.PHONY: up
up:: ##@Compose Start from docker-compose.yml (attached)
up:: backend-composer-install
	$(shell_env) docker-compose up --build
