resource "dynatrace_slo" "host_cpu_availability" {
  name              = "Infrastructure - Host CPU Availability"
  enabled           = true
  evaluation_type   = "AGGREGATE"
  metric_expression = "(100*(1-((1*(filter(rate(dt.host.cpu.usage), filter(metric dt.host.cpu.usage > 80))))/(1*(filter(rate(dt.host.cpu.usage)))))))"
  target            = 95.0
  error_budget      = 5.0
  timeframe         = "-1w"
}

resource "dynatrace_slo" "host_memory_availability" {
  name              = "Infrastructure - Host Memory Availability"
  enabled           = true
  evaluation_type   = "AGGREGATE"
  metric_expression = "(100*(1-((1*(filter(rate(dt.host.memory.used.percent), filter(metric dt.host.memory.used.percent > 80))))/(1*(filter(rate(dt.host.memory.used.percent)))))))"
  target            = 95.0
  error_budget      = 5.0
  timeframe         = "-1w"
}
