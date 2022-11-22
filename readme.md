# New Relic Terraform Dashboards from JSON Templates
This example shows how you can use the [newrelic_one_dashboards_json](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/one_dashboard_json) resource to provision dashboards. It includes an example for composing a dashboard from configuration (both manual and NRQL sourced), making it easy to build complex dashboards with ease.

* [dash_basic.tf](dash_basic.tf) - the simplest example, copy your dashboard to clipboard and paste the json into the basic.json file.
* [dash_replacer.tf](dash_replacer.tf) - this example takes the same dashboard but replaces some values in the title and NRQL account id's using replace().
* [dash_templatefile.tf](dash_templatefile.tf) - this example takes the same dashboard but uses a templatefile() method to set title and NRQL account id's.
* [dash_composed.tf](dash_composed.tf) - this example shows how a complex dashboard can be built using template iteration. Super cool.
* [dash_nrql_composed.tf](dash_nrql_composed.tf) - this example extends the previous and shows how a complex dashboard can be built using template iteration driven by an NRQL query that determines what items to include.

## Installation
Make sure [terraform is installed](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli). I highly recommend using the super-useful terraform version manager [tfenv](https://github.com/tfutils/tfenv) for managing your terraform binaries. 

This project includes a helper script for running terraform and providing the necessary variables (see below). If you would rather run terraform directly then you need to set up the following environment variables:

- NEW_RELIC_ACCOUNT_ID : Your account ID
- NEW_RELIC_API_KEY:  A User API Key

You would then run terraform as follows:
`terraform plan -var=\"accountId=${NEW_RELIC_ACCOUNT_ID}\" -var=\"NEW_RELIC_API_KEY=${NEW_RELIC_API_KEY}\""`

## Helper Script
The helper script simplifies the running of terraform with necessary configuration on a mac. Update the `runtf.sh.sample` file with your API key and account ID details and rename it `runtf.sh`. **Important do not commit this new file to git!** (It should be ignored in `.gitignore` already)

### Using the helper script
Use the `runtf.sh` helper script configured aboe wherever you would normally run `terraform`. It simply wraps the terraform with some environment variables that make it easier to switch between projects. (You dont have to do it this way, you could just set the env vars and run terraform normally)

First initialise terraform:
```
./runtf.sh init
```

Now use the script as required wher eyou would normally run terraform, eg:
```
./runtf.sh plan
```

## State storage
This example does not include remote state storage. State will be stored locally.

