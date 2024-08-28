#---------------------------------------------------------------
# Gitea installation
#---------------------------------------------------------------

resource "kubectl_manifest" "application_argocd_gitea" {

  yaml_body = templatefile("${path.module}/templates/argocd-apps/gitea.yaml", {
    GITHUB_URL = "https://github.com/elamaran11/cnoe-appmod-implementation.git"
    PATH       = "packages/gitea"
  })
}


