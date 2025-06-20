## Create a Artifact Registry Repository

- Go to the [Google Cloud Console](https://console.cloud.google.com/).
- Select your project
- Navigate to **Artifact Registry** in the left sidebar.
- Click on **Create Repository**.
- Fill in the repository details:
  - **Name**: Choose a name for your repository.
  - **Format**: Select `Docker`.
  - **Location**: Choose a region or multi-region.
  - **Description**: Optionally, add a description.

- Click **Create** to create the repository.

## Authenticate Docker to Google Artifact Registry



- Open a terminal.
- Run the following command to configure Docker to use the Google Artifact Registry:

```bash
gcloud auth configure-docker <LOCATION>-docker.pkg.dev
```
Replace `<LOCATION>` with the region or multi-region where your repository is located (e.g., `us-central1`).

## Build and Push Docker Image to Artifact Registry

- Navigate to the directory containing your Dockerfile.
- Build your Docker image using the following command:

```bash
docker build -t <LOCATION>-docker.pkg.dev/<PROJECT_ID>/<REPOSITORY_NAME>/<IMAGE_NAME>:<TAG> .
```

Replace `<LOCATION>`, `<PROJECT_ID>`, `<REPOSITORY_NAME>`, `<IMAGE_NAME>`, and `<TAG>` with your specific values.

### Example:
```bash
us-central1-docker.pkg.dev/my-kubernetes-project-456513/my-docker-repo/spring-boot:latest .

```

- Push the Docker image to the Artifact Registry using the following command:

```bash
docker push <LOCATION>-docker.pkg.dev/<PROJECT_ID>/<REPOSITORY_NAME>/<IMAGE_NAME>:<TAG>
```

Replace the placeholders with your specific values as before.
### Example:
```bash
docker push us-central1-docker.pkg.dev/my-kubernetes-project-456513/my-docker-repo/spring-boot:latest
```

## Verify the Docker Image in Artifact Registry
- Go back to the [Google Cloud Console](https://console.cloud.google.com/).
- Navigate to **Artifact Registry**.
- Select your repository.
- You should see your pushed Docker image listed there with the specified tag.
- You can click on the image to view its details, including tags and layers.
