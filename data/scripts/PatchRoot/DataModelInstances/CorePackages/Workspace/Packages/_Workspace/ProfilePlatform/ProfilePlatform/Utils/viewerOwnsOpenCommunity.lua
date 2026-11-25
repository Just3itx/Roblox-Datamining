-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:11:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")

local Enums = require(ProfilePlatform.Common.Enums)

local function viewerOwnsOpenCommunity(tbl1, str1: string): boolean
    local components = tbl1.components
    if components == nil then
        return false
    end

    local component = components[Enums.Components.CommunityProfileHeader]
    local ownerUserId = if type(component) == "table" then component.ownerUserId else nil

    if type(ownerUserId) ~= "number" or tostring(ownerUserId) ~= str1 then
        return false
    end

    return components[Enums.Components.CommunityLocked] == nil and components[Enums.Components.CommunityDeactivated] == nil
end

return viewerOwnsOpenCommunity
