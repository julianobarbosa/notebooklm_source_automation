# Plan: Deduplicate Sources in NotebookLM Notebook

## Context
Notebook **"AKS :: nap :: docs"** (`f3340ff7-fe71-424d-ba8d-5baf86a75fb0`) has 73 sources, many of which are duplicates (same URL added multiple times). We need to keep one copy of each and delete the rest, plus remove 1 failed source.

## Strategy
- For each duplicate group: **keep the newest source** (latest timestamp), delete the rest
- Delete the 1 failed Medium source (`bdc09d59`)
- Use `source_delete` with `confirm=True` for each deletion
- Process deletions in batches (tool supports one at a time)

## Duplicate Groups & Deletion Plan

**Keep = newest copy. Delete = all others.**

| # | URL (shortened) | Keep | Delete |
|---|---|---|---|
| 1 | stormforge.io/aks-karpenter/ | `8079e54e` | `5e646f30`, `ff583b3b` |
| 2 | florinloghiade.ro/aks-node-auto-provisioning | `d23e24fa` | `c2caba6e` |
| 3 | blog.srinman.com/aks-scaling/ | `3f898425` | `f2874453` |
| 4 | oneuptime.com/aks-node-auto-provisioning-with-nap | `89bdfae4` | `a95ab972`, `f1e6d65e` |
| 5 | learn.microsoft.com/node-auto-provisioning | `3c7329d7` | `9f022cc1`, `c12340f4`, `a3364a33` |
| 6 | learn.microsoft.com/node-auto-provisioning-aksnodeclass | `c29c83fc` | `a56abe38`, `fa7e3d31` |
| 7 | learn.microsoft.com/use-node-auto-provisioning | `4406355a` | `a897977c` |
| 8 | learn.microsoft.com/node-auto-provisioning-upgrade-image | `8b95ab26` | `3159c146` |
| 9 | docs.azure.cn/reliability-availability-zones-configure | `56d40359` | `794f2c69` |
| 10 | learn.microsoft.com/managedclusters template | `990484c4` | `d03a7d01` |
| 11 | docs.azure.cn/upgrade-options | `d781aa63` | `ba86f2bf` |
| 12 | learn.microsoft.com/security-bulletins/overview | `b90bf45d` | `9cda07bb` |
| 13 | github.com/Azure/AKS/releases | `b39cea6b` | `7d285e78` |
| 14 | github.com/Azure/karpenter-provider-azure | `94800d0a` | `46dc21a1` |
| 15 | github.com/azure/aks/issues/5345 | `362019d0` | `260f6f9d` |
| 16 | github.com/Azure/AKS/issues/5586 | `ba25db02` | `90bf45a9` |
| 17 | newreleases.io/Azure/AKS/2025-03-16 | `9596a9ef` | `7cf89164` |
| 18 | registry.terraform.io/avm-res-containerservice | `b8af95d2` | `2fa8c93d` |
| 19 | researchgate.net/Automated_Cloud_Service | `e5801108` | `a1dd0b66` |
| 20 | MicrosoftDocs/.../node-auto-provisioning-aksnodeclass.md | `02263472` | `8bf56476` |
| 21 | MicrosoftDocs/.../node-auto-provisioning-node-pools.md | `94b36973` | `aa952b4c` |
| 22 | scaleops.com/karpenter-vs-cluster-autoscaler/ | `f51099e5` | `839b1221` |
| 23 | blog.aks.azure.com/node-auto-provisioning-capacity | `5b1ea73f` | `dac64b42` |
| 24 | "Strategic Evolution..." (pasted text) | `8fc56b80` | `e3093d8c` |
| 25 | medium.com/@doronrogov (FAILED) | — | `bdc09d59` |

## Summary
- **Total deletions: 28 sources**
- **Sources remaining after cleanup: 45**

## Execution
1. Call `source_delete(source_id=<id>, confirm=True)` for each of the 28 source IDs listed in the "Delete" column
2. Run in parallel where possible (multiple tool calls per message)
3. After all deletions, call `notebook_get` to verify final source count is ~45

## Verification
- `notebook_get(f3340ff7-fe71-424d-ba8d-5baf86a75fb0)` — confirm ~45 unique sources remain
- Spot-check that no URL appears more than once
