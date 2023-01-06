# Introduction

There is increased demand from customers to enable a centralized offering with flexibility, automation and visibility. The Centralize offering is built by following IT best practice and VolvoCars IT security directive principal, and with required operational support in place. The aim is to help the Application team to focus on business needs, instead of focusing on infrastructure setup.

## Audience

- Managed-Service Provider
- Application Team (subscription owner)

## Offerings
The list of Managed Service-Offerings are documented in [link](/docs/List-of-ServiceOffering.md)

# Vision

## AMA + RG Lock +Guardrails

- Service provider gets Managed RG with proper access and Deny Access for others.
- Both `Service Principal` and `Security Group` can be given access on Managed-RG.
- Definition RG can be protected using RG Lock and Lock Guardrails.
- Fake resource needs to deployed. Resources which cost minimal charge can be deployed like User-assigned Managed Identity etc.<br/>
`We can also deploy dedicated Vnet for the Service provider which can be later used.`

### Tested Scenarios

- Scenario 1: AKS deployment in Managed RG.

  &emsp;1. Deployment role on the subscription is required since AKS deploys a default resource group in the subscription.<br/>
  &emsp;2. AKS Identity needs to have Subnet-Join role on customer Network RG or else rbac role on the subcription level.<br/>
  &emsp;&emsp;a. AKS Identity needs to have subnet join role on the network RG.<br/>
  &emsp;&emsp;&emsp;`Microsoft.Network/virtualNetworks/subnets/join/action`,<br/>
  &emsp;&emsp;&emsp;`Microsoft.Network/virtualNetworks/subnets/read`.<br/>
  &emsp;&emsp;b. Else Identity used for deployment needs to have access to perform RBAC.<br/>
  &emsp;&emsp;&emsp;`Microsoft.Authorization/roleAssignments/write`.<br/>

- Scenario 2: VM and SQL Server deployment in Managed RG.<br/>
  &emsp;1. Virtual Network:<br/>
  &emsp;&emsp;a. They can use existing Vnet but subnet join access is required for this.<br/>
  &emsp;&emsp;&emsp;`Microsoft.Network/virtualNetworks/subnets/join/action`,<br/>
  &emsp;&emsp;&emsp;`Microsoft.Network/virtualNetworks/subnets/read`.<br/>
  &emsp;&emsp;b. They can have their dedicated Vnet (peered with customer Vnet). This is more preferrable option since they don't need access on customer resources here.<br/>
  &emsp;2. VM and SQL Server is accessible and working as expected when deployed inside the Managed-RG with dedicated Vnet.
