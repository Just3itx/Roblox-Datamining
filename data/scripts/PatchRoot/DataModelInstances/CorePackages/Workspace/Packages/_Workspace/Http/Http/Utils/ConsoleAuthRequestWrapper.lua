-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-18T23:41:20Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local MessageBusService = game:GetService("MessageBusService")

local Http = script:FindFirstAncestor("Http")
local HttpParent = Http.Parent
local Promise = require(HttpParent.Promise)
local Cryo = require(HttpParent.Cryo)
local Logging = require(HttpParent.AppCommonLib).Logging

local _RequestTypes = require(Http.RequestTypes)
local FFlagEnableStrictConsoleAuthCredentialHeaders = require(Http.Flags.FFlagEnableStrictConsoleAuthCredentialHeaders)

return function(arg1, url: string, method: string, arg2, bool1: boolean?)
    return Promise.new(function(arg3, callback)
        MessageBusService:MakeRequest("CredentialsProtocol", "getHeaders", {
            url = url,
            method = method
        }, function(tbl1)
            if not (tbl1 and tbl1.success) then
                Logging.warn("credential headers error")

                callback({})
                if FFlagEnableStrictConsoleAuthCredentialHeaders and bool1 then
                    return
                end
            end
            arg2.headers = Cryo.Dictionary.join(arg2.headers or {}, tbl1.headers or {})
            return arg1(url, method, arg2):andThen(arg3):catch(callback)
        end, {})
    end)
end
