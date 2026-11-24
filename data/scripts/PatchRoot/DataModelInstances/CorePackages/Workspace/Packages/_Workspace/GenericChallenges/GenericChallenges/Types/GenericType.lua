-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:40:51Z
-- Luau bytecode version: 14 | Luau type version: 3
local GenericChallenges = script:FindFirstAncestor("GenericChallenges")
local GenericChallengesParent = GenericChallenges.Parent
local Utils = GenericChallenges.Utils
local addRawValueMethodToEnum = require(Utils.addRawValueMethodToEnum)

local tbl1 = {
    Captcha = "captcha",
    TwoStepVerification = "twostepverification",
    SecurityQuestions = "securityquestions",
    Reauthentication = "reauthentication",
    ProofOfWork = "proofofwork",
    ForceAuthenticator = "forceauthenticator",
    ForceTwoStepVerification = "forcetwostepverification",
    DeviceIntegrity = "deviceintegrity",
    DeviceAccessToken = "deviceaccesstoken",
    Denied = "denied",
    EmailVerification = "emailverification",
    PhoneVerification = "phoneverification",
    PrivateAccessToken = "privateaccesstoken",
    BlockSession = "blocksession",
    CaptchaV2 = "captchav2",
    Turnstile = "turnstile",
    RoCaptcha = "rocaptcha"
}
local var1 = require(GenericChallengesParent.enumerate)(script.Name, tbl1)

addRawValueMethodToEnum(var1, tbl1)

return var1
