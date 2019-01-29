ARCHIVE_FILE = "./archive.tar.gz"
ARCHIVE_DEPS = $(shell sudo find . -type f ! -path $(ARCHIVE_FILE))

all: run-daemon

.PHONY: run-daemon
run-daemon:
	@echo "> running as daemon..."
	docker-compose up -d

.PHONY: run-foreground
run-foreground:
	@echo "> running in foreground..."
	-docker-compose up

.PHONY: update
update:
	docker-compose pull
	docker-compose up -d

.PHONY: stop
stop:
	@echo "> stopping containers..."
	docker-compose down
	@echo "> done!"

archive:
	@echo "> compressing files!"
	@sudo tar -czf $(ARCHIVE_FILE) $(ARCHIVE_DEPS)
	@echo "> archive created: $(ARCHIVE_FILE)"

.PHONY: clean
clean:
	docker-compose down
	sudo rm -rf ./data/*
	rm -f $(ARCHIVE_FILE)
