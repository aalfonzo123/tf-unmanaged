 variable "network" {
  type = object({
    project-id      = string
    vpc-name        = string
    subnetwork-name = string
    region          = string
  })
}

variable "source-image" {

}

variable "zone" {
  
}