resource "dynatrace_platform_slo" "host_memory_headroom" {
  name        = "Host Memory Headroom"
  description = "Porcentaje de la ventana en el que la utilizacion de memoria de los hosts se mantiene por debajo del umbral del 85%. Presion de memoria sostenida por encima del umbral suele preceder swap/oom y degradacion; por eso se vigila como SLO de infraestructura."
  tags        = ["managed-by:terraform", "team:platform", "sre:host-memory"]

  criteria {
    criteria_detail {
      target         = 95
      warning        = 97
      timeframe_from = "now-1M"
      timeframe_to   = "now"
    }
  }

  custom_sli {
    indicator = <<-DQL
      timeseries mem = avg(dt.host.memory.usage), by: {dt.entity.host}
      | fieldsAdd sli = if(mem[] < 85, 100, else: 0)
    DQL
  }
}
