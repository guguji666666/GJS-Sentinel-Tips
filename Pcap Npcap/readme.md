# Pcap and Npcap

# 监控 PCAP 或 NPCAP 组件变更的详细步骤

---

## **1. 启用文件系统审核**

### **步骤 1：确定安装路径**
- 对于 **WinPcap**，默认路径：
  - `C:\Program Files (x86)\WinPcap\`
- 对于 **Npcap**，默认路径：
  - `C:\Program Files\Npcap\`

### **步骤 2：启用目录的审核**
1. 找到 PCAP 或 NPCAP 的安装目录。
2. 右键单击目录，选择 **属性**。
3. 转到 **安全** 标签并点击 **高级**。
4. 切换到 **审核** 标签，然后点击 **添加**。
5. 在 "主体" 字段中输入 `Everyone`（或特定的用户/组）。
6. 勾选 **成功** 和 **失败**，启用以下权限的日志记录：
   - 修改 (Modify)
   - 写入 (Write)
   - 删除 (Delete)
7. 点击 **确定** 以保存审核设置。

### **步骤 3：查看审核日志**
1. 打开 **事件查看器**（按下 `Win + R`，输入 `eventvwr`，按下回车）。
2. 导航到 **Windows 日志 > 安全**。
3. 查找 **事件 ID 4663**：
   - 表示对文件或目录的访问尝试。

---

## **2. 监控注册表变更**

### **步骤 1：定位相关注册表键**
- 对于 **Npcap**，找到：
  - `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\npf`
- 对于 **WinPcap**，找到：
  - `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinPcap`

### **步骤 2：启用注册表审核**
1. 打开注册表编辑器（按下 `Win + R`，输入 `regedit`，按下回车）。
2. 导航到相关注册表键。
3. 右键单击键，选择 **权限**。
4. 点击 **高级**，然后转到 **审核** 标签。
5. 点击 **添加**：
   - 输入 `Everyone`（或特定的用户/组）。
   - 启用以下权限的日志记录：
     - **设置值 (Set Value)**
     - **创建子键 (Create Subkey)**
     - **删除子键 (Delete Subkey)**
6. 保存设置。

### **步骤 3：查看注册表审核日志**
1. 打开 **事件查看器**。
2. 导航到 **Windows 日志 > 安全**。
3. 查找 **事件 ID 4657**：
   - 表示对注册表键或值的修改。

---

## **3. 使用实时监控工具**

### **Sysmon (系统监控)**
1. **下载 Sysmon**：
   - 从 [微软 Sysinternals 网站](https://learn.microsoft.com/en-us/sysinternals/)下载 Sysmon。
2. **安装 Sysmon**：
   - 运行 `sysmon -accepteula -i` 以安装 Sysmon 并使用默认配置。
3. **创建配置文件**：
   - 使用配置文件定义规则，监控与 PCAP/NPCAP 相关的目录和注册表键。
4. **示例规则**：
   ```xml
   <EventFiltering>
       <FileCreateTime onmatch="include">
           <TargetFilename condition="contains">WinPcap</TargetFilename>
           <TargetFilename condition="contains">Npcap</TargetFilename>
       </FileCreateTime>
       <RegistryEvent onmatch="include">
           <TargetObject condition="contains">\Services\npf</TargetObject>
           <TargetObject condition="contains">\Services\WinPcap</TargetObject>
       </RegistryEvent>
   </EventFiltering>
