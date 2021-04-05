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


## Rookout Integration explained

1. The Rookout integration is accomplished by adding the Rookout library.
    This is accomplished with adding it to your code.
    ```bash
       using Rook;
    ```
    Add its dependency As `Directory.Build.props` file:
   ```xml
   <Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003">

     <ItemGroup>
       <PackageReference Include="Rookout" Version="0.1.*" />
     </ItemGroup>

   </Project>
   ```
   
   You can also skip the `Directory.Build.props` file and add directly to your .csproj file:
    ```xml
     <ItemGroup>
        <PackageReference Include="Rookout" Version="0.1.*" />
     </ItemGroup>
    ```

2. Start the Rookout SDK with the API:
    ```bash
    Rook.RookOptions options = new Rook.RookOptions()
    {
        labels = new Dictionary<string, string> { { "env", "dev" } }
    };
    Rook.API.Start(options);
    ```
    Make sure you also add the proper dependency for 'Dictionary' in order to define your application's [labels](https://docs.rookout.com/docs/projects-labels/).
    ```bash
    using System.Collections.Generic;
    ```
   
3. Note that when you deploy your application, you will need to deploy your application's PDB file with it. Read more [here](https://docs.rookout.com/docs/dotnet-setup/#debug-information)



[DotNet + Rookout]: https://docs.rookout.com/docs/dotnet-setup/
