## Deploy Rookout Hybrid Deployment on Nomad with Docker Driver

This is example of job deployment for the Rookout Controller and Rookout Datastore on Nomad cluster with docker driver.

### Prerequisites

* Nomad Installed nomad [Tutorial](https://learn.hashicorp.com/tutorials/nomad/get-started-install)
* Access to Nomad cluster, or local dev cluster.
  

### Example Usage
1. Run `sudo nomad agent -dev -bind 0.0.0.0 -log-level INFO` to run local cluster.
2. `git clone https://github.com/Rookout/deployment-examples.git && cd deployment-examples/nomad`
2. Configure required variables to be used for job run in `rookout.vars`
3. run `nomad job run -var-file="testing.vars" rookout.nomad`

### Variables

| Variables  | Description | Default |
| ------------- | ------------- | ------------- |
| rookout_token | Rookout token | "" |
| datacenter | nomad datacenter where to deploy | ["dc1"] |
| driver | nomad driver to use | "docker" |
| controller_settings | Controller Task specific settings | "docker" |
| datastore_settings | Datastore Task specific settings | "docker" |
