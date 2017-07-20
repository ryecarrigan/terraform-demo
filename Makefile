build : front back

back :
	docker-compose -f backend/docker-compose.yml build

front :
	docker-compose -f frontend/docker-compose.yml build

up :
	docker-compose up -d

down :
	docker-compose down
