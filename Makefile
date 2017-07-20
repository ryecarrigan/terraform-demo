build : front back

back :
	docker-compose -f backend/docker-compose.yml

front :
	docker-compose -f frontend/docker-compose.yml
