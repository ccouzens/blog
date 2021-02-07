# Project ideas

I have been reading through the documentation of Kubernetes, and it has given me
a few project ideas. The ideas aren't yet fleshed out and more than likely won't
come to much.

1. **My own dashboard GUI for Kubernetes**. This would likely only support a
   fraction of the features of the real ones.

   1. Viewing namespaces
   2. Viewing pods
   3. Viewing logs

   It would teach me

   1. The Kubernetes API (even if done through a library)
   2. If written in Rust, experience wih a Rust web server library
   3. A mulitpage webapp for me to practice CSS on

   I see this as being my own To-Do app; a web application that is simple enough
   that it can be reimplemented in other technologies to learn them and evaluate
   them.

2. **OpenAPI based sidecar metric collector**. I would be surprised if this
   doesn't already exist, but I couldn't find anything in my quick Google
   search. This would be an application that sits between the network and a
   web-server, and produce Prometheus compatible metric information about
   requests to the server and responses from the server.

   It would take in an OpenAPI file and look at the `paths` section. For every
   incoming request, it would determine the `operation` that is being requested
   (or unmatched if it doesn't match). For every `operation` it would produce
   metrics that could tell us

   - the response codes that come back
   - the errors that come back (if the server times out or otherwise produces an
     HTTP incompatible response)
   - if the optional parameters are used
   - the response times as a histogram

3. **A better Kubernetes log reader**. I don't like that when getting the logs
   for the pods within a deployment on Kubernetes, I first need to identify the
   pods within the deployment.

   As part of writing this, I checked the man page (`man kubectl logs`) to
   confirm there wasn't an option that solves this. **It is a solved problem!**
   There are a couple options to solve it. Examples from the manual:

   ```
   # Return snapshot logs from all containers in pods defined by label app=nginx
   kubectl logs -lapp=nginx --all-containers=true
   ```

   ```
   # Return snapshot logs from container nginx-1 of a deployment named nginx
   kubectl logs deployment/nginx -c nginx-1
   ```

   Possibly the second returns the logs of the deployment pod, rather than the
   logs of the pods in the deployment. I haven't checked.
