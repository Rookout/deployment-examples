using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Rook;

namespace myWebApp
{
    public class Program
    {
        public static void Main(string[] args)
        {
            Rook.RookOptions options = new Rook.RookOptions()
            {
                labels = new Dictionary<string, string> { { "env", "dev" } }
            };
            Rook.API.Start(options);

            CreateHostBuilder(args).Build().Run();
        }

        public static IHostBuilder CreateHostBuilder(string[] args) =>
            Host.CreateDefaultBuilder(args)
                .ConfigureWebHostDefaults(webBuilder =>
                {
                    webBuilder.UseStartup<Startup>();
                });
    }
}
