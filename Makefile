# Default goal is to build the frontend and backend images
images : front back

# Goals for testing the web app locally
back :
	docker-compose -f backend/docker-compose.yml build

front :
	docker-compose -f frontend/docker-compose.yml build

up :
	docker-compose up -d

down :
	docker-compose down

test :
	@echo "Expected:	Connection OK; waiting to send."
	@echo "Actual:		$(shell curl -s localhost:8080)"

# Goals for the AWS network
plan :
	terraform plan network

apply deploy :
	terraform apply network

destroy :
	terraform destroy network
