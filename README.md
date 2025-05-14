## GCloud Commands

### Login to GCloud

```bash
gcloud auth login
```

### List all Projects

```bash
gcloud projects list
```

### Switch Project

```bash
gcloud config set projrct [project-id]
```


### List all the VMs

```bash
gcloud compute instances list
```

### SSH to the instance

```bash
gcloud compute ssh [Instance-id] --zone=[Zone]

## example
gcloud compute ssh my-ubuntu-instance --zone=us-central1-c

```






