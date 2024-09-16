data "http" "flux_manifestfile" {
  count = local.tf_integrations_count
  url   = "https://raw.githubusercontent.com/cnoe-io/stacks/main/terraform-integrations/fluxcd.yaml"
}
resource "kubectl_manifest" "flux_manifest" {
  count     = local.tf_integrations_count
  yaml_body = data.http.flux_manifestfile[0].response_body
}

data "http" "tofu_manifestfile" {
  count = local.tf_integrations_count
  url   = "https://raw.githubusercontent.com/cnoe-io/stacks/main/terraform-integrations/tofu-controller.yaml"
}

resource "kubectl_manifest" "tofu_manifest" {
  count     = local.tf_integrations_count
  yaml_body = data.http.tofu_manifestfile[0].response_body
}


