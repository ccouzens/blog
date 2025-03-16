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
GitHub Pages I can only have one website repo across all my repos.

Why Not Infrastructure as Code like
[Terraform](https://www.terraform.io/)/[OpenTofu](https://opentofu.org/)? I find
it difficult to understand the options available to me without having first
configured services manually. I still consider myself at the exploring and
learning phase of Google Cloud Storage. I do not (currently) have an
infrastructure as code setup, in which I'd configure this.
