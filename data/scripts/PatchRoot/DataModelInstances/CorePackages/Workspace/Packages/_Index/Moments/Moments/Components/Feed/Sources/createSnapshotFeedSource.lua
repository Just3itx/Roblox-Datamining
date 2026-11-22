-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:30:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")

local _FeedTypes = require(Moments.Components.Feed.FeedTypes)

local function createSnapshotFeedSource(tbl1, tbl2)
    local tbl3 = tbl2 or {}

    local var1 = table.clone(tbl1)

    return {
        fetchAsync = function(_)
            return {
                items = table.clone(var1),
                nextCursor = nil
            }
        end,
        id = tbl3.id or "snapshot",
        recommendationSource = tbl3.recommendationSource
    }
end

return createSnapshotFeedSource
