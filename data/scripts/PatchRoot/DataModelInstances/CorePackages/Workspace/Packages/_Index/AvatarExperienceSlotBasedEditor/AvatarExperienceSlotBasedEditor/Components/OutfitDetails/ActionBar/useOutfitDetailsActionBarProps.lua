-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSlotBasedEditorParent = script:FindFirstAncestor("AvatarExperienceSlotBasedEditor").Parent

local React = require(AvatarExperienceSlotBasedEditorParent.React)
local useLocalization = require(AvatarExperienceSlotBasedEditorParent.Localization).Hooks.useLocalization
local useNavigation = require(AvatarExperienceSlotBasedEditorParent.Navigation).useNavigation

local _OutfitDetailsActionBar = require(script.Parent.OutfitDetailsActionBar)
local AvatarScreen = require(AvatarExperienceSlotBasedEditorParent.AvatarExperienceNavigation).Enums.AvatarScreen

local function useOutfitDetailsActionBarProps(tbl1)
    local var1 = useNavigation()
    local outfitId = tbl1.outfitId

    local var2 = useLocalization({ rename = "Feature.Avatar.Action.Rename", delete = "Feature.Avatar.Action.Delete" })

    local onRenameOutfit = React.useCallback(function()
        var1.navigate(AvatarScreen.RenameOutfitDialog, { outfitId = outfitId })
    end, { var1, outfitId })

    local onDeleteOutfit = React.useCallback(function()
        var1.navigate(AvatarScreen.DeleteOutfitDialog, { outfitIds = { outfitId } })
    end, { var1, outfitId })

    return {
        renameText = var2.rename,
        deleteText = var2.delete,
        onRenameOutfit = onRenameOutfit,
        onDeleteOutfit = onDeleteOutfit,
        LayoutOrder = tbl1.LayoutOrder
    }
end

return useOutfitDetailsActionBarProps
