-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:30:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local _Signals = require(DataHydrationParent.Signals)

local GetFFlagEdpPlayerFeedbackEnabled = require(DataHydrationParent.SharedFlags).GetFFlagEdpPlayerFeedbackEnabled

local _UserVoteFeedbackMetadataStoreTypes = require(script.Parent.UserVoteFeedbackMetadataStoreTypes)

return {
    calculateDerivedField = function(str1: string, arg1, _)
        if str1 == "isHidden" then
            return not (GetFFlagEdpPlayerFeedbackEnabled() and arg1 and arg1.canSubmitReview)
        end

        return nil
    end
}
