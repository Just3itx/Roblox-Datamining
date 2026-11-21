-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:21:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSaveParent = script:FindFirstAncestor("AvatarExperienceSave").Parent

local React = require(AvatarExperienceSaveParent.React)

local AvatarSaveContext = require(script.Parent.AvatarSaveContext)
local useAvatarSaveContextProviderValue = require(script.Parent.useAvatarSaveContextProviderValue)

local function AvatarSaveContextProvider(tbl1)
    local value = useAvatarSaveContextProviderValue()
    return React.createElement(AvatarSaveContext.Provider, { value = value }, tbl1.children)
end

return AvatarSaveContextProvider
