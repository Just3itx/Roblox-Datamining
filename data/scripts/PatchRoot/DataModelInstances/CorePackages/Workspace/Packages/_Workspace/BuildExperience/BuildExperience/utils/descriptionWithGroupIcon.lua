-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:11:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)

local escapeRichText = require(BuildExperience.utils.escapeRichText)

local IconName = Foundation.Enums.IconName
local iconRichText = Foundation.Utility.getIconRichText(IconName.TwoPeople)

local function descriptionWithGroupIcon(str1: string?, bool1: boolean?, str2: string?)
    if not bool1 then
        return str1
    end

    if not str1 then
        if str2 == nil then
            str1 = nil
        else
            str1 = escapeRichText(str2)
        end
    end

    if str1 ~= nil then
        return `{iconRichText} {str1}`
    end
    return iconRichText
end

return descriptionWithGroupIcon
