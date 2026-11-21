-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:51:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetailParent = script:FindFirstAncestor("GameDetail").Parent

local AppPage = require(GameDetailParent.RobloxAppEnums).AppPage

local function getExperienceDetailsPageKey(str1: string?)
    if str1 == nil then
        return AppPage.ExperienceDetail .. "-Unknown"
    end

    return AppPage.ExperienceDetail .. "-" .. str1
end

return getExperienceDetailsPageKey
