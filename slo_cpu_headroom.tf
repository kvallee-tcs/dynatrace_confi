resource "dynatrace_platform_slo" "host_cpu_headroom" {
  name        = "Host CPU Headroom"
  description = "% de la ventana con CPU de host < 80% (umbral de saturacion). Target 95%, warning 97%."
  tags        = ["managed-by:terraform", "team:platform", "sre:host-cpu"]

  criteria {
    criteria_detail {
      target         = 95
      warning        = 97
      timeframe_from = "now-28d"
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
