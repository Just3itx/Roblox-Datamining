-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:51:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local _MomentsTypes = require(DataHydrationParent.MomentsTypes)

local function convertApiMomentComments(arg1): {count: number, countIsCapped: number, creatorEnabled: number, viewerCanRead: number, viewerCanWrite: number}?
    if type(arg1) ~= "table" then
        return nil
    end

    if type(arg1.creatorEnabled) ~= "boolean"
        or type(arg1.viewerCanRead) ~= "boolean"
        or type(arg1.viewerCanWrite) ~= "boolean"
    then
        return nil
    end

    return {
        count = if type(arg1.count) == "number" then arg1.count else nil,
        countIsCapped = if type(arg1.countIsCapped) == "boolean" then arg1.countIsCapped else nil,
        creatorEnabled = arg1.creatorEnabled,
        viewerCanRead = arg1.viewerCanRead,
        viewerCanWrite = arg1.viewerCanWrite
    }
end

return convertApiMomentComments
