-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:41:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local function registerInExperienceComponents()
    require(CorePackages.Workspace.Packages.SduiSharedContent).registerSharedUiComponents()
    require(CorePackages.Workspace.Packages.SduiFoundation).registerFoundationComponents()
    require(CorePackages.Workspace.Packages.ServerDrivenUi).registerDiscoveryUiComponents()
end

return registerInExperienceComponents
