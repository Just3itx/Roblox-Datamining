-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T12:01:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilities = script:FindFirstAncestor("SduiSharedUtilities")
local _SduiIntegrationTypes = require(SduiSharedUtilities.SduiIntegrationTypes)

local function streamingFeedMergeStrategy(tbl1, _, _): string?
    return if #tbl1 == 1 and (tbl1[1] == "entry_map" or tbl1[1] == "entry_order") then "merge" else nil
end

return streamingFeedMergeStrategy
