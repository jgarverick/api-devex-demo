# Use the official .NET SDK image to build the project
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy the .csproj file and restore dependencies
COPY grpc.csproj .
RUN dotnet restore

# Copy the rest of the application code
COPY . .

# Build the application
RUN dotnet publish -c Release -o /app

# Use the official .NET runtime image to run the application
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /app .

# Expose the port the app runs on
EXPOSE 80

# Run the application
ENTRYPOINT ["dotnet", "grpc.dll"]
# Set environment variables
ENV ASPNETCORE_URLS=http://+:80
ENV DOTNET_RUNNING_IN_CONTAINER=true

# Set the entry point for the container
ENTRYPOINT ["dotnet", "grpc.dll"]
