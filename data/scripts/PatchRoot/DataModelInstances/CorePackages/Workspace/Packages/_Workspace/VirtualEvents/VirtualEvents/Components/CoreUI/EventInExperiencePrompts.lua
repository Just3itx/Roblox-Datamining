-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local Cryo = require(scriptParentParentParentParent.Cryo)

local useState = React.useState

local PromptConnections = require(scriptParentParentParent.Components.CoreUI.PromptConnections)
local RsvpPrompt = require(scriptParentParentParent.Components.CoreUI.RsvpPrompt)
local _InGameRsvpPushUpsellTypes = require(scriptParentParentParent.Common.InGameRsvpPushUpsellTypes)

local FocusNavigationUtils = require(scriptParentParentParentParent.FocusNavigationUtils)
local FocusRoot = FocusNavigationUtils.FocusRoot
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum

local bool1 = game:DefineFastFlag("FixFocusWhenInGameMenuIsOpen", false)
local FFlagInGameRsvpPushUpsellEnabled = require(scriptParentParentParentParent.SharedFlags).FFlagInGameRsvpPushUpsellEnabled
local FIntInGameRsvpPushUpsellDelayMs = require(scriptParentParentParent.Flags.FIntInGameRsvpPushUpsellDelayMs)
local fetchInGameRsvpPushUpsell = if FFlagInGameRsvpPushUpsellEnabled then require(scriptParentParentParent.Common.fetchInGameRsvpPushUpsell) else nil
local isInGameMenuOpen = if FFlagInGameRsvpPushUpsellEnabled then require(scriptParentParentParent.Common.isInGameMenuOpen) else nil
local PushUpsellPromptContainer = if FFlagInGameRsvpPushUpsellEnabled then require(scriptParentParentParent.Components.CoreUI.PushUpsellPrompt.PushUpsellPromptContainer) else nil
local tbl1 = { PromptRsvp = RsvpPrompt }

if FFlagInGameRsvpPushUpsellEnabled then
    tbl1.PromptPushUpsell = PushUpsellPromptContainer
end

local function enqueuePrompt(tbl2, tbl3)
    if tbl2.promptType ~= nil then
        return Cryo.Dictionary.join(tbl2, { promptQueue = Cryo.List.join(tbl2.promptQueue, { tbl3 }) })
    end

    return {
        promptType = tbl3.promptType,
        promptData = tbl3.promptData,
        promptQueue = {}
    }
end

local function dequeuePrompt(tbl2)
    if not Cryo.isEmpty(tbl2.promptQueue) then
        return Cryo.Dictionary.join(tbl2, {
            promptType = tbl2.promptQueue[1].promptType,
            promptData = tbl2.promptQueue[1].promptData,
            promptQueue = Cryo.List.removeIndex(tbl2.promptQueue, 1)
        })
    end
    return {
        promptType = nil,
        promptData = {},
        promptQueue = {}
    }
end

local var1 = FFlagInGameRsvpPushUpsellEnabled and function(callback: (...any) -> (...any)) -- name: usePushUpsellPromptQueue
    local var1 = React.useRef(true)
    React.useEffect(function()
        var1.current = true
        return function()
            var1.current = false
        end
    end, {})

    local var2 = React.useRef(false)

    local var3 = React.useCallback(function(promptData)
        if var2.current then
            return
        end
        var2.current = true
        callback(function(tbl2)
            return enqueuePrompt(tbl2, { promptType = "PromptPushUpsell", promptData = promptData })
        end)
    end, { callback })

    return React.useCallback(function(eventId: string)
        fetchInGameRsvpPushUpsell.fetch():andThen(function(arg1)
            if arg1 == nil then
                return
            end
            task.delay(FIntInGameRsvpPushUpsellDelayMs / 1000, function()
                if not var1.current or isInGameMenuOpen() then
                    return
                end
                var3({ promptType = arg1.promptType, path = arg1.path, translations = arg1.translations, eventId = eventId })
            end)
        end)
    end, { var3 })
end or function(_: (...any) -> (...any)) -- name: usePushUpsellPromptQueueDisabled
    return nil
end

return function(tbl2)
    local var2, var3 = useState({ promptType = nil, promptData = nil, promptQueue = {} })

    local promptData = var2.promptData
    local promptType = var2.promptType

    local closePrompt = React.useCallback(function()
        if FFlagInGameRsvpPushUpsellEnabled then
            var3(dequeuePrompt)
            return
        end

        if not Cryo.isEmpty(var2.promptQueue) then
            var3(
                Cryo.Dictionary.join(var2, {
                    promptType = var2.promptQueue[1].promptType,
                    promptData = var2.promptQueue[1].promptData,
                    promptQueue = Cryo.List.removeIndex(var2.promptQueue, 1)
                })
            )
        else
            var3({ promptType = nil, promptData = {}, promptQueue = {} })
        end
    end, { var2, var3 })

    local onRsvpGoingSucceeded = var1(var3)

    local element = nil
    if promptType then
        local var6 = tbl1[promptType]
        if var6 then
            element = React.createElement(var6, {
                enableInputDelayed = tbl2.enableInputDelayed,
                promptData = promptData,
                closePrompt = closePrompt,
                overrideUseWideMode = tbl2.overrideUseWideMode,
                onRsvpGoingSucceeded = onRsvpGoingSucceeded
            })
        else
            error(`Unexpected prompt type: {promptType}!`)
        end
    end

    local openRsvpPrompt = React.useCallback(function(eventId: string, eventDetails)
        if FFlagInGameRsvpPushUpsellEnabled then
            var3(function(tbl3)
                return enqueuePrompt(tbl3, { promptType = "PromptRsvp", promptData = { eventId = eventId, eventDetails = eventDetails } })
            end)

            return
        end

        if var2.promptType ~= nil then
            var3(
                Cryo.Dictionary.join(var2, {
                    promptQueue = Cryo.List.join(
                        var2.promptQueue,
                        {{
                            promptType = "PromptRsvp",
                            promptData = { eventId = eventId, eventDetails = eventDetails }
                        }}
                    )
                })
            )
        else
            var3({ promptType = "PromptRsvp", promptData = { eventId = eventId, eventDetails = eventDetails }, promptQueue = {} })
        end
    end, { var2, var3 })

    local var7 = nil
    local var8 = nil

    if bool1 then
        local var9
        var7, var9 = React.useState(GuiService.MenuIsOpen)
        var8 = var9

        React.useEffect(function()
            if not element then
                return
            end

            var8(GuiService.MenuIsOpen)

            local connection = GuiService.MenuOpened:Connect(function()
                var8(true)
            end)
            local connection2 = GuiService.MenuClosed:Connect(function()
                var8(false)
            end)
            return function()
                connection:Disconnect()
                connection2:Disconnect()
            end
        end, { element })
    end

    local createElement = React.createElement
    local fragment = React.Fragment
    local tbl3 = {}
    local tbl4 = {
        PromptConnections = React.createElement(PromptConnections, { openRsvpPrompt = openRsvpPrompt, closePrompt = closePrompt }),
        FocusNavigationCoreScriptsWrapper = if element then React.createElement(FocusRoot, {
            surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.CentralOverlay,
            isIsolated = true,
            isAutoFocusRoot = true,
            isFocusable = if bool1 then not var7 else nil
        }, { Prompt = element }) else nil
    }
    return createElement(fragment, tbl3, tbl4)
end
