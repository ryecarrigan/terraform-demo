// Create an ECS cluster for our Dockerized app.
resource "aws_ecs_cluster" "web_app" {
  name = "AppCluster"
}
