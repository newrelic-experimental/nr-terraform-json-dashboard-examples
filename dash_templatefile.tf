
# Here we demonstrate using a templatefile. For dashboards with many replacement values this may be cleaner than using replace().
locals {
    templatefile_render = templatefile(
               "${path.module}/dashboards/dashboard.json.tftpl",
               {
                DASHBOARD_NAME = "JSON - Templatefile dashboard"
                ACCOUNTID = var.accountId
               }
        )
}

resource "newrelic_one_dashboard_json" "templatefile_dashboard" {
   json = local.templatefile_render
}

#Lets tag terraform managed dashboards!
resource "newrelic_entity_tags" "templatefile_dashboard" {
    guid = newrelic_one_dashboard_json.templatefile_dashboard.guid
    tag {
        key = "terraform"
        values = [true]
    }
}

output "templatefile_dashboard" {
  value=newrelic_one_dashboard_json.templatefile_dashboard.permalink 
}
