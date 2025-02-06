### **1. Creating an Azure VNet Using the Azure Portal (GUI)**

1. **Log in to the Azure Portal:**
   - Go to [Azure Portal](https://portal.azure.com) and log in with your credentials.

2. **Navigate to Virtual Networks:**
   - In the left-hand sidebar, select **"Create a resource"**.
   - In the "Search the Marketplace" box, type **"Virtual Network"** and select **"Virtual Network"** from the list.
   - Click **"Create"** to start the process.

3. **Fill in VNet Configuration Details:**
   - **Subscription:** Select the subscription where the VNet will be created.
   - **Resource Group:** Either create a new resource group or select an existing one.
   - **Name:** Give your VNet a name.
   - **Region:** Select the Azure region where your VNet will be created (e.g., East US, West Europe).
   - **Address Space:** Specify the IP address range for your VNet (e.g., `10.0.0.0/16`). This will be the overall range that your subnets will use.

4. **Configure Subnets:**
   - Under the **Subnets** tab, click **"+ Add Subnet"**.
   - Define the subnet name (e.g., `Subnet1`) and provide an address range for this subnet (e.g., `10.0.1.0/24`).
   - You can add more subnets later if needed.

5. **Security & Management Options (Optional):**
   - You can configure **DDoS Protection**, **Firewall policies**, and **Peering** at this stage, but these are optional and can be configured later.

6. **Review & Create:**
   - Click **Review + Create** to verify the settings you’ve entered.
   - Once everything looks good, click **Create** to deploy the VNet.

---

### **2. Creating an Azure VNet Using Azure CLI Commands**

Before using the Azure CLI, make sure you have the **Azure CLI** installed and you're logged in. If you don't have it installed, follow the instructions here: [Install Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli).

#### **Step-by-Step Azure CLI Commands:**

1. **Log in to Azure:**
   Open your terminal and log in to your Azure account using the following command:
   ```bash
   az login
   ```

2. **Create a Resource Group (if not already created):**
   You’ll need a resource group to place your VNet in. Create a new resource group with the following command:
   ```bash
   az group create --name MyResourceGroup --location eastus
   ```
   Replace `MyResourceGroup` with your preferred resource group name, and `eastus` with your desired region.

3. **Create the Virtual Network:**
   Use the following command to create the VNet:
   ```bash
   az network vnet create \
     --resource-group MyResourceGroup \
     --name MyVNet \
     --address-prefix 10.0.0.0/16 \
     --location eastus
   ```
   - Replace `MyResourceGroup` with the name of your resource group.
   - `MyVNet` is the name you want for your VNet.
   - `10.0.0.0/16` is the address space for your VNet, which you can modify as per your requirements.
   - `eastus` is the region where you want to deploy the VNet.

4. **Create a Subnet within the VNet:**
   After the VNet is created, you need to create a subnet. Use the following command:
   ```bash
   az network vnet subnet create \
     --resource-group MyResourceGroup \
     --vnet-name MyVNet \
     --name MySubnet \
     --address-prefix 10.0.1.0/24
   ```
   - `MySubnet` is the name of the subnet you're creating.
   - `10.0.1.0/24` is the address space for the subnet. You can change this depending on your IP range.

5. **Verify the VNet Creation:**
   To verify the VNet was created successfully, use:
   ```bash
   az network vnet show --resource-group MyResourceGroup --name MyVNet
   ```

---

### **Summary:**

#### **Azure Portal (GUI) Steps:**
- Go to the **Azure Portal** → Create a resource → **Virtual Network** → Enter details (Subscription, Resource Group, Name, Region, Address space) → Add subnets → Review and create.

#### **Azure CLI Steps:**
1. `az login`
2. `az group create --name MyResourceGroup --location eastus`
3. `az network vnet create --resource-group MyResourceGroup --name MyVNet --address-prefix 10.0.0.0/16 --location eastus`
4. `az network vnet subnet create --resource-group MyResourceGroup --vnet-name MyVNet --name MySubnet --address-prefix 10.0.1.0/24`
5. `az network vnet show --resource-group MyResourceGroup --output table`
6. `az network vnet list --resource-group MyResourceGroup --query "[?name=='<VNET Name>']" --output table`


Explanation of Correct Usage:
az network vnet list: Lists all virtual networks.
--resource-group <ResourceGroupName>: Filters the VNets by a specific resource group.
--query: This allows you to filter results based on specific attributes, like the name of the VNet.
For More Information:
