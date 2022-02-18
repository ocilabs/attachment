# Copyright (c) 2020 Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

variable "integration_instance_idcs_access_token" {

}

variable "integration_instance_consumption_model" {
  default = "UCM"
}

variable allow_listed_http_vcn {
  default = ""
}

provider "oci" {
  tenancy_ocid     = var.tenancy.id
  region           = var.resident.region.key
}

resource "oci_integration_integration_instance" "test_integration_instance" {
  #Required
  compartment_id            = var.input.resident.id
  display_name              = "displayName"
  integration_instance_type = "STANDARD"
  is_byol                   = "false"
  message_packs             = "10"

  #Optional
  consumption_model = "${var.integration_instance_consumption_model}"
  custom_endpoint {
    hostname = "hostname.com"
  }
  freeform_tags = {
    "bar-key" = "value"
  }

  idcs_at                = var.integration_instance_idcs_access_token
  is_file_server_enabled = true
  state                  = "ACTIVE"

  network_endpoint_details {
    allowlisted_http_ips = ["172.16.0.239/32"]
    allowlisted_http_vcns {
      allowlisted_ips = ["172.16.0.239/32"]
      id = "${var.allow_listed_http_vcn}"
    }
    is_integration_vcn_allowlisted = "false"
    network_endpoint_type = "PUBLIC"
  }

}

data "oci_integration_integration_instances" "test_integration_instances" {
  #Required
  compartment_id = var.compartment_id

  #Optional
  display_name = "displayName"
  state        = "Active"
}

data "oci_integration_integration_instance" "test_integration_instance" {
  #Required
  integration_instance_id = oci_integration_integration_instance.test_integration_instance.id
}
