-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:20:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UnifiedLogging = script:FindFirstAncestor("UnifiedLogging")
local UnifiedLoggingParent = UnifiedLogging.Parent

local gameEntryUtils = require(UnifiedLogging.gameEntryUtils)

local flaggedMutedError = require(UnifiedLoggingParent.Loggers).flaggedMutedError

return function(arg1, arg2, arg3)
    local tbl1 = {}
    local tbl2 = {}

    for _, value in arg1 do
        local var1 = arg2[value]

        if var1 ~= nil then
            local var2 = gameEntryUtils.extractFieldsFromGameEntry(var1)

            table.insert(tbl1, var2.universeId or "")
            table.insert(tbl2, var2.placeId or "")
        else
            flaggedMutedError(
                "BuildGameMetadataFields",
                `Entry at index {value} was nil when building game metadata fields for collection {arg3}`
            )
        end
    end

    return {
        universeId_arr = table.concat(tbl1, ","),
        placeId_arr = table.concat(tbl2, ",")
    }
end
