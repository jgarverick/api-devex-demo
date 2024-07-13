using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Azure.Storage.Blobs;
using System;
using System.IO;
using System.Text;

namespace function
{
    public class PushFileUpdates
    {
        private readonly ILogger<PushFileUpdates> _logger;
        private readonly BlobServiceClient _blobServiceClient;

        public PushFileUpdates(ILogger<PushFileUpdates> logger, BlobServiceClient blobServiceClient)
        {
            _logger = logger;
            _blobServiceClient = blobServiceClient;
        }

        [Function("PushFileUpdates")]
        public IActionResult Run([HttpTrigger(AuthorizationLevel.Function, "get", "post")] HttpRequest req)
        {
            _logger.LogInformation("C# HTTP trigger function processed a request.");

            // Generate 15 random strings
            string[] randomStrings = GenerateRandomStrings(15);

            // Create a file in the storage account containing the random strings
            string containerName = "your-container-name";
            string fileName = "your-file-name.txt";
            string fileContent = string.Join(Environment.NewLine, randomStrings);
            UploadFileToStorageAccount(containerName, fileName, fileContent);

            // Log that a file was created
            _logger.LogInformation("File created in storage account");

            return new OkObjectResult("Welcome to Azure Functions!");
        }

        private string[] GenerateRandomStrings(int count)
        {
            string[] randomStrings = new string[count];
            Random random = new Random();

            for (int i = 0; i < count; i++)
            {
                byte[] buffer = new byte[8];
                random.NextBytes(buffer);
                randomStrings[i] = Convert.ToBase64String(buffer);
            }

            return randomStrings;
        }

        private void UploadFileToStorageAccount(string containerName, string fileName, string fileContent)
        {
            BlobContainerClient containerClient = _blobServiceClient.GetBlobContainerClient(containerName);
            BlobClient blobClient = containerClient.GetBlobClient(fileName);

            using (MemoryStream stream = new MemoryStream(Encoding.UTF8.GetBytes(fileContent)))
            {
                blobClient.Upload(stream, true);
            }
        }
    }
}
