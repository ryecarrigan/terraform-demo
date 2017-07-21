// Output the DNS name from the frontend ALB
output "frontend_dns" {
  value = "${aws_alb.frontend.dns_name}"
}
