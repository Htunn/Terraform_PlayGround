resource "tfe_variable" "dev_project_id" {
    key = "project-id"
    value = var.dev-project-id #module.project-factory-dev.project_id
    category = "terraform"
    workspace_id = tfe_workspace.dev.id
    description = "DEV GCP ProjectID"
}

resource "tfe_variable" "qa_project_id" {
    key = "project-id"
    value = var.qa-project-id #module.project-factory-qa.project_id
    category = "terraform"
    workspace_id = tfe_workspace.qa.id
    description = "QA GCP ProjectID"
}

resource "tfe_variable" "dev_target_environment" {
    key = "target_environment"
    value = "DEV"
    category = "terraform"
    workspace_id = tfe_workspace.dev.id
    description = "DEV Target Environment"
}

resource "tfe_variable" "qa_target_environment" {
    key = "target_environment"
    value = "QA"
    category = "terraform"
    workspace_id = tfe_workspace.qa.id
    description = "QA Target Environment"
}

resource "tfe_variable" "dev_google_credentials" {
    key = "GOOGLE_CREDENTIALS"
    value = replace(file("tf_sa_key_dev"), "/\\n/", "")
    category = "env"
    workspace_id = tfe_workspace.dev.id
    sensitive = true
    description = "DEV Project Credentials"
}

resource "tfe_variable" "qa_google_credentials" {
    key = "GOOGLE_CREDENTIALS"
    value = replace(file("tf_sa_key_qa"), "/\\n/", "")
    category = "env"
    workspace_id = tfe_workspace.qa.id
    sensitive = true
    description = "QA Project Credentials"
}