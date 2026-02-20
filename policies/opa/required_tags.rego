package terraform.required_tags

# Required tags for all resources
required_tags := ["Environment", "Owner", "CostCenter"]

# Deny resources without required tags
deny[msg] {
    resource := input.resource_changes[_]
    resource.change.actions[_] == "create"

    # Check if resource supports tags
    resource.change.after.tags != null

    # Find missing tags
    missing := required_tags[_]
    not resource.change.after.tags[missing]

    msg := sprintf(
        "Resource %s (%s) is missing required tag: %s",
        [resource.address, resource.type, missing]
    )
}

# Warn if Environment tag value is not valid
warn[msg] {
    resource := input.resource_changes[_]
    resource.change.after.tags.Environment != null

    valid_environments := ["production", "staging", "development"]
    env := resource.change.after.tags.Environment
    not env == valid_environments[_]

    msg := sprintf(
        "Resource %s has invalid Environment tag: %s (must be one of: %v)",
        [resource.address, env, valid_environments]
    )
}
