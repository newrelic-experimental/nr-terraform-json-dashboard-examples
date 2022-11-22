# New Relic Terraform Dashboards from JSON Templates
This example shows how you can use the [newrelic_one_dashboards_json](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/one_dashboard_json) resource to provision dashboards. It includes an example for composing a dashboard from configuration (both manual and NRQL sourced), making it easy to build complex dashboards with ease.

* [dash_basic.tf](dash_basic.tf) - the simplest example, copy your dashboard to clipboard and paste the json into the basic.json file.
* [dash_replacer.tf](dash_replacer.tf) - this example takes the same dashboard but replaces some values in the title and NRQL account id's using replace().
* [dash_templatefile.tf](dash_templatefile.tf) - this example takes the same dashboard but uses a templatefile() method to set title and NRQL account id's.
* [dash_composed.tf](dash_composed.tf) - this example shows how a complex dashboard can be built using template iteration. Super cool.
* [dash_nrql_composed.tf](dash_nrql_composed.tf) - this example extneds the previous and shows how a complex dashboard can be built using template iteration driven by an NRQL query that determines what items to include.

## Installation
Make sure [terraform is installed](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli). I highly recommend using the super-useful terraform version manager [tfenv](https://github.com/tfutils/tfenv) for managing your terraform binaries. 

This project includes a helper script to run terraform with the necessary configuration. Update the `runtf.sh.sample` file with your credentials and accont details and rename it `runtf.sh`. **Important do not commit this new file to git!** (It should be ignored in `.gitignore` already)

Note: You may want to update the version numbers in [provider.tf](provider.tf) to the latest versions of Terraform and the New Relic provider. You must be using New Relic provider version 3.4.0 or above for JSON dashboards to be supported.

## Initialisation
Use the `runtf.sh` helper script configured aboe wherever you would normally run `terraform`. It simply wraps the terraform with some environment variables that make it easier to switch between projects. (You dont have to do it this way, you could just set the env vars and run terraform normally)

First initialise terraform:
```
./runtf.sh init
```

Now apply the changes:
```
./runtf.sh apply
```

## State storage
This example does not include remote state storage. State will be stored locally.

