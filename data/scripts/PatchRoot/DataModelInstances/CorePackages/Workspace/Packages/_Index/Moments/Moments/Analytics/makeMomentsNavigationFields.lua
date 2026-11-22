-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:40:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")

local Constants = require(Moments.Constants)
local _NavigationDestinationType = require(Moments.Enums.NavigationDestinationType)

local function makeMomentsNavigationFields(tbl1)
    local tbl2 = {
        client_event_timestamp_ms = tbl1.clientEventTimestampMs,
        feedItemId = tbl1.feedItemId,
        viewId = tbl1.viewId,
        durationSeconds = tostring(tbl1.durationSeconds),
        destinationType = tbl1.destinationType
    }
    if tbl1.includeRecommendationDetail then
        tbl2.impressionType = tostring(1)
        tbl2.sourceSurface = Constants.SOURCE_SURFACE
        tbl2.itemPosition = tostring(tbl1.itemPosition)
        tbl2.tracingId = tbl1.tracingId or ""
    end
    return tbl2
end

return makeMomentsNavigationFields
