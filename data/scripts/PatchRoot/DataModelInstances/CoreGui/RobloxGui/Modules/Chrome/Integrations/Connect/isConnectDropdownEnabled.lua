-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:50:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")

local CorePackages = game:GetService("CorePackages")

local GetFFlagEnableAppChatInExperience = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagEnableAppChatInExperience
local GetShouldShowPlatformChatBasedOnPolicy = require(Chrome.Flags.GetShouldShowPlatformChatBasedOnPolicy)

return function()
    return GetFFlagEnableAppChatInExperience() and GetShouldShowPlatformChatBasedOnPolicy()
end
