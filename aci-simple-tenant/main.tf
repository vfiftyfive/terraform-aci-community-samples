locals {
  username  = "admin"
  password  = "ins3965!"
  url       = "https://172.31.186.4"
  tenant    = "TF-tenant"
  bd        = "bd-1"
  vrf       = "vrf-1"
  bd_subnet = "192.168.10.1/24"
}

provider "aci" {
  username = local.username
  password = local.password
  url      = local.url
  insecure = true
}

resource "aci_tenant" "terraform_ten" {
  name = local.tenant
}

resource "aci_vrf" "vrf1" {
  tenant_dn = aci_tenant.terraform_ten.id
  name      = local.vrf
}

resource "aci_bridge_domain" "bd1" {
  tenant_dn          = aci_tenant.terraform_ten.id
  relation_fv_rs_ctx = aci_vrf.vrf1.name
  name               = local.bd
}

resource "aci_subnet" "bd1_subnet" {
  bridge_domain_dn = aci_bridge_domain.bd1.id
  ip               = local.bd_subnet
}