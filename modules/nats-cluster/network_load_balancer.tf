resource "aws_lb" "nlb" {
  name               = "${var.name_prefix}-nlb-private"
  internal           = true
  load_balancer_type = "network"
  subnets            = var.subnet_ids

  tags = var.tags
}

resource "aws_lb_target_group" "nlb_tg" {
  name     = "${var.name_prefix}-tg"
  port     = 4222
  protocol = "TCP"
  vpc_id   = var.vpc_id

  health_check {
    protocol = "TCP"
    port     = 8222
  }

  tags = var.tags
}

resource "aws_lb_listener" "nlb_listener" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = "4222"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb_tg.arn
  }

  tags = var.tags
}

resource "aws_lb_target_group_attachment" "nlb_tg_attachments" {
  depends_on = [module.ec2_instance]

  count = var.cluster_size

  target_group_arn = aws_lb_target_group.nlb_tg.arn
  target_id        = module.ec2_instance[count.index].id
  port             = 4222
}

