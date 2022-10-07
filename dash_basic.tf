
# Super simple to load in the JSON from file. Simply use the copy as JSON icon on the UI and paste into the basic.json file. 

# Note: This default dashboard JSON *will not display correctly* on your own account as the source JSON hard codes the account ID value.
# See dash_replace.tf for version that should work in your own account :)

resource "newrelic_one_dashboard_json" "basic_dashboard" {
   json = file("${path.module}/dashboards/dashboard.json")
}

#Lets tag terraform managed dashboards!
resource "newrelic_entity_tags" "basic_dashboard" {
    guid = newrelic_one_dashboard_json.basic_dashboard.guid
    tag {
        key = "terraform"
        values = [true]
    }
}

output "basic_dashboard" {
  value=newrelic_one_dashboard_json.basic_dashboard.permalink 
}
