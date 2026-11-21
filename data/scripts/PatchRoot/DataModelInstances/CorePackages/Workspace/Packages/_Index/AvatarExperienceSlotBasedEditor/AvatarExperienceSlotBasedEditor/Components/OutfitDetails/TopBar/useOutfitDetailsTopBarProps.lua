-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:40:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSlotBasedEditorParent = script:FindFirstAncestor("AvatarExperienceSlotBasedEditor").Parent

local useStatusBarHeight = require(AvatarExperienceSlotBasedEditorParent.RobloxAppHooks).useStatusBarHeight

local _OutfitDetailsTopBar = require(script.Parent.OutfitDetailsTopBar)

local function useOutfitDetailsTopBarProps(tbl1)
    return {
        statusBarHeight = useStatusBarHeight(),
        LayoutOrder = tbl1.LayoutOrder,
        onClose = tbl1.onClose
    }
end

return useOutfitDetailsTopBarProps
