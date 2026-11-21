-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:50:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")

local TwoStepErrorCodes = require(AuthCommon.Enums.TwoStepErrorCodes)

local function getTwoStepLoginErrorKey(illegalChildAccountLinking: number?): string
    return if illegalChildAccountLinking == TwoStepErrorCodes.IllegalChildAccountLinking then "Authentication.Login.LinkIllegalChildAccountLinking" else "Authentication.Login.Response.SomethingWentWrong"
end

return getTwoStepLoginErrorKey
