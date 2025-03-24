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

The
[Google GitHub Actions Readme](https://github.com/google-github-actions/auth/blob/v2.1.8/README.md)
was helpful in figuring out the following steps. In particular within the
`#setup` there is an initially hidden section that can be unveiled by clicking
on the following text:

> Click here to show detailed instructions for configuring GitHub authentication
> to Google Cloud via a direct Workload Identity Federation.

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

This is the storage area we'll save our static assets to, and from which they'll
be publically shared.

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

### Create a Workload Identity Pool

This is the service account that the GitHub Action will be authenticated as.

[Documentation](https://cloud.google.com/iam/docs/manage-workload-identity-pools-providers)

[Page](https://console.cloud.google.com/iam-admin/workload-identity-pools/create)

These steps may be easier to follow using the `gcloud` command line tool as
[documented](https://github.com/google-github-actions/auth/blob/v2.1.8/README.md?plain=1#L362-L435).

#### Step 1

Use the name `github` and the description `GitHub Actions Pool`.

#### Step 2

Select an `OpenID Connect (OIDC)` provider. Enter `My GitHub repo Provider` as
the name, and then click edit. Change the provider id to be `my-repo`. Enter
`https://token.actions.githubusercontent.com` in the issuer id. Skip uploading a
JWK file. Leave the audience as default.

#### Step 3

Translate the following into the mapping

```
google.subject=assertion.sub,attribute.actor=assertion.actor,attribute.repository=assertion.repository,attribute.repository_owner=assertion.repository_owner
```

For attribute conditions, the following is fine but
[we can do better](https://github.com/google-github-actions/auth/blob/v2.1.8/docs/SECURITY_CONSIDERATIONS.md#use-githubs-numeric-immutable-values):

```
assertion.repository_owner == 'ccouzens' && (assertion.repository == 'ccouzens/bookish-funicular' || assertion.repository == 'ccouzens/cross-language-prop-types')
```

Get information
[about the repository through the API](https://api.github.com/repos/ccouzens/cross-language-prop-types).
From this we can improve the assertions:

```
assertion.repository_owner == 'ccouzens' && assertion.repository_owner_id == '241046' && ((assertion.repository == 'ccouzens/bookish-funicular' && assertion.repository_id == '882804906') || (assertion.repository == 'ccouzens/cross-language-prop-types' && assertion.repository_id == '925692583'))
```

#### Step 4

Run the following and take note of the output. So far as I can see this
information is not available through the web.

```bash
gcloud iam workload-identity-pools providers describe "my-repo" \
  --project="bookish-funicular" \
  --location="global" \
  --workload-identity-pool="github" \
  --format="value(name)"
```

For me, the output is

```
projects/153575345186/locations/global/workloadIdentityPools/github/providers/my-repo
```

This will be used within the GitHub Action YAML like so

```yaml
- uses: "google-github-actions/auth@v2"
  with:
    project_id: "bookish-funicular"
    workload_identity_provider: "projects/153575345186/locations/global/workloadIdentityPools/github/providers/my-repo"
```

### Push permissions from github
