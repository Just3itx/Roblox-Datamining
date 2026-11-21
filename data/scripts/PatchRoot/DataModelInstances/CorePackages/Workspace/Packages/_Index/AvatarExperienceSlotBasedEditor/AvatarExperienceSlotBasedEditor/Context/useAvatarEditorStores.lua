-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:41:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSlotBasedEditorParent = script:FindFirstAncestor("AvatarExperienceSlotBasedEditor").Parent

local React = require(AvatarExperienceSlotBasedEditorParent.React)
local AvatarEditorStores = require(script.Parent.AvatarEditorStores)
local createAvatarEditorStores = require(script.Parent.Parent.Stores.createAvatarEditorStores)

local function useAvatarEditorStores()
    local var1 = React.useContext(AvatarEditorStores)
    if var1 then
        return var1
    end

    warn(
        "useAvatarEditorStores was used without an AvatarEditorStores context provider. Providing a temporary default value instead."
    )
    return createAvatarEditorStores()
end

return useAvatarEditorStores
