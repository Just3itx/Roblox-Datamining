-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:40:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent

local HttpService = game:GetService("HttpService")

local Http = require(AuthCommonParent.Http)
local SharedFlags = require(AuthCommonParent.SharedFlags)
local AppStorageUtilities = require(AuthCommon.Utils.AppStorageUtilities)

local FFlagEnableLuaAccountSwitch = SharedFlags.FFlagEnableLuaAccountSwitch

return function(func1: (...any) -> (...any), authenticationTicket: string)
    local postBody = HttpService:JSONEncode({
        authenticationTicket = authenticationTicket,
        retainCurrentSession = true,
        accountBlob = FFlagEnableLuaAccountSwitch and AppStorageUtilities.getAccountBlob() or nil
    })

    return (func1(string.format("%sv1/authentication-ticket/redeem", Http.Url.AUTH_URL), "POST", { postBody = postBody }))
end
