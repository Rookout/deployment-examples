using System;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using System.Collections.Generic;
using Rook;
using System.Reflection;


namespace SimpleHttpServer
{
    public class Program
    {
        private static string GetBuildHashFromAssembly()
        {
            var assembly = Assembly.GetExecutingAssembly();
            var customAttributes = assembly?.CustomAttributes ?? Enumerable.Empty<CustomAttributeData>();
            return customAttributes
                // MSBuildGitHash adds custom attribute to assembly of the following format:
                // [assembly: AssemblyMetadata("GitHash", "MYHASHVAL")]
                .Where(c => c.ConstructorArguments.Count >= 2 && c.ConstructorArguments[0].Value as string == "GitHash")
                .Select(c => c.ConstructorArguments[1].Value as string)
                .FirstOrDefault() ?? "??";
        }
        private static string GetBuildOriginFromAssembly()
        {
            var assembly = Assembly.GetExecutingAssembly();
            var customAttributes = assembly?.CustomAttributes ?? Enumerable.Empty<CustomAttributeData>();
            return customAttributes
                // MSBuildGitHash adds custom attribute to assembly of the following format:
                // [assembly: AssemblyMetadata("GitRepository", "MYURL")]
                .Where(c => c.ConstructorArguments.Count >= 2 && c.ConstructorArguments[0].Value as string == "GitRepository")
                .Select(c => c.ConstructorArguments[1].Value as string)
                .FirstOrDefault() ?? "??";
        }
        public static void Main(string[] args)
        {
            Console.WriteLine(GetBuildHashFromAssembly());
            Console.WriteLine(GetBuildOriginFromAssembly());

			Rook.RookOptions options = new Rook.RookOptions()
            {
                labels = new Dictionary<string, string> { { "env", "dev" } }
            };
            Rook.API.Start(options);

            // Default options
            var contentRoot = Directory.GetCurrentDirectory();
            var port = 8000;

            // Parse arguments
            var remainingArgs = args.ToList();
            while (remainingArgs.Count > 0)
            {
                if (Directory.Exists(remainingArgs.First()))
                {
                    contentRoot = remainingArgs.First();
                }
                else if (int.TryParse(remainingArgs.First(), out int customPort))
                {
                    port = customPort;
                }
                else
                {
                    break;
                }

                remainingArgs = remainingArgs.Skip(1).ToList();
            }

            var host = new WebHostBuilder()
                .UseUrls("http://*:" + port)
                .UseContentRoot(contentRoot)
                .UseKestrel()
                .UseStartup<Startup>()
                .Build();

            host.Run();
        }
    }

    internal class Startup
    {
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddDirectoryBrowser();
        }

        public void Configure(IApplicationBuilder app, ILoggerFactory loggerFactory, IHostingEnvironment hostingEnvironment)
        {
            //loggerFactory.AddConsole();

            var options = new FileServerOptions()
            {
                FileProvider = hostingEnvironment.ContentRootFileProvider,
                RequestPath = new PathString(string.Empty),
                EnableDirectoryBrowsing = true,
                EnableDefaultFiles = false
            };

            options.StaticFileOptions.ServeUnknownFileTypes = true;

            //app.UseFileServer(options);

            app.Use(async (context, next) =>
            {
                // Do work that doesn't write to the Response.
                await next.Invoke();
                // Do logging or other work that doesn't write to the Response.
            });

            app.Run(async context =>
            {
                await context.Response.WriteAsync("Hello, World for dotnet 3!!\n" + Microsoft.AspNetCore.Http.Extensions.UriHelper.GetEncodedUrl(context.Request));
            });
        }
    }
}
