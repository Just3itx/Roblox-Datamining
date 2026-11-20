-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:40:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {
    UserAgreement = true,
    AgreementConsents = true,
    PinEntry = true,
    VerificationMethodSelection = true,
    OdpAgeEstimation = true,
    OdpGovernmentId = true,
    SessionPolling = true,
    Redirect = true
}

local tbl2 = { NeedToReverify = true, ReverificationNotice = true }

local function isParentModeThemedNode(str1: string, str2: string?): boolean
    return if tbl1[str1] then true else str1 == "TextScreen" and str2 ~= nil and tbl2[str2] == true
end

return isParentModeThemedNode
