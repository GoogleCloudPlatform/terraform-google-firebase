---
name: cft-metadata-services-expert
description: Specialized knowledge for populating the services block in metadata.yaml accurately without manual overrides, particularly mapping them via test/setup/main.tf to the CFT blueprint-compiler.
---

# CFT Metadata Services Guidelines

When contributing to Google Cloud Foundation Toolkit (CFT) repositories, it is essential to allow the CI pipeline (`make docker_generate_docs`) to natively compile `metadata.yaml` rather than editing it by hand.

## The Problem
When dealing with newer Google Cloud APIs (such as those for Firebase) or specific architectures, the automated `blueprint-compiler` included in `gcr.io/cloud-foundation-cicd/cft/developer-tools` might completely strip out the `services:` block from a submodule's `metadata.yaml`. This happens because the compiler parses the underlying `.tf` code to infer which services exist; if the module doesn't natively provision the APIs, or if the compiler hasn't updated its static mapping dictionary for the resources used within the submodule, it assumes no APIs are required and deletes any handwritten `services:` lists.

## The Standard Solution
**NEVER manually inject or patch `services:` or `roles:` into `metadata.display.yaml` or `metadata.yaml` directly.** Every time `make docker_generate_docs` is run natively, handwritten lines not tethered correctly to the configuration will be destroyed.

To perfectly ensure that submodules retain their accurate API requirements during documentation generation, you must map them natively via the `per_module_services` configuration:

1. **Enable the Auto-Compiler**: Ensure the `Makefile` command uses the `--per-module-requirements` flag:
   ```bash
   generate_docs --per-module-requirements
   ```
2. **Inject the Map**: The `blueprint-compiler` statically reads `test/setup/main.tf` specifically looking for a global map called `per_module_services`. By defining the matrix properly within the setup file, the compiler will precisely route the array of APIs to each submodule's `metadata.yaml`:

   *Example from `test/setup/main.tf`:*
   ```hcl
   locals {
     per_module_services = {
       firebase_ai_logic_core = [
         "firebase.googleapis.com",
         "serviceusage.googleapis.com"
       ]
       firebase_app_hosting = [
         "firebaseapphosting.googleapis.com"
       ]
     }
   }
   ```
3. **Execute Documentation Generation**: Once the map is accurate, run:
   ```bash
   export ENABLE_BPMETADATA=1
   make docker_generate_docs
   ```
   The generator will autonomously recreate the submodules' `metadata.yaml`, successfully retaining and populating the `services:` block!
