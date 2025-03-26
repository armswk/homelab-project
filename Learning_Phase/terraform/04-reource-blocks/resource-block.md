# Resouce Blocks
## Resources are used to configure real-word infrastructure objects

- They are used to manage any infrastructure that we want to manage with Terraform, and are the most important blocks within terraform
- Resource blocks represent things like virtual networks, compute instances, DNS records, storage disks, etc;
- The arguments depend on and vary based on the resource type
- The combination of resource type and resource name must be unique within a modile. This is how Terraform links the resource to its respective real-world object
- If no other provider is specified, terraform will use the default provider to provision the infrastructure. We can use the 'provider' meta-argument to explicitly pass a pass a different provider
- Terraform offers a few local-only resources, such as generating random strings or IDs, private key, or self-issued TLS certificates
- We can create multiple instances of resources by using Terrform loops (`for_each`,`count`)