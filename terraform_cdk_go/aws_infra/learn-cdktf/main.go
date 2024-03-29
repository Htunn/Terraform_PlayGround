package main

import (
    "github.com/aws/constructs-go/constructs/v10"
    "github.com/aws/jsii-runtime-go"
    "github.com/hashicorp/terraform-cdk-go/cdktf"

    "github.com/cdktf/cdktf-provider-aws-go/aws/v10/instance"
    awsprovider "github.com/cdktf/cdktf-provider-aws-go/aws/v10/provider"
)

func NewMyStack(scope constructs.Construct, id string) cdktf.TerraformStack {
    stack := cdktf.NewTerraformStack(scope, &id)

    awsprovider.NewAwsProvider(stack, jsii.String("AWS"), &awsprovider.AwsProviderConfig{
        Region: jsii.String("us-west-1"),
    })

    instance := instance.NewInstance(stack, jsii.String("compute"), &instance.InstanceConfig{
        Ami:          jsii.String("ami-01456a894f71116f2"),
        InstanceType: jsii.String("t2.micro"),
    })

    cdktf.NewTerraformOutput(stack, jsii.String("public_ip"), &cdktf.TerraformOutputConfig{
        Value: instance.PublicIp(),
    })

    return stack
}

func main() {
	app := cdktf.NewApp(nil)

	stack := NewMyStack(app, "learn-cdktf")
	cdktf.NewCloudBackend(stack, &cdktf.CloudBackendConfig{
		Hostname:     jsii.String("app.terraform.io"),
		Organization: jsii.String("htunnthuthu"),
		Workspaces:   cdktf.NewNamedCloudWorkspace(jsii.String("learn-cdktf")),
	})

	app.Synth()
}
