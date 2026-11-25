-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:00:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local _GraphQLServer = require(VirtualEvents.Parent.GraphQLServer)

local function getEventCategory(arg1)
    local eventCategories = arg1.eventCategories
    if eventCategories == nil or #eventCategories == 0 then
        return nil
    end

    for _, value in ipairs(eventCategories) do
        if value ~= nil and value.rank == 0 then
            return value.category
        end
    end

    return nil
end

return getEventCategory
