-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:41:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")

local _CreationFlowTypes = require(MomentsCreation.Types.CreationFlowTypes)
local FFlagMomentsTTSTooManyDigitsError = require(MomentsCreation.Flags.FFlagMomentsTTSTooManyDigitsError)

local tbl1 = {
    FilteredText = "moderated",
    FilteredAudio = "moderated",
    NotEnoughQuota = "quotaExceeded",
    ["Rate limited by the client"] = "quotaExceeded",
    Timeout = "timeout"
}

local function classifyTTSError(str1: string?)
    if str1 == nil then
        return "failure"
    end

    if FFlagMomentsTTSTooManyDigitsError and str1 == "TooManyDigits" then
        return "tooManyDigits"
    end

    return tbl1[str1] or "failure"
end

return classifyTTSError
