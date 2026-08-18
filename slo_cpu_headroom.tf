resource "dynatrace_platform_slo" "host_cpu_headroom" {
  name        = "Host CPU Headroom"
  description = "Porcentaje de la ventana en el que la utilizacion de CPU de los hosts se mantiene por debajo del umbral de saturacion del 80%. SLO de tipo recurso/infraestructura (SRE): el error budget se quema cuando la CPU saturada degrada el rendimiento de la carga."
  tags        = ["managed-by:terraform", "team:platform", "sre:host-cpu"]

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
      timeseries cpu = avg(dt.host.cpu.usage), by: {dt.entity.host}
      | fieldsAdd sli = if(cpu[] < 80, 100, else: 0)
    DQL
  }
}
