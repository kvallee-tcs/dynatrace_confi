resource "dynatrace_platform_slo" "host_memory_headroom" {
  name        = "Host Memory Headroom"
  description = "% de la ventana con memoria de host < 85% (presion). Target 95%, warning 97%."
  tags        = ["managed-by:terraform", "team:platform", "sre:host-memory"]

  criteria {
    criteria_detail {
      target         = 95
      warning        = 97
      timeframe_from = "now-4w"
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
