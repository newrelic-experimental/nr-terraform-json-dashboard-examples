# This defines the values we're expecting per widget - see terraform.tfvars for the actual configured values
variable "config" {
    type = list(object({
        name = string
        domain = string
  }))
}

locals {
  template_render = templatefile(
               "${path.module}/dashboards/composed_widgets.json.tftpl",
               {
                 ACCOUNTID = var.accountId
                 CONFIG = var.config
               }
        )
}

resource "newrelic_one_dashboard_json" "composed_dashboard" {
   json = local.template_render
}

#Lets tag terraform managed dashboards!
resource "newrelic_entity_tags" "composed_dashboard" {
    guid = newrelic_one_dashboard_json.composed_dashboard.guid
    tag {
        key = "terraform"
        values = [true]
    }
}

output "composed_dashboard" {
  value=newrelic_one_dashboard_json.composed_dashboard.permalink 
}

# uncomment this to see the json src thats composed (useful if you make a mistake!)
# output "composed_dashboard_src" {
#   value=local.template_render 
# }