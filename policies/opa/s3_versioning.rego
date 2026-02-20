package terraform.s3_versioning

# Deny production S3 buckets without versioning
deny[msg] {
    resource := input.resource_changes[_]
    resource.type == "aws_s3_bucket"
    resource.change.actions[_] == "create"

    # Check if this is production
    resource.change.after.tags.Environment == "production"

    # Look for versioning configuration
    versioning := input.resource_changes[_]
    versioning.type == "aws_s3_bucket_versioning"
    versioning.change.after.bucket == resource.change.after.id

    # Check if versioning is enabled
    versioning.change.after.versioning_configuration[_].status != "Enabled"

    msg := sprintf(
        "Production S3 bucket %s must have versioning enabled",
        [resource.address]
    )
}

# Warn about buckets without lifecycle rules
warn[msg] {
    resource := input.resource_changes[_]
    resource.type == "aws_s3_bucket"

    # Check for lifecycle configuration
    lifecycle_exists := [l |
        l := input.resource_changes[_]
        l.type == "aws_s3_bucket_lifecycle_configuration"
        l.change.after.bucket == resource.change.after.id
    ]

    count(lifecycle_exists) == 0

    msg := sprintf(
        "S3 bucket %s should have lifecycle rules for cost management",
        [resource.address]
    )
}
