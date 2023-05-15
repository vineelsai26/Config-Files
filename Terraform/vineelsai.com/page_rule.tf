resource "cloudflare_page_rule" "terraform_managed_resource_3fde3508324cc8298da15bff3235e87d" {
  priority = 1
  status   = "active"
  target   = "http://vineelsai.com/.well-known/acme-challenge/*"
  zone_id  = "774c57de3172a6220c23461a2992c3a8"
  actions {
    ssl = "off"
  }
}

