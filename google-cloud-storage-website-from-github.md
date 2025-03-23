# Google Cloud Storage Website from GitHub Repository

I have GitHub projects that are best interacted with as websites. For example
the [maze-playground repo](https://github.com/ccouzens/maze-playground) is best
demoed [online](https://storage.googleapis.com/maze-playground/game.html). For
these, I've been using
[CI scripts](https://github.com/ccouzens/maze-playground/blob/main/build-and-release.bash)
within the repo to build and push to
[the bucket](https://console.cloud.google.com/storage/browser/maze-playground)
where users can then use it as
[a website](https://storage.googleapis.com/maze-playground/game.html).

I've chosen to manage my Google Cloud account manually rather than using tooling
like Terraform/OpenTofu. As such, to make this repeateable, I need to document
it.

## Why Not

Why not [GitHub Pages](https://docs.github.com/en/pages)? I can have multiple
repos acting semi independentily with the Google Cloud storage setup. With
GitHub Pages I can only have one website repo across all my repos. Using Google
Cloud storage for static assets is what I use professionally.

Why Not Infrastructure as Code like
[Terraform](https://www.terraform.io/)/[OpenTofu](https://opentofu.org/)? I find
it difficult to understand the options available to me without having first
configured services manually. I still consider myself at the exploring and
learning phase of Google Cloud Storage. I do not (currently) have an
infrastructure as code setup, in which I'd configure this.

## Steps

### Secure credentials

As recommended by the
[google-github-actions/auth Readme](https://github.com/google-github-actions/auth/blob/v2.1.8/README.md#prerequisites):

Add the following to any top level `.gitignore` or `.dockerignore` files:

```
# Ignore generated credentials from google-github-actions/auth
gha-creds-*.json
```

There is also a
[gcloudignore file](https://cloud.google.com/sdk/gcloud/reference/topic/gcloudignore),
but it isn't documented as affecting the `gcloud storage` command so it might
give an incorrect illusion of protection.

### Create Project

[Documentation](https://developers.google.com/workspace/guides/create-project)

[Page](https://console.cloud.google.com/projectcreate)

In my instance, I'm going to call it `bookish-funicular` after the project I'm
doing this for. I have no parent oraganisation.

### Create Bucket

[Documentation](https://cloud.google.com/storage/docs/creating-buckets)

[Page](https://console.cloud.google.com/storage/create-bucket)

In my case, I'm going to once again call it `bookish-funicular`. I accept the
default on "Optimise storage for data-intensive workloads" and "Labels".

For storage, I go single region "europe-west2 (London)" as it is slightly
cheaper than multi-region and ok for me.

For storage-class I go with Standard, becuase the description best matches my
case. But I'm not clear on the differences despite this
[documentation](https://cloud.google.com/storage/docs/storage-classes).

Untick preventing public access. Public access is the whole point of hosting a
website within this. Go with uniform access control.

Untick soft delete policy and keep object versioning and retention unticked.

Leave data encryption as defaults (this data is public).

Create the bucket.

### Push permissions from github
