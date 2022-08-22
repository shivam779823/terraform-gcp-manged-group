
# forwarding rule
resource "google_compute_global_forwarding_rule" "default" {
  name                  = "lb-forwarding-rule"
  provider              = google-beta
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  port_range            = "80"
  target                = google_compute_target_http_proxy.default.id
  ip_address            = google_compute_global_address.default.id
}

# http proxy
resource "google_compute_target_http_proxy" "default" {
  name     = "lb-target-http-proxy"
  provider = google-beta
  url_map  = google_compute_url_map.default.id
}

# url map
resource "google_compute_url_map" "default" {
  name            = "lb-url-map"
  provider        = google-beta
  default_service = google_compute_backend_service.default.id
}


# backend service with custom request and response headers
resource "google_compute_backend_service" "default" {
  name                     = "lb-backend-service"
  provider                 = google-beta
  protocol                 = "HTTP"
  port_name                = "http"
  
  load_balancing_scheme    = "EXTERNAL"
  timeout_sec              = 10
  enable_cdn               = false

#   custom_request_headers   = ["X-Client-Geo-Location: {client_region_subdivision}, {client_city}"]
#   custom_response_headers  = ["X-Cache-Hit: {cdn_cache_status}"]
  health_checks            = [google_compute_health_check.default.id]
  backend {
    group           = google_compute_instance_group_manager.default.instance_group
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }
}

