### Create target group
resource "aws_lb_target_group" "target_group" {
  name = var.target_group_name
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id
  target_type = "ip"
  protocol_version = "HTTP1"
  ip_address_type = "ipv4"
  health_check {
    enabled             = true
    interval            = 30
    path                = "/health"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2  
  }
  tags = {
    
    Name = "${var.target_group_name}"
    Type = "Target group for ALB"
    Author = var.author
  }
}

### Create Application load balancer
resource "aws_lb" "application_load_balancer" {
  name = var.alb_name
  internal = false
  load_balancer_type = "application"
  security_groups = [ var.security_group_id ]
  subnets = var.subnet_ids
  tags = {
    Name   = "${var.alb_name}"
    Type   = "Application Load Balancer"
    Author = var.author
  }
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = "80"
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}


