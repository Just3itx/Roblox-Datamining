-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarWorkshopParent = script:FindFirstAncestor("AvatarWorkshop").Parent

local var1 = require(AvatarWorkshopParent.InExperienceLocales).Localization.new("en-us")

local function getEnglishString(str1: string)
    return var1:Format(str1)
end

return getEnglishString
