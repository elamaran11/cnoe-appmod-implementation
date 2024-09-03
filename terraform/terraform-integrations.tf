resource "kubectl_manifest" "flux-manifest" {
  count     = local.tf_integrations_count
  yaml_body = file("https://raw.githubusercontent.com/cnoe-io/stacks/main/terraform-integrations/fluxcd.yaml")
}

resource "kubectl_manifest" "tofu-manifest" {
  count     = local.tf_integrations_count
  yaml_body = file("https://raw.githubusercontent.com/cnoe-io/stacks/main/terraform-integrations/tofu-controller.yaml")
}
