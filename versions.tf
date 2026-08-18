terraform {
  required_version = ">= 1.5"

  required_providers {
    dynatrace = {
      source  = "dynatrace-oss/dynatrace"
      version = ">= 1.30.0"
    }
  }
}

provider "dynatrace" {
  # Credenciales del entorno Dynatrace seleccionado en el chat (governed).
}
