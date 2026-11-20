-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local isNewInGameMenuEnabled = require(RobloxGui.Modules.isNewInGameMenuEnabled)
local ChromeEnabled = require(CorePackages.Workspace.Packages.Chrome).Enabled

return function()
    return ChromeEnabled() and not isNewInGameMenuEnabled()
end
