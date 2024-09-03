resource "kubectl_manifest" "flux-manifest" {
  count     = local.tf_integrations_count
  yaml_body = file("${path.module}/templates/manifests/fluxcd.yaml")
}

resource "kubectl_manifest" "tofu-manifest" {
  count     = local.tf_integrations_count
  yaml_body = file("${path.module}/templates/manifests/tofu-controller.yaml")
}
