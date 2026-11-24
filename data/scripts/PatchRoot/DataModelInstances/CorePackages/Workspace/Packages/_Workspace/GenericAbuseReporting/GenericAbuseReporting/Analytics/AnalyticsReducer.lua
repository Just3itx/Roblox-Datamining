-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:21:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent
local Rodux = require(GenericAbuseReportingParent.Rodux)
local Dictionary = require(GenericAbuseReportingParent.Cryo).Dictionary

local var1 = require(GenericAbuseReporting.Logger):new("AbuseReport Analytics")

local OnFormCommentUpdated = require(GenericAbuseReporting.Analytics.Actions.OnFormCommentUpdated)
local OnFormReasonSelected = require(GenericAbuseReporting.Analytics.Actions.OnFormReasonSelected)
local OnFormLoaded = require(GenericAbuseReporting.Analytics.Actions.OnFormLoaded)

local createReducer = Rodux.createReducer

local tbl1 = {}
tbl1[OnFormLoaded.name] = function(tbl2, arg1)
    var1:trace("OnFormLoaded")
    return Dictionary.union(
        tbl2,
        {
            context = arg1.context,
            place_id = arg1.place_id,
            accumulated_time_ms = arg1.accumulated_time_ms
        }
    )
end

tbl1[OnFormReasonSelected.name] = function(tbl2, arg1)
    var1:trace("OnFormReasonSelected - reason_selection: {}", arg1.reason_selection)
    return Dictionary.union(tbl2, { reason_selection = arg1.reason_selection, reason_change_count = tbl2.reason_change_count + 1 })
end

tbl1[OnFormCommentUpdated.name] = function(tbl2, arg1)
    var1:trace("OnFormCommentUpdated - comment_added: {}", arg1.comment_added)
    return Dictionary.union(tbl2, { comment_added = arg1.comment_added })
end

return {
    reducer = createReducer({}, tbl1),
    initialState = {
        interaction_type = 0,
        context = "Unknown",
        event_type = "GenericAbuseReportWithReasonAndComment",
        place_id = 0,
        accumulated_time_ms = 0,
        reason_selection = "",
        reason_change_count = 0,
        comment_added = false
    }
}
