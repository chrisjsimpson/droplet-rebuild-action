# Digital Ocean Droplet Rebuild action

Rebuild an existing Digital Ocean droplet using a Github Action.

- Rebuilding a Digital Ocean droplet is useful, because rebuilt droplets keep their
assigned ip address. See more https://www.digitalocean.com/docs/droplets/how-to/rebuild/

## Inputs:


### digital-ocean-access-token

    description: Reade/Write Digital Ocean api key
    required: true


### image

Digital Ocean image (also known as 'slug') to use as the image of your droplet
e.g. ubuntu-16-04-x64.

One way to get a valid list of images is to do:

```
curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer your-token" "https://api.digitalocean.com/v2/images?page=1&per_page=9999&type=distribution"|jq .images[].slug

```

required: true
default: ubuntu-20-04-x64

### droplet-id:

The id of the droplet to be rebuilt. You can find this by going to:
https://cloud.digitalocean.com/droplets

required: true


## Example usage:

```
on:
  workflow_dispatch:
  push:

jobs:
  rebuild_droplet_job:
    runs-on: ubuntu-20.04
    name: Rebuild Digital Ocean Droplet
    steps:
    - name: Trigger droplet rebuild & wait for completion
      uses: chrisjsimpson/droplet-rebuild-action@v1
      timeout-minutes: 20
      with:
        digital-ocean-access-token: ${{ secrets.DIGITAL_OCEAN_ACCESS_TOKEN }}
        droplet-id: ${{ secrets.DROPLET_ID }}
        image: ${{ secrets.IMAGE }}
```



