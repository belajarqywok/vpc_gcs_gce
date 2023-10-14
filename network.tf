module "vpc" {
    source  = "terraform-google-modules/network/google"
    version = "~> 6.0.0"

    project_id   = "qwiklabs-gcp-04-cbc1e3b99bba"
    network_name = "tf-vpc-135562"
    routing_mode = "GLOBAL"

    subnets = [
        {
            subnet_name           = "subnet-01"
            subnet_ip             = "10.10.10.0/24"
            subnet_region         = "us-east1"
            description           = "subnet-01 10.10.10.0/24 us-east1"
        },

        {
            subnet_name           = "subnet-02"
            subnet_ip             = "10.10.20.0/24"
            subnet_region         = "us-east1"
            subnet_private_access = "true"
            subnet_flow_logs      = "true"
            description           = "subnet-02 10.10.20.0/24 us-east1"
        },
    ]
}

resource "google_compute_firewall" "tf-firewall"{
  name    = "tf-firewall"
 network = "projects/qwiklabs-gcp-04-cbc1e3b99bba/global/networks/tf-vpc-135562"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_tags = ["web"]
  source_ranges = ["0.0.0.0/0"]
}