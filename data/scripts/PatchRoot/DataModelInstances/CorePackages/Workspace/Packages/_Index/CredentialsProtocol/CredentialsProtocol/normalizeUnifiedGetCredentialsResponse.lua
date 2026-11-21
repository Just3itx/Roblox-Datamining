-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Constants = require(script.Parent.Constants)

local function normalizeUnifiedGetCredentialsResponse(response)
    if typeof(response) ~= "table" then
        return response
    end

    if response.credentialType ~= nil or response.errorCode ~= nil then
        return response
    end

    return if typeof(response.id) == "string" and typeof(response.response) == "table" then {
        credentialType = Constants.CredentialsTypes.FIDO2,
        response = response
    } else response
end

return normalizeUnifiedGetCredentialsResponse
