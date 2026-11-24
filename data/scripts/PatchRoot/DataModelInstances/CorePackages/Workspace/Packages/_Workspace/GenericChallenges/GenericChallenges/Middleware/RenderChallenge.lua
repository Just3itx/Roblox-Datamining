-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:31:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericChallenges = script:FindFirstAncestor("GenericChallenges")
local _ChallengeParameters = require(GenericChallenges.Types.ChallengeParameters)
local BuildHybridCallback = require(script.Parent.BuildHybridCallback)
local getLocalizedTitle = require(GenericChallenges.Utils.getLocalizedTitle)
local ChallengeWebView = require(script.Parent.ChallengeWebView)
local ChallengeError = require(script.Parent.ChallengeError)
local InitializeHybridCallback = require(script.Parent.InitializeHybridCallback)
local constants = require(GenericChallenges.Utils.constants)
local BuildCredentialsProtocolHook = require(script.Parent.Hooks.BuildCredentialsProtocolHook)
local ErrorKind = require(GenericChallenges.Types.ErrorKind)
local completionDataToRawHeaders = require(GenericChallenges.Utils.completionDataToRawHeaders)
local bool1 = game:DefineFastFlag("EnableRejectPromiseOnWebviewClosed", false)

local GenericChallengesParent = GenericChallenges.Parent
local _LuauPolyfill = require(GenericChallengesParent.LuauPolyfill)

return function(tbl1)
    if tbl1.rawResponseHeaders == nil then
        assert(tbl1.callbacks ~= nil, "Callbacks must be specified in manual challenge mode")
        assert(tbl1.challengeParameters ~= nil, "Challenge parameters must be specified in manual challenge mode")
        assert(tbl1.challengeType ~= nil, "Challenge type must be specified in manual challenge mode")
        local challengeWebView = ChallengeWebView.new({
            title = getLocalizedTitle(tbl1.title),
            challengeType = tbl1.challengeType,
            challengeParameters = tbl1.challengeParameters,
            modal = tbl1.renderWebViewInModal
        })
        local bool2 = false
        challengeWebView:setHybridCallback(
            BuildHybridCallback({
                Hooks = { BuildCredentialsProtocolHook() },
                OnChallengeLoadFailed = function(tbl2)
                    tbl1.callbacks.OnChallengeLoadFailed(tbl2)
                    challengeWebView:close()
                end,
                OnChallengeInvalidated = function(tbl2)
                    tbl1.callbacks.OnChallengeInvalidated(tbl2)
                    challengeWebView:close()
                end,
                OnChallengeCompleted = function(tbl2)
                    bool2 = true
                    tbl1.callbacks.OnChallengeCompleted(tbl2)
                    challengeWebView:close()
                end
            })
        )

        challengeWebView:setCloseCallback(function()
            if not bool2 and tbl1.callbacks.OnChallengeAbandoned ~= nil then
                tbl1.callbacks.OnChallengeAbandoned()
            end
        end)
        if tbl1.onWebViewOpen ~= nil then
            challengeWebView:setOpenCallback(tbl1.onWebViewOpen)
        end
        challengeWebView:open()

        return
    end

    assert(tbl1.retryRequestCallback ~= nil, "Retry request callback must be defined for generic handling")
    assert(tbl1.resolve ~= nil, "Promise resolution method must be provided for generic handling")
    assert(tbl1.reject ~= nil, "Promise rejection method must be provided for generic handling")
    local challengeWebView = ChallengeWebView.new({
        title = getLocalizedTitle(tbl1.title),
        rawResponseHeaders = tbl1.rawResponseHeaders,
        modal = tbl1.renderWebViewInModal
    })

    if bool1 then
        local challengeType = tbl1.rawResponseHeaders[constants.challengeTypeHeader]
        local challengeId = tbl1.rawResponseHeaders[constants.challengeIdHeader]

        local bool2 = false
        challengeWebView:setHybridCallback(
            BuildHybridCallback({
                Hooks = { BuildCredentialsProtocolHook() },
                OnChallengeLoadFailed = function(_)
                    if tbl1.challengeErrorCallback ~= nil then
                        tbl1.challengeErrorCallback()
                    end
                    tbl1.reject(ChallengeError.new(ErrorKind.LoadFailed, { challengeType = challengeType }))

                    challengeWebView:close()
                end,
                OnChallengeInvalidated = function(tbl2)
                    if tbl1.challengeErrorCallback ~= nil and tbl2.data ~= nil then
                        tbl1.challengeErrorCallback(tbl2.data)
                    end
                    tbl1.reject(ChallengeError.new(ErrorKind.Invalidated, tbl2.data))
                    challengeWebView:close()
                end,
                OnChallengeDisplayed = function(_)
                    challengeWebView:setVisible(true)
                end,
                OnChallengeCompleted = function(tbl2)
                    if tbl2.data ~= nil and tbl2.data.challengeType ~= nil and tbl2.data.metadata ~= nil then
                        tbl1.resolve(
                            tbl1.retryRequestCallback(
                                completionDataToRawHeaders(
                                    {
                                        challengeId = challengeId,
                                        challengeType = tbl2.data.challengeType,
                                        metadata = tbl2.data.metadata
                                    }
                                )
                            )
                        )
                    end

                    bool2 = true
                    challengeWebView:close()
                end
            })
        )
        challengeWebView:setCloseCallback(function()
            if not bool2 then
                tbl1.reject(ChallengeError.new(ErrorKind.Invalidated, { challengeType = challengeType }))
            end
        end)
    else
        challengeWebView:setHybridCallback(
            InitializeHybridCallback(
                tbl1.rawResponseHeaders[constants.challengeIdHeader],
                tbl1.rawResponseHeaders[constants.challengeTypeHeader],
                challengeWebView,
                tbl1.retryRequestCallback,
                tbl1.challengeErrorCallback,
                tbl1.resolve,
                tbl1.reject
            )
        )
    end

    challengeWebView:open()
end
