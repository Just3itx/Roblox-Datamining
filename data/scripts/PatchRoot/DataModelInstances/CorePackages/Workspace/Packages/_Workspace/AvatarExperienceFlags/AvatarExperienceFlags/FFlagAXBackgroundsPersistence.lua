-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T14:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagAXBackgroundsRoot = require(script.Parent.FFlagAXBackgroundsRoot)
local FFlagAXBackgroundsCustomizeHydration = require(script.Parent.FFlagAXBackgroundsCustomizeHydration)

local bool1 = game:DefineFastFlag("AXBackgroundsPersistence", false)

local success = pcall(function()
    local _avatarBackground = Enum.AvatarAssetType.AvatarBackground

    local _promptApplyProfileConfigurationCompleted = game:GetService("AvatarEditorService").PromptApplyProfileConfigurationCompleted
    assert(
        typeof(game:GetService("Players").GetProfileConfigurationFromUserIdAsync) == "function",
        "GetProfileConfigurationFromUserIdAsync is unavailable"
    )
end)

return FFlagAXBackgroundsRoot and FFlagAXBackgroundsCustomizeHydration and bool1 and success
