-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:21:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSaveParent = script:FindFirstAncestor("AvatarExperienceSave").Parent

local React = require(AvatarExperienceSaveParent.React)
local AvatarSaveContext = require(script.Parent.AvatarSaveContext)

local function useAvatarSaveContext()
    local var1 = React.useContext(AvatarSaveContext)
    assert(
        var1,
        "useAvatarSaveContext returned nil, usually this means the AvatarSaveContextProvider is not present in the tree"
    )

    return var1
end

return useAvatarSaveContext
