# Copyright (c) 2020 Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

variable "account" {
  description = "Account parameter"
  type = object({
    tenancy_id     = string,
    class          = number,
    compartment_id = string,
    home           = string,
    user_id        = string
  })
}

variable "options" {
  description = "Input from the schema file."
  type = object({
    create   = string,
    password = string
  })
}

variable "configuration" {
  description = "Retrieve asset configurations."
  type = object({
    service = any
  })
}

variable "assets" {
  description = "Retrieve deployment results."
  type = object({
    database   = any,
    encryption = any,
    network    = any,
    resident   = any
  })
}