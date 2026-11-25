-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:10:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEventsParent = script:FindFirstAncestor("VirtualEvents").Parent

local AppPage = require(VirtualEventsParent.RobloxAppEnums).AppPage

local function getEventDetailsPageKey(str1: string?)
    if str1 == nil then
        return AppPage.EventDetails .. "-Unknown"
    end

    return AppPage.EventDetails .. "-" .. str1
end

return getEventDetailsPageKey
