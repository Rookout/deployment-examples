## Deploy Rookout Hybrid Deployment on Nomad with Docker Driver

This is example of job deployment for the Rookout Controller and Rookout Datastore on Nomad cluster with docker driver.

### Prerequisites

* Nomad Installed nomad [Tutorial](https://learn.hashicorp.com/tutorials/nomad/get-started-install)
* Access to Nomad cluster, or local dev cluster.
  

### Example Usage
1. Run `sudo nomad agent -dev -bind 0.0.0.0 -log-level INFO` to run local cluster.
2. `git clone https://github.com/Rookout/deployment-examples.git && cd deployment-examples/nomad`
2. Configure required variables to be used for job run in `rookout.vars`
3. run `nomad job run -var-file="rookout.vars" rookout.nomad`

### Variables

| Variable Name  | Description | Default |
| ------------- | ------------- | ------------- |
| rookout_token | Rookout token | "" |
| datacenter | nomad datacenter where to deploy | ["dc1"] |
| driver | nomad driver to use | "docker" |
| controller_settings | Controller Task specific settings | map(sting) see settings below |
| datastore_settings | Datastore Task specific settings | map(sting) see settings below |

#### Controller
| Setting name  | Description | Default |
| ------------- | ------------- | ------------- |
| count | How many containers to run | 1 |
| dop_no_ssl_verify |	set DOP_NO_SSL_VERIFY env variable | true |
| server_mode |	Controller server mode. `PLAIN` and `TLS` available  | PLAIN |
| cpu |	CPU for controller task  | 256 |
| mem |	Memory for controller task  | 256 |
| cert_path | local path to crt file if server_mode set to TLS | null |
| key_path | local path to key file if server_mode set to TLS | null |

#### Datastore
| Setting name  | Description | Default |
| ------------- | ------------- | ------------- |
| count | How many containers to run | 1 |
| in_memory_db |	set DOP_IN_MEMORY_DB env variable | true |
| server_mode |	datastore server mode. `PLAIN` and `TLS` available  | PLAIN |
| cpu |	CPU for datastore task  | 256 |
| mem |	Memory for datastore task  | 256 |
| cert_path | local path to crt file if server_mode set to TLS | null |
| key_path | local path to key file if server_mode set to TLS | null |