resource "aws_cloudwatch_metric_alarm" "web_cpu_high" {
  alarm_name          = "proj2-web-cpu-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 70

  alarm_description  = "High CPU on proj2 web instance"
  treat_missing_data = "notBreaching"

  dimensions = {
    InstanceId = aws_instance.web_private_a.id
  }

  alarm_actions = [] # you can add SNS later
  ok_actions    = []
}
