resource "dynatrace_slo_v2" "host_cpu" {
  name               = "SLO - Host CPU utilization"
  custom_description = "% del periodo en que los hosts productivos mantienen CPU < 85%. Parámetro industrial: warning operativo desde 80%, saturación sostenida sobre 90%. Objetivo mensual: 95% de cumplimiento; warning de SLO: 98%."
  enabled            = true
  evaluation_type    = "AGGREGATE"
  evaluation_window  = "-4w"
  filter             = "type(\"HOST\"),not(entityName(\"wnproc-*\"))"
  metric_expression  = "100*falseToZero(countIf(lt(builtin:host.cpu.usage,85),true))/count(notNull(builtin:host.cpu.usage))"
  metric_name        = "slo_host_cpu_capacity"
  target_success     = 95
  target_warning     = 98

  error_budget_burn_rate {
    burn_rate_visualization_enabled = true
    fast_burn_threshold             = 14.4
  }
}

resource "dynatrace_slo_v2" "host_memory" {
  name               = "SLO - Host Memory utilization"
  custom_description = "% del periodo en que los hosts productivos mantienen memoria usada < 90%. Parámetro industrial: presión relevante desde 85%, crítico sobre 95%; para Linux se puede refinar después con memoria disponible/cache si se requiere. Objetivo mensual: 95% de cumplimiento; warning de SLO: 98%."
  enabled            = true
  evaluation_type    = "AGGREGATE"
  evaluation_window  = "-4w"
  filter             = "type(\"HOST\"),not(entityName(\"wnproc-*\"))"
  metric_expression  = "100*falseToZero(countIf(lt(builtin:host.mem.usage,90),true))/count(notNull(builtin:host.mem.usage))"
  metric_name        = "slo_host_memory_capacity"
  target_success     = 95
  target_warning     = 98

  error_budget_burn_rate {
    burn_rate_visualization_enabled = true
    fast_burn_threshold             = 14.4
  }
}

resource "dynatrace_slo_v2" "host_disk" {
  name               = "SLO - Host Disk utilization"
  custom_description = "% del periodo en que los discos de hosts productivos mantienen uso < 85%. Parámetro industrial: warning desde 80-85%, crítico sobre 90%, emergencia sobre 95%. Disco es más estricto porque quedarse sin espacio rompe logs, DBs, colas y despliegues. Objetivo mensual: 99%; warning de SLO: 99.5%."
  enabled            = true
  evaluation_type    = "AGGREGATE"
  evaluation_window  = "-4w"
  filter             = "type(\"HOST\"),not(entityName(\"wnproc-*\"))"
  metric_expression  = "100*falseToZero(countIf(lt(builtin:host.disk.used:bool(\"USED\")/builtin:host.disk.capacity:bool(\"USED\")*100,85),true))/count(notNull(builtin:host.disk.used))"
  metric_name        = "slo_host_disk_capacity"
  target_success     = 99
  target_warning     = 99.5

  error_budget_burn_rate {
    burn_rate_visualization_enabled = true
    fast_burn_threshold             = 14.4
  }
}
