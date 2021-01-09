# Digital Ocean Droplet Rebuild action

Rebuild an existing Digital Ocean droplet.

## Inputs:


### digital-ocean-access-token

    description: Reade/Write Digital Ocean api key
    required: true


### image

Digital Ocean image id (e.g. ubuntu-16-04-x64). One way to get a valid list 
of images is to do:

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




