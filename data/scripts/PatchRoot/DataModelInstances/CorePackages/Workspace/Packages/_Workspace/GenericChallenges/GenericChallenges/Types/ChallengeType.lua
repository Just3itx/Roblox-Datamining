-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
local GenericChallenges = script:FindFirstAncestor("GenericChallenges")
local GenericChallengesParent = GenericChallenges.Parent
local Utils = GenericChallenges.Utils
local addRawValueMethodToEnum = require(Utils.addRawValueMethodToEnum)

local tbl1 = {
    Captcha = "captcha",
    TwoStepVerification = "two-step-verification",
    SecurityQuestions = "security-questions",
    Reauthentication = "reauthentication",
    Generic = "generic"
}
local var1 = require(GenericChallengesParent.enumerate)(script.Name, tbl1)

addRawValueMethodToEnum(var1, tbl1)

return var1
