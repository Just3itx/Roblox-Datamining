-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:31:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent
local join = require(AvatarExperienceCommonParent.Dash).join

local selectHasBodyTryOn = require(script.Parent.selectHasBodyTryOn)
local selectDefaultTryOnBodyColors = require(script.Parent.selectDefaultTryOnBodyColors)

local function selectAvatarPreviewColors(arg1)
    local outfitTryOn = arg1.AvatarExperience.AvatarScene.OutfitTryOn
    local avatarEditor = arg1.AvatarExperience.AvatarEditor
    local var1 = selectHasBodyTryOn(arg1)
    local bodyColor3s = avatarEditor.Character.BodyColor3s
    local var2 = if outfitTryOn.DefaultTryOnBodyColorsToggled then selectDefaultTryOnBodyColors(arg1) else outfitTryOn.BodyColor3s

    if var1 and bodyColor3s and var2 then
        return (join(bodyColor3s, var2))
    end

    return bodyColor3s
end

return selectAvatarPreviewColors
