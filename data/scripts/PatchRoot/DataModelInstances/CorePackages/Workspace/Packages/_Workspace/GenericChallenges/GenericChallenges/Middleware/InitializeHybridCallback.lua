-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:31:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericChallenges = script:FindFirstAncestor("GenericChallenges")
local BuildHybridCallback = require(script.Parent.BuildHybridCallback)
local _ChallengeWebView = require(script.Parent.ChallengeWebView)
local ChallengeError = require(script.Parent.ChallengeError)
local completionDataToRawHeaders = require(GenericChallenges.Utils.completionDataToRawHeaders)

local GenericChallengesParent = GenericChallenges.Parent
local _LuauPolyfill = require(GenericChallengesParent.LuauPolyfill)
local ErrorKind = require(GenericChallenges.Types.ErrorKind)
local BuildCredentialsProtocolHook = require(script.Parent.Hooks.BuildCredentialsProtocolHook)

return function(challengeId: string, challengeType: string, arg1, func1: (...any) -> (...any), callback, callback2: (...any) -> (...any), callback3: (...any) -> (...any))
    return BuildHybridCallback({
        Hooks = { BuildCredentialsProtocolHook() },
        OnChallengeLoadFailed = function(_)
            if callback ~= nil then
                callback()
            end
            callback3(ChallengeError.new(ErrorKind.LoadFailed, { challengeType = challengeType }))

            arg1:close()
        end,
        OnChallengeInvalidated = function(tbl1)
            if callback ~= nil and tbl1.data ~= nil then
                callback(tbl1.data)
            end
            callback3(ChallengeError.new(ErrorKind.Invalidated, tbl1.data))
            arg1:close()
        end,
        OnChallengeDisplayed = function(_)
            arg1:setVisible(true)
        end,
        OnChallengeCompleted = function(tbl1)
            if tbl1.data ~= nil and tbl1.data.challengeType ~= nil and tbl1.data.metadata ~= nil then
                callback2(
                    func1(
                        completionDataToRawHeaders(
                            {
                                challengeId = challengeId,
                                challengeType = tbl1.data.challengeType,
                                metadata = tbl1.data.metadata
                            }
                        )
                    )
                )
            end

            arg1:close()
        end
    })
end
