-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:21:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ErrorCodes = require(script.Parent.Acp.AcpProtocol).ErrorCodes
local _store = require(script.Parent.Types.store)

local tbl1 = {
    [ErrorCodes.InsufficientFunds] = "payment_required",
    [ErrorCodes.Forbidden] = "ineligible",
    [ErrorCodes.MissingThumbnail] = "missing_thumbnail"
}

local function classifyAdCampaignFailure(arg1)
    local responseCode = if type(arg1) == "table" and type(arg1.responseCode) == "number" then arg1.responseCode else nil
    local message = if type(arg1) == "table" and type(arg1.errorMessage) == "string" then arg1.errorMessage else tostring(arg1)
    return {
        kind = if responseCode == nil then "unknown" else tbl1[responseCode] or "unknown",
        code = responseCode,
        message = message
    }
end
return classifyAdCampaignFailure
