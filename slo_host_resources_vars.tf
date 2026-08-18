variable "slo_window" {
  description = "Ventana de evaluación del SLO (sintaxis global timeframe, ej. -4w, -1M, -2d to now). Industry: ventana mensual rodante para detectar burn sobre el mes natural."
  type        = string
  default     = "-4w"
}

# --- Umbrales de saturación por recurso ---
# Parámetros de industria (Google SRE Book / Dynatrace best practice):
#   CPU      -> 80% es el techo sostenido antes de impacto en latencia/capacidad
#   Memoria  -> 80% utilización es el límite de comodidad operativo
#   Disco    -> 80% utilizado es el límite aceptado antes de riesgo de fill-rate
variable "cpu_threshold_pct" {
  description = "Umbral de CPU (%) bajo el cual el recurso se considera saludable en el SLI."
  type        = number
  default     = 80
}

variable "mem_threshold_pct" {
  description = "Umbral de memoria (%) bajo el cual el recurso se considera saludable en el SLI."
  type        = number
  default     = 80
}

variable "disk_threshold_pct" {
  description = "Umbral de disco (%) bajo el cual el recurso se considera saludable en el SLI."
  type        = number
  default     = 80
}

# --- Targets SLO (porcentaje de buen estado) ---
# target_success = objetivo del SLO; por debajo => incumplimiento.
# target_warning = nivel de aviso (cerca de incumplir).
# Industry: 99.0% = ~7h16m de error al mes; 99.5% = ~3h38m; 99.9% = ~43m.
variable "slo_target_pct_cpu" {
  description = "Objetivo de éxito (%) del SLO de CPU."
  type        = number
  default     = 99.0
}

variable "slo_target_pct_mem" {
  description = "Objetivo de éxito (%) del SLO de memoria."
  type        = number
  default     = 99.0
}

variable "slo_target_pct_disk" {
  description = "Objetivo de éxito (%) del SLO de disco."
  type        = number
  default     = 99.0
}

variable "warning_burn_rate" {
  description = "Burn rate que separa slow-burn de fast-burn (fast_burn_threshold). Industry: 14.4 (~5% del budget en 1h) = incidente serio."
  type        = number
  default     = 14.4
}
