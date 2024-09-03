data "http" "flux_manifestfile" {
  count = local.tf_integrations_count
  url   = "https://raw.githubusercontent.com/cnoe-io/stacks/main/terraform-integrations/fluxcd.yaml"
}
resource "kubectl_manifest" "flux_manifest" {
  yaml_body = data.http.flux_manifestfile.body
}

data "http" "tofu_manifestfile" {
  count = local.tf_integrations_count
  url   = "https://raw.githubusercontent.com/cnoe-io/stacks/main/terraform-integrations/tofu-controller.yaml"
}

resource "kubectl_manifest" "tofu_manifest" {
  yaml_body = data.http.tofu_manifestfile.body
}
