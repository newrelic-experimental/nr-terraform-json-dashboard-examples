variable NEW_RELIC_API_KEY { 
    type = string
}

provider "graphql" {
  url = "https://api.newrelic.com/graphql"
  headers = {
    "API-Key" = var.NEW_RELIC_API_KEY
  }
}

data "graphql_query" "basic_query" {
  query_variables = { 
    accountId = var.accountId
  }
  query     = file("./getTopFiveApis.gql")
}

# Uncoment to see the output from the NRQL query
# output "response" {
#     value = data.graphql_query.basic_query.query_response
# }


# This generates the 'rows' of widgets from the CONFIG object
data "template_file" "nrql_widgets" {
    template = templatefile(
               "${path.module}/dashboards/nrql_composed_widgets.json.tftpl",
               {
                 ACCOUNTID = var.accountId
                 CONFIG = jsondecode(data.graphql_query.basic_query.query_response).data.actor.account.nrql.results
               }
        )
}

resource "newrelic_one_dashboard_json" "nrql_dashboard" {
   json = data.template_file.nrql_widgets.rendered
}

#Lets tag terraform managed dashboards!
resource "newrelic_entity_tags" "nrql_dashboard" {
    guid = newrelic_one_dashboard_json.nrql_dashboard.guid
    tag {
        key = "terraform"
        values = [true]
    }
}

output "nrql_dashboard" {
  value=newrelic_one_dashboard_json.nrql_dashboard.permalink 
}