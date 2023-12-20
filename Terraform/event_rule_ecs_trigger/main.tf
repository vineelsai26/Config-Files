resource "aws_kms_key" "example" {
  description             = "example"
  deletion_window_in_days = 7
}

resource "aws_cloudwatch_log_group" "event_processing_log_group" {
  name = "event_processing_log_group"
}

resource "aws_ecs_cluster" "test" {
  name = "event_processing_cluster"

  configuration {
    execute_command_configuration {
      kms_key_id = aws_kms_key.example.arn
      logging    = "OVERRIDE"

      log_configuration {
        cloud_watch_encryption_enabled = true
        cloud_watch_log_group_name     = aws_cloudwatch_log_group.event_processing_log_group.name
      }
    }
  }
}

resource "aws_ecr_repository" "event_processing_container" {
  name                 = "event_processing_container"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_iam_role" "ecr_assume_role" {
  name               = "ecr_assume_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "ecr_access_role_policy" {
  name = "ecr_access_role_policy"
  role = aws_iam_role.ecr_assume_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ecr:*"
      ],
      "Effect": "Allow",
      "Resource": "${aws_ecr_repository.event_processing_container.arn}"
    }
  ]
}
EOF
}

resource "aws_ecs_task_definition" "event_processing_task" {
  family                   = "event_processing_task"
  cpu                      = 1024
  memory                   = 2048
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecr_assume_role.arn
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
  container_definitions = jsonencode([
    {
      name      = "first"
      image     = aws_ecr_repository.event_processing_container.repository_url
      cpu       = 1024
      memory    = 2048
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
}

resource "aws_iam_role" "eventbridge_ecs_invoke_role" {
  name               = "eventbridge_ecs_invoke_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "events.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "eventbridge_ecs_invoke_role_policy" {
  name = "eventbridge_ecs_invoke_role_policy"
  role = aws_iam_role.eventbridge_ecs_invoke_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ecs:*"
      ],
      "Effect": "Allow",
      "Resource": "${aws_ecs_cluster.test.arn}"
    }
  ]
}
EOF
}

resource "aws_cloudwatch_event_rule" "event_rule" {
  name        = "elucidata_microservices_notification"
  description = "Capture all elucidata.microservices.notification events"

  event_pattern = jsonencode({
    source = [
      "elucidata.microservices.notification"
    ]
  })
}

resource "aws_cloudwatch_event_target" "event_target" {
  target_id = "ecs_event_target"
  rule      = aws_cloudwatch_event_rule.event_rule.name
  arn       = aws_ecs_cluster.test.arn
  role_arn = aws_iam_role.eventbridge_ecs_invoke_role.arn

  dead_letter_config {
    arn = aws_sqs_queue.dead_letter_queue.arn
  }

  ecs_target {
    task_count          = 1
    task_definition_arn = aws_ecs_task_definition.event_processing_task.arn
    launch_type = "FARGATE"

    network_configuration {
      subnets         = ["subnet-9019bfd8"]
      # security_groups = ["sg-0c771d617e23956ab"]
      assign_public_ip = true
    }
  }

  input_transformer {
    input_paths = {
      items = "$.detail.items",
      user_id   = "$.detail.user_id",
      detail_type = "$.detail-type",
    }
    input_template = <<EOF
{
  "items": <items>,
  "user_id": <user_id>,
  "detail_type": <detail_type>
}
EOF
  }
}

resource "aws_sqs_queue" "dead_letter_queue" {
  name                      = "dead_letter_queue"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
}
