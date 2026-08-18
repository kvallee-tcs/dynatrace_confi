resource "dynatrace_slo_v2" "host_cpu" {
  name               = "SLO - Host CPU utilization"
  enabled            = true
  custom_description = "% del periodo con uso de CPU de host bajo el umbral (${var.cpu_threshold_pct}%). Saturar el budget significa CPU sostenida alta (riesgo de latencia/capacidad)."
  evaluation_type    = "AGGREGATE"
  evaluation_window  = var.slo_window
  filter             = "type(\"HOST\"),not(entityName(\"wnproc-*\"))"
  metric_expression  = "100*falseToZero(countIf(lt(builtin:host.cpu.usage,${var.cpu_threshold_pct}),true))/count(notNull(builtin:host.cpu.usage))"
  metric_name        = "slo_host_cpu"
  target_success     = var.slo_target_pct_cpu
  target_warning     = var.slo_target_pct_cpu + 0.5

  error_budget_burn_rate {
    burn_rate_visualization_enabled = true
    fast_burn_threshold             = var.warning_burn_rate
  }
}

resource "dynatrace_slo_v2" "host_memory" {
  name               = "SLO - Host Memory utilization"
  enabled            = true
  custom_description = "% del periodo con uso de memoria bajo el umbral (${var.mem_threshold_pct}%). Saturar indica presión de memoria y riesgo de swap/OOM."
  evaluation_type    = "AGGREGATE"
  evaluation_window  = var.slo_window
  filter             = "type(\"HOST\"),not(entityName(\"wnproc-*\"))"
  metric_expression  = "100*falseToZero(countIf(lt(builtin:host.mem.usage,${var.mem_threshold_pct}),true))/count(notNull(builtin:host.mem.usage))"
  metric_name        = "slo_host_memory"
  target_success     = var.slo_target_pct_mem
  target_warning     = var.slo_target_pct_mem + 0.5

  error_budget_burn_rate {
    burn_rate_visualization_enabled = true
    fast_burn_threshold             = var.warning_burn_rate
  }
}

resource "dynatrace_slo_v2" "host_disk" {
  name               = "SLO - Host Disk utilization"
  enabled            = true
  custom_description = "% del periodo con uso de disco bajo el umbral (${var.disk_threshold_pct}%). Saturar indica riesgo de quedarse sin espacio."
  evaluation_type    = "AGGREGATE"
  evaluation_window  = var.slo_window
  filter             = "type(\"HOST\"),not(entityName(\"wnproc-*\"))"
  metric_expression  = "100*falseToZero(countIf(lt(builtin:host.disk.used:bool(\"USED\")/builtin:host.disk.capacity:bool(\"USED\")*100,${var.disk_threshold_pct}),true))/count(notNull(builtin:host.disk.used))"
  metric_name        = "slo_host_disk"
  target_success     = var.slo_target_pct_disk
  target_warning     = var.slo_target_pct_disk + 0.5

  error_budget_burn_rate {
    burn_rate_visualization_enabled = true
    fast_burn_threshold             = var.warning_burn_rate
  }
}
