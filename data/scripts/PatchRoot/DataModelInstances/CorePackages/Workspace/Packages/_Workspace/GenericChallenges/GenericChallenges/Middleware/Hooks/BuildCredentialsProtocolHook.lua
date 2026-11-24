-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:31:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericChallenges = script:FindFirstAncestor("GenericChallenges")
local HttpService = game:GetService("HttpService")

local GenericChallengesParent = GenericChallenges.Parent
local default = require(GenericChallengesParent.CredentialsProtocol).CredentialsProtocol.default
local JavascriptHybrid = require(GenericChallenges.Types.JavascriptHybrid)
local _BuildHybridCallback = require(GenericChallenges.Middleware.BuildHybridCallback)

local GetFFlagLuaAppEnableCredentialsProtocol = require(GenericChallengesParent.CredentialsProtocol).Flags.GetFFlagLuaAppEnableCredentialsProtocol

local GetFIntLuaAppCredentialsProtocolAvailableTimeout = require(GenericChallengesParent.CredentialsProtocol).Flags.GetFIntLuaAppCredentialsProtocolAvailableTimeout

local GetFIntLuaAppCredentialsProtocolTimeout = require(GenericChallengesParent.CredentialsProtocol).Flags.GetFIntLuaAppCredentialsProtocolTimeout

local bool1 = game:DefineFastFlag("EnableGetCredentialsInCredentialsProtocolHook", false)
local ExecuteJavaScriptInWebView = require(GenericChallenges.Utils.ExecuteJavaScriptInWebView)

return function(tbl1)
    local var1 = default
    local var2 = ExecuteJavaScriptInWebView
    local fFlagLuaAppEnableCredentialsProtocol = GetFFlagLuaAppEnableCredentialsProtocol()
    if tbl1 ~= nil and tbl1.defaultExecuteJavaScriptInWebView ~= nil then
        var2 = tbl1.defaultExecuteJavaScriptInWebView
    end
    if tbl1 ~= nil and tbl1.defaultCredentialsProtocol ~= nil then
        var1 = tbl1.defaultCredentialsProtocol
    end
    if tbl1 ~= nil and tbl1.defaultCredentialsProtocolEnabled ~= nil then
        fFlagLuaAppEnableCredentialsProtocol = tbl1.defaultCredentialsProtocolEnabled
    end
    return function(arg1): boolean
        if fFlagLuaAppEnableCredentialsProtocol then
            if arg1.feature == JavascriptHybrid.Feature.CredentialsProtocolAvailable then
                var1:isAvailable(default.CredentialsTypes.FIDO2, GetFIntLuaAppCredentialsProtocolAvailableTimeout()):andThen(function(arg2)
                    local isAvailable = arg2.isAvailable or false
                    var2.Execute(arg1.data.callId, tostring(isAvailable))
                end):catch(
                    function()
                        var2.Execute(arg1.data.callId, "false")
                    end
                )
            elseif bool1 and arg1.feature == JavascriptHybrid.Feature.GetCredentials then
                var1:getCredentials(
                    default.CredentialsTypes.FIDO2,
                    arg1.data.authenticationOptionsJSON,
                    GetFIntLuaAppCredentialsProtocolTimeout()
                ):andThen(
                    function(input)
                        var2.Execute(arg1.data.callId, if input then HttpService:JSONEncode(input) else "")
                    end
                ):catch(
                    function()
                        var2.Execute(arg1.data.callId, "")
                    end
                )
            end
        end
        return false
    end
end
