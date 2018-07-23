# Quickstart for Serverless framework Python + Agentless Rookout on AWS Lambda

A sample application for using Serverless framework Python + Agentless Rookout on AWS Lambda
<details>
<summary>What is Agentless?</summary>
<p>
Instead of having to install your own Agent own the machine you are running the code from,
you can use one of our hosted Agents and just tell the Rook to connect to it.<br/>
For more information you can see <a href="https://docs.rookout.com/docs/installation-agent-remote.html">our documentation</a>
</p>
</details>


Before following this guide we recommend reading the basic [Python + Rookout] guide


## Rookout Integration Explained

There are 4 simple steps to integrate Rookout into your existing Serverless framework Python Lambda application for an agentless setup:

1. Add the pip dependency `rook` in the project folder

1. sls plugin install -n serverless-python-requirements

1. Set dockerizePip for true in the serverless.yml file in order to allow cross compiling 

1. Add Rookout's decorator to your lambda_handler function

1. Set the Rook's agent configuration as environment variables in the serverless.yml file
    
    More information can be found in [our documentation](https://docs.rookout.com/docs/installation-agent-remote.html)

## Rookout Integration Process

We have added Rookout to the original project by:
1. Installing rookout dependency : `pip install rook` 

1. Wrap your function by using our Rookout lambda decorator like so :
    ```python
    from rook.serverless import serverless_rook

    @serverless_rook
    def lambda_handler(event, context):
        return 'Hello World'
    ```
1. Add to your serverless.yml the serverless-python-requirements plugin:

```
plugins:
  - serverless-python-requirements
```

1. Set Lambda environment for `ROOKOUT_AGENT_HOST` (cloud.agent.rookout.com), `ROOKOUT_AGENT_PORT` (443) and `ROOKOUT_TOKEN` in order to connect to a remote hosted agent

```
environment:
 ROOKOUT_AGENT_HOST: cloud.agent.rookout.com
 ROOKOUT_AGENT_PORT: 443
 ROOKOUT_TOKEN:<YOUR_TOKEN>
```

1. Deploy your serverless functions using the serverless framework:

```
serverless deploy 
```

1. Go to [app.rookout.com](https://app.rookout.com) and start debugging !

