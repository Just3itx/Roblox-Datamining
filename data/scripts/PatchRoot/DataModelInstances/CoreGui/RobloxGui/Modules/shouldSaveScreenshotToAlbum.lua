-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:41:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local CorePackages = game:GetService("CorePackages")

local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local CachedPolicyService = require(CorePackages.Workspace.Packages.CachedPolicyService)
local GetFFlagScreenshotHudApi = require(RobloxGui.Modules.Flags.GetFFlagScreenshotHudApi)

return function(): boolean
    local platform = UserInputService:GetPlatform()
    local bool1 = platform == Enum.Platform.IOS or platform == Enum.Platform.Android

    return not not (GetFFlagScreenshotHudApi() and bool1 and not CachedPolicyService:IsSubjectToChinaPolicies())
end
