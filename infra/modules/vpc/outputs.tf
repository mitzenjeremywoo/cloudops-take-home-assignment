output "id" {
  value = aws_vpc.webapp_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}