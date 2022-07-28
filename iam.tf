resource "aws_iam_role" "lambda_iam" {
  name = "lambda-role-fileupload-francisco"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "role_policy" {
  name = "lambda-policy-fileupload-francisco"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Action": [
            "s3:PutObject*"
        ],
        "Effect": "Allow",
        "Resource": "*"
    },
    {
      "Action" : [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Effect" : "Allow",
      "Resource" : "arn:aws:logs:*:*:*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "logging_policy_attachment" {
  role = aws_iam_role.lambda_iam.id
  policy_arn = aws_iam_policy.role_policy.arn
}
