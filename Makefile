# --- Project iFora ---
NAME = "BMSTU Web Dev"

# minIO
DB_NAME 		= random_users
DB_USER 		= ifora_user
DB_SRC 			= docker-compose.yml random_users.sql
DB_CNT_NAME = pg_ifora_db

# Colors For Good-looking assembling
GREEN 		= \033[32m
YELLOW 		= \033[0;33m
RED 			= \033[0;31m
GRAY 			= \033[2;37m
CURSIVE 	= \033[3m
NO_COLOR 	= \x1b[0m
RESET 		= \033[0m

all: downv
	@docker-compose up -d
	@printf "\n$(CURSIVE)$(GREEN)$(NAME)$(RESET)$(CURSIVE) is up and running 💃🕺$(RESET)\n"
.PHONY: all

down:
	@echo "\n"
	@docker-compose down
	@echo "$(GRAY)$(CURSIVE)---$(NAME) is down\n$(RESET)"
.PHONY: clean

downv:
	@docker-compose down -v
	@echo "$(GRAY)$(CURSIVE)---$(NAME) is down, volumes cleaned\n$(RESET)"
.PHONY: cleanv

test_kafka_consumer:
	@docker exec -it kafka kafka-console-consumer --bootstrap-server kafka:9092 --topic api2kafka --from-beginning

connect_db:
	docker exec -it $(DB_CNT_NAME) psql -U $(DB_USER) -d $(DB_NAME)
.PHONY: connect_db

re: cleanv all
.PHONY: re

