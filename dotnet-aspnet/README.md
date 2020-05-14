# Quickstart for .NET Core ASP.NET

A sample application for using Rookout API to debug a simple ASP.NET app.

Before following this guide we recommend reading the basic [DotNet + Rookout] guide.

## Running local application

1. Clone and compile the project:
     ```bash
    git clone https://github.com/Rookout/deployment-examples.git
    cd deployment-examples/dotnet-aspnet/dotnet-core-3
    ```
2. Export organization token:
```bash
 	export ROOKOUT_TOKEN=<Your Rookout Token>
```

3. Build and Run your project:
    ```bash
    dotnet run --framework netcoreapp3.0
    ```
4. Make sure everything worked: [http://localhost:8000/](http://localhost:8000/)

5. Go to [http://app.rookout.com](http://app.rookout.com) and start debugging! 

[DotNet + Rookout]: https://docs.rookout.com/docs/dotnet-setup/
