1. Set up the Azure Functions CLI (for VS Code https://docs.microsoft.com/en-us/azure/azure-functions/create-first-function-vs-code-csharp?tabs=in-process)

2. Install Rookout Nuget Package (https://www.nuget.org/packages/Rookout)

    csproj snippet:

    ```

    <Project Sdk="Microsoft.NET.Sdk">
        <PropertyGroup>
            <TargetFramework>net6.0</TargetFramework>
            <AzureFunctionsVersion>v4</AzureFunctionsVersion>
        </PropertyGroup>
        <ItemGroup>
            <PackageReference Include="Microsoft.NET.Sdk.Functions" Version="4.1.1" />
            <PackageReference Include="Rookout" Version="0.1.117" />
        </ItemGroup>
        <ItemGroup>
            <None Update="host.json">
            <CopyToOutputDirectory>PreserveNewest</CopyToOutputDirectory>
            </None>
            <None Update="local.settings.json">
            <CopyToOutputDirectory>PreserveNewest</CopyToOutputDirectory>
            <CopyToPublishDirectory>Never</CopyToPublishDirectory>
            </None>
        </ItemGroup>
    </Project>
    
    ```

3. Set up Rookout Options at the begining of your function. This can also be set as environment variables (https://docs.rookout.com/docs/setup-guide/#configuration). Make sure you replace the rookout token place holder with your token. This can be found under settings icon in the bottom left of the https://app.rookout.com appplication):

    ```
        Rook.RookOptions options = new Rook.RookOptions() 
        {
            token = "[Your Rookout Token]",
            labels = new Dictionary<string, string> { { "env", "dev" } }
        };

    ```

4.  Wrap function in Rook Start Lamba (either with await or without):
        
    With options set in lamba

    ```

        await using (Rook.API.StartLambda(options)) {

                //Function Logic Here
            }

    ```

    OR
    
    with options defined as environment variables (https://docs.rookout.com/docs/dotnet-setup/#sdk-api)

    ```

        await using (Rook.API.StartLambda()) {

            //Function Logic Here
        }

    ```
    

5. Deploy the code:

    via cmd (https://docs.microsoft.com/en-us/azure/azure-functions/functions-core-tools-reference?tabs=v2#func-azure-functionapp-publish) 
    
    func azure functionapp publish <FunctionAppName>

    or

    via VS Code (https://docs.microsoft.com/en-us/azure/azure-functions/functions-develop-vs-code?tabs=csharp#sign-in-to-azure)

    or

    via zip deployment (https://docs.microsoft.com/en-us/azure/azure-functions/deployment-zip-push)

    

6. Run the function and go to app.rookout.com and start debugging!