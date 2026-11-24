-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:11:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreScriptsPlayerFeedback = script:FindFirstAncestor("CoreScriptsPlayerFeedback")
local CoreScriptsPlayerFeedbackParent = CoreScriptsPlayerFeedback.Parent

local React = require(CoreScriptsPlayerFeedbackParent.React)
local Cryo = require(CoreScriptsPlayerFeedbackParent.Cryo)
local FocusNavigationUtils = require(CoreScriptsPlayerFeedbackParent.FocusNavigationUtils)

local FocusRoot = FocusNavigationUtils.FocusRoot
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum

local PromptConnections = require(script.Parent.PromptConnections)
local PlayerFeedbackPrompt = require(CoreScriptsPlayerFeedback.Components.PlayerFeedbackPrompt)
local PlayerSupportPrompt = require(CoreScriptsPlayerFeedback.Components.PlayerSupportPrompt)
local UnavailablePrompt = require(CoreScriptsPlayerFeedback.Components.UnavailablePrompt)
local PlayerSupportUnavailablePrompt = require(CoreScriptsPlayerFeedback.Components.PlayerSupportUnavailablePrompt)
local PlayerSupportToast = require(CoreScriptsPlayerFeedback.Components.PlayerSupportToast)
local GetFFlagEnablePlayerSupportPrompt = require(CoreScriptsPlayerFeedback.Flags.GetFFlagEnablePlayerSupportPrompt)
local FFlagPlayerSupportPromptEventIngest = require(CoreScriptsPlayerFeedback.Flags.FFlagPlayerSupportPromptEventIngest)
local PlayerSupportPromptTelemetry = require(CoreScriptsPlayerFeedback.Telemetry.PlayerSupportPromptTelemetry)
local constants = require(CoreScriptsPlayerFeedback.constants)

local useLocalization = require(CoreScriptsPlayerFeedbackParent.Localization).Hooks.useLocalization
local fFlagEnablePlayerSupportPrompt = GetFFlagEnablePlayerSupportPrompt()

local tbl1 = {
    TICKET_CREATION_SUBMITTED = "ToastSubmitted",
    TICKET_CREATION_FAILED = "ToastFailed"
}

local tbl2 = { TICKET_CREATION_TEXT_FILTER_ERROR = true, TICKET_CREATION_GIBBERISH_ERROR = true }

local var1 = React.memo(function(tbl3)
    local var1, var2 = React.useState({ promptType = nil, promptData = nil, promptQueue = {} })

    local promptData = var1.promptData
    local promptType = var1.promptType

    local closePrompt = React.useCallback(function()
        var2(function(arg1)
            local promptQueue = arg1.promptQueue or {}
            if Cryo.isEmpty(promptQueue) then
                return {
                    promptType = nil,
                    promptData = {},
                    promptQueue = {}
                }
            end

            local var3 = promptQueue[1]
            return {
                promptType = var3.promptType,
                promptData = var3.promptData,
                promptQueue = Cryo.List.removeIndex(promptQueue, 1)
            }
        end)
    end, {})

    local openFeedbackPrompt = React.useCallback(function()
        var2(function(arg1)
            if arg1.promptType == nil then
                return {
                    promptType = "PromptFeedback",
                    promptData = {},
                    promptQueue = {}
                }
            end

            local promptQueue = arg1.promptQueue or {}
            return {
                promptType = arg1.promptType,
                promptData = arg1.promptData,
                promptQueue = Cryo.List.join(promptQueue, {{ promptType = "PromptFeedback", promptData = {} }})
            }
        end)
    end, {})

    local openUnavailablePrompt = React.useCallback(function(reason: string)
        var2(function(arg1)
            if arg1.promptType == nil then
                return {
                    promptType = "PromptUnavailable",
                    promptData = { reason = reason },
                    promptQueue = {}
                }
            end

            local promptQueue = arg1.promptQueue or {}
            return {
                promptType = arg1.promptType,
                promptData = arg1.promptData,
                promptQueue = Cryo.List.join(promptQueue, {{ promptType = "PromptUnavailable", promptData = { reason = reason } }})
            }
        end)
    end, {})

    local element = nil
    if promptType then
        if promptType == "PromptUnavailable" then
            element = React.createElement(UnavailablePrompt, {
                enableInputDelayed = tbl3.enableInputDelayed,
                reason = if promptData then promptData.reason else nil,
                closePrompt = closePrompt
            })
        elseif promptType == "PromptFeedback" then
            element = React.createElement(
                PlayerFeedbackPrompt,
                {
                    enableInputDelayed = tbl3.enableInputDelayed,
                    promptData = promptData,
                    closePrompt = closePrompt
                }
            )
        else
            error(string.format("Unexpected prompt type: %s!", tostring(promptType)))
        end
    end

    return React.createElement(React.Fragment, {}, {
        PromptConnections = React.createElement(PromptConnections, {
            openFeedbackPrompt = openFeedbackPrompt,
            openPlayerSupportPrompt = nil,
            openUnavailablePrompt = openUnavailablePrompt,
            openPlayerSupportUnavailablePrompt = nil,
            closePrompt = closePrompt
        }),
        FocusNavigationCoreScriptsWrapper = element
            and React.createElement(
                FocusRoot,
                {
                    surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.CentralOverlay,
                    isIsolated = true,
                    isAutoFocusRoot = true
                },
                { Prompt = element }
            )
    })
end)

local var2 = React.memo(function(tbl3)
    local var2 = useLocalization({
        ToastSubmitted = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Toast.Submitted",
        ToastFailed = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Toast.Failed"
    })

    local var3, var4 = React.useState({ promptType = nil, promptData = nil, promptQueue = {} })

    local text, var6 = React.useState(nil)
    local description, setDescription = React.useState("")
    local category, setCategory = React.useState("")
    local shareUserId, setShareUserId = React.useState(false)

    local promptData = var3.promptData
    local promptType = var3.promptType

    local onFormAbandoned = React.useCallback(function()
        setDescription("")
        setCategory("")
        setShareUserId(false)
    end, {})

    local onDismiss = React.useCallback(function()
        var6(nil)
    end, {})

    local closePrompt = React.useCallback(function()
        var4(function(arg1)
            local promptQueue = arg1.promptQueue or {}
            if Cryo.isEmpty(promptQueue) then
                return {
                    promptType = nil,
                    promptData = {},
                    promptQueue = {}
                }
            end

            local var15 = promptQueue[1]
            return {
                promptType = var15.promptType,
                promptData = var15.promptData,
                promptQueue = Cryo.List.removeIndex(promptQueue, 1)
            }
        end)
    end, {})

    local openFeedbackPrompt = React.useCallback(function()
        var4(function(arg1)
            if arg1.promptType == nil then
                return {
                    promptType = "PromptFeedback",
                    promptData = {},
                    promptQueue = {}
                }
            end

            local promptQueue = arg1.promptQueue or {}
            return {
                promptType = arg1.promptType,
                promptData = arg1.promptData,
                promptQueue = Cryo.List.join(promptQueue, {{ promptType = "PromptFeedback", promptData = {} }})
            }
        end)
    end, {})

    local openPlayerSupportPrompt = React.useCallback(function()
        var4(function(arg1)
            if arg1.promptType == nil then
                return {
                    promptType = "PromptPlayerSupport",
                    promptData = {},
                    promptQueue = {}
                }
            end

            local promptQueue = arg1.promptQueue or {}
            return {
                promptType = arg1.promptType,
                promptData = arg1.promptData,
                promptQueue = Cryo.List.join(promptQueue, {{ promptType = "PromptPlayerSupport", promptData = {} }})
            }
        end)
    end, {})

    local openUnavailablePrompt = React.useCallback(function(reason: string)
        var4(function(arg1)
            if arg1.promptType == nil then
                return {
                    promptType = "PromptUnavailable",
                    promptData = { reason = reason },
                    promptQueue = {}
                }
            end

            local promptQueue = arg1.promptQueue or {}
            return {
                promptType = arg1.promptType,
                promptData = arg1.promptData,
                promptQueue = Cryo.List.join(promptQueue, {{ promptType = "PromptUnavailable", promptData = { reason = reason } }})
            }
        end)
    end, {})

    local openPlayerSupportUnavailablePrompt = React.useCallback(function(reason: string)
        if FFlagPlayerSupportPromptEventIngest then
            PlayerSupportPromptTelemetry.logTicketResult(reason, {
                category = category,
                shareUserId = constants.PLAYER_SUPPORT_CATEGORIES_REQUIRING_USER_ID[category] == true or shareUserId,
                descriptionLength = #description
            })
        end
        local var19 = tbl1[reason]
        if var19 then
            onFormAbandoned()
            var6(var2[var19])
            return
        end
        var4(function(arg1)
            if arg1.promptType == nil then
                return {
                    promptType = "PromptPlayerSupportUnavailable",
                    promptData = { reason = reason },
                    promptQueue = {}
                }
            end

            local promptQueue = arg1.promptQueue or {}
            return {
                promptType = arg1.promptType,
                promptData = arg1.promptData,
                promptQueue = Cryo.List.join(promptQueue, {{ promptType = "PromptPlayerSupportUnavailable", promptData = { reason = reason } }})
            }
        end)
    end, FFlagPlayerSupportPromptEventIngest and {
        var2,
        onFormAbandoned,
        category,
        shareUserId,
        description
    }
        or { var2, onFormAbandoned })

    local element = nil
    if promptType then
        if promptType == "PromptUnavailable" then
            element = React.createElement(UnavailablePrompt, {
                enableInputDelayed = tbl3.enableInputDelayed,
                reason = if promptData then promptData.reason else nil,
                closePrompt = closePrompt
            })
        elseif promptType == "PromptPlayerSupportUnavailable" then
            local reason = if promptData then promptData.reason else nil
            element = React.createElement(PlayerSupportUnavailablePrompt, {
                enableInputDelayed = tbl3.enableInputDelayed,
                reason = reason,
                closePrompt = closePrompt,
                openPlayerSupportPrompt = if tbl2[reason] then openPlayerSupportPrompt else nil
            })
        elseif promptType == "PromptPlayerSupport" then
            element = React.createElement(PlayerSupportPrompt, {
                enableInputDelayed = tbl3.enableInputDelayed,
                promptData = promptData,
                closePrompt = closePrompt,
                description = description,
                setDescription = setDescription,
                category = category,
                setCategory = setCategory,
                shareUserId = shareUserId,
                setShareUserId = setShareUserId,
                onFormAbandoned = onFormAbandoned
            })
        elseif promptType == "PromptFeedback" then
            element = React.createElement(
                PlayerFeedbackPrompt,
                {
                    enableInputDelayed = tbl3.enableInputDelayed,
                    promptData = promptData,
                    closePrompt = closePrompt
                }
            )
        else
            error(string.format("Unexpected prompt type: %s!", tostring(promptType)))
        end
    end

    return React.createElement(React.Fragment, {}, {
        PromptConnections = React.createElement(PromptConnections, {
            openFeedbackPrompt = openFeedbackPrompt,
            openPlayerSupportPrompt = openPlayerSupportPrompt,
            openUnavailablePrompt = openUnavailablePrompt,
            openPlayerSupportUnavailablePrompt = openPlayerSupportUnavailablePrompt,
            closePrompt = closePrompt
        }),
        FocusNavigationCoreScriptsWrapper = element
            and React.createElement(
                FocusRoot,
                {
                    surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.CentralOverlay,
                    isIsolated = true,
                    isAutoFocusRoot = true
                },
                { Prompt = element }
            ),
        Toast = if text then React.createElement(PlayerSupportToast, { text = text, onDismiss = onDismiss }) else nil
    })
end)

return (React.memo(function(tbl3)
    if fFlagEnablePlayerSupportPrompt then
        return React.createElement(var2, tbl3)
    end

    return React.createElement(var1, tbl3)
end))
