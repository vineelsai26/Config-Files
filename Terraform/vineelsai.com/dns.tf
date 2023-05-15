resource "cloudflare_record" "duplicati" {
  name    = "duplicati"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = "144.24.140.207"
  zone_id = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "gogs" {
  name    = "gogs"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = "144.24.140.207"
  zone_id = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "nextcloud" {
  name    = "nextcloud"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = "144.24.140.207"
  zone_id = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "nginx" {
  name    = "nginx"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = "144.24.140.207"
  zone_id = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "oc1" {
  name    = "oc1"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = "144.24.140.207"
  zone_id = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "portainer" {
  name    = "portainer"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = "144.24.140.207"
  zone_id = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "rce" {
  name    = "rce"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = "144.24.140.207"
  zone_id = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "router" {
  name    = "router"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "10.0.0.1"
  zone_id = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "uptime" {
  name    = "uptime"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = "144.24.140.207"
  zone_id = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "vineelsai" {
  name    = "vineelsai.com"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = "76.76.21.21"
  zone_id = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "verify_bing_com" {
  name    = "73cbc6edc61fddc335a4765e56ec4d32"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = "verify.bing.com"
  zone_id = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "acloled2losoaiyn3zxjxinf6qclsjvr_domainkey" {
  name    = "acloled2losoaiyn3zxjxinf6qclsjvr._domainkey"
  proxied = false
  ttl     = 3600
  type    = "CNAME"
  value   = "acloled2losoaiyn3zxjxinf6qclsjvr.dkim.amazonses.com"
  zone_id = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "algo" {
  name    = "algo"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "cname.vercel-dns.com"
  zone_id = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "api_collab" {
  name    = "api.collab"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "collab.up.railway.app"
  zone_id = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "archive1" {
  name    = "archive1"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = "portfolio-archive-1.pages.dev"
  zone_id = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "archive2" {
  name    = "archive2"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = "portfolio-archive-2.pages.dev"
  zone_id = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "archive3" {
  name    = "archive3"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = "portfolio-archive-3.pages.dev"
  zone_id = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "archive4" {
  name    = "archive4"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = "portfolio-archive-4.pages.dev"
  zone_id = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "balance" {
  name    = "balance"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "cname.vercel-dns.com"
  zone_id = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "blog" {
  name    = "blog"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "cname.vercel-dns.com"
  zone_id = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "collab" {
  name    = "collab"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "cname.vercel-dns.com"
  zone_id = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "_domainconnect" {
  name    = "_domainconnect"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = "connect.domains.google.com"
  zone_id = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "material" {
  name    = "material"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = "material-design-icons.pages.dev"
  zone_id = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "portfolio" {
  name    = "portfolio"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "cname.vercel-dns.com"
  zone_id = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "privacy" {
  name    = "privacy"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "cname.vercel-dns.com"
  zone_id = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "repo" {
  name    = "repo"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "cname.vercel-dns.com"
  zone_id = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "shortify" {
  name    = "shortify"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = "shortify-vs.up.railway.app"
  zone_id = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "slg7cli4o536qdyhdphrvhivpas2ebfv_domainkey" {
  name    = "slg7cli4o536qdyhdphrvhivpas2ebfv._domainkey"
  proxied = false
  ttl     = 3600
  type    = "CNAME"
  value   = "slg7cli4o536qdyhdphrvhivpas2ebfv.dkim.amazonses.com"
  zone_id = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "sn6cjudhadoldlhxvpgtqail76zucccs_domainkey" {
  name    = "sn6cjudhadoldlhxvpgtqail76zucccs._domainkey"
  proxied = false
  ttl     = 3600
  type    = "CNAME"
  value   = "sn6cjudhadoldlhxvpgtqail76zucccs.dkim.amazonses.com"
  zone_id = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "stats_github" {
  name    = "stats.github"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "cname.vercel-dns.com"
  zone_id = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "sudoku" {
  name    = "sudoku"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "cname.vercel-dns.com"
  zone_id = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "tictactoe" {
  name    = "tictactoe"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "cname.vercel-dns.com"
  zone_id = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "www" {
  name    = "www"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "cname.vercel-dns.com"
  zone_id = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "terraform_managed_resource_e914a9dfcf403761bbf9d77874eee60f" {
  name     = "vineelsai.com"
  priority = 41
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = "route3.mx.cloudflare.net"
  zone_id  = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "terraform_managed_resource_b66fad6227316f4e40eeba9369064f69" {
  name     = "vineelsai.com"
  priority = 32
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = "route2.mx.cloudflare.net"
  zone_id  = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "terraform_managed_resource_9435f5b55a3493c2f097c4e645ce43c1" {
  name     = "vineelsai.com"
  priority = 52
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = "route1.mx.cloudflare.net"
  zone_id  = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "netlify_NS4" {
  name    = "netlify"
  proxied = false
  ttl     = 3600
  type    = "NS"
  value   = "dns4.p01.nsone.net"
  zone_id = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "netlify_NS3" {
  name    = "netlify"
  proxied = false
  ttl     = 3600
  type    = "NS"
  value   = "dns3.p01.nsone.net"
  zone_id = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "netlify_NS2" {
  name    = "netlify"
  proxied = false
  ttl     = 3600
  type    = "NS"
  value   = "dns2.p01.nsone.net"
  zone_id = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "netlify_NS1" {
  name    = "netlify"
  proxied = false
  ttl     = 3600
  type    = "NS"
  value   = "dns1.p01.nsone.net"
  zone_id = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "_dmarc" {
  name    = "_dmarc"
  proxied = false
  ttl     = 1
  type    = "TXT"
  value   = "v=DMARC1; p=reject; sp=none; rua=mailto:vineelsai26@gmail.com; rua=mailto:dmarc@mailinblue.com!10m; ruf=mailto:dmarc@mailinblue.com!10m; rf=afrf; pct=100; ri=86400"
  zone_id = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "_github-challenge-vsarchive-org" {
  name    = "_github-challenge-vsarchive-org"
  proxied = false
  ttl     = 3600
  type    = "TXT"
  value   = "ffe28bf4b9"
  zone_id = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "_github-pages-challenge-vineelsai26" {
  name    = "_github-pages-challenge-vineelsai26"
  proxied = false
  ttl     = 3600
  type    = "TXT"
  value   = "66bb594c84008a9e1ee91a7798b052"
  zone_id = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "mail_domainkey" {
  name    = "mail._domainkey"
  proxied = false
  ttl     = 1
  type    = "TXT"
  value   = "k=rsa;p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDeMVIzrCa3T14JsNY0IRv5/2V1/v2itlviLQBwXsa7shBD6TrBkswsFUToPyMRWC9tbR/5ey0nRBH0ZVxp+lsmTxid2Y2z+FApQ6ra2VsXfbJP3HE6wAO0YTVEJt1TmeczhEd2Jiz/fcabIISgXEdSpTYJhb0ct0VJRxcg4c8c7wIDAQAB"
  zone_id = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "vineelsai_TXT1" {
  name    = "vineelsai.com"
  proxied = false
  ttl     = 1
  type    = "TXT"
  value   = "v=spf1 include:_spf.mx.cloudflare.net ~all"
  zone_id = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "vineelsai_TXT2" {
  name    = "vineelsai.com"
  proxied = false
  ttl     = 1
  type    = "TXT"
  value   = "have-i-been-pwned-verification=6ca260fac504238160cc8fc87c81f628"
  zone_id = "774c57de3172a6220c23461a2992c3a8"
}

resource "cloudflare_record" "_visual-studio-marketplace-vineelsai" {
  name    = "_visual-studio-marketplace-vineelsai"
  proxied = false
  ttl     = 1
  type    = "TXT"
  value   = "cd1f1949-69dc-43b8-bb74-bcdb1eedabe7"
  zone_id = "774c57de3172a6220c23461a2992c3a8"
}

