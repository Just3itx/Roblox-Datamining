-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:40:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local UIBlox = require(CorePackages.Packages.UIBlox)
local Tokens = UIBlox.App.Style.Tokens
local Constants = UIBlox.App.Style.Constants
local DeviceType = Constants.DeviceType
local TenFootInterface = require(RobloxGui.Modules.TenFootInterface)

return function(arg1, arg2)
    local var1 = if TenFootInterface:IsEnabled() then DeviceType.Console else arg1 or DeviceType.DefaultDeviceType
    return Tokens.getFoundationTokens(var1, arg2 or Constants.DefaultThemeName)
end
