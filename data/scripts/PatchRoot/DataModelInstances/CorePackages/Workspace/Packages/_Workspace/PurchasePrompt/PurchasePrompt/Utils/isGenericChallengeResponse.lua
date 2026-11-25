-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:00:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local GetFFlagEnablePerformPurchaseGCSHandling = require(scriptParentParent.Flags.GetFFlagEnablePerformPurchaseGCSHandling)

function isGenericChallengeResponse(arg1)
    if type(arg1) ~= "string" then
        return false
    end

    local fFlagEnablePerformPurchaseGcsHandling = GetFFlagEnablePerformPurchaseGCSHandling()
    return fFlagEnablePerformPurchaseGcsHandling
        and arg1:match("rblx%-challenge%-response") ~= nil
        and arg1:match("rblx%-challenge%-id") ~= nil
        and arg1:match("rblx%-challenge%-metadata") ~= nil
        and arg1:match("rblx%-challenge%-type") ~= nil
end

return isGenericChallengeResponse
