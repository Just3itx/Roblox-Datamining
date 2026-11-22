-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:41:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local IXPService = game:GetService("IXPService")
local UserInputService = game:GetService("UserInputService")

local Squads = script:FindFirstAncestor("Squads")
local SquadsParent = Squads.Parent
local SharedFlags = require(SquadsParent.SharedFlags)

local _SquadButtonSourceEnum = require(Squads.Enums.SquadButtonSourceEnum)
local SquadButtonClickIntentionEnum = require(Squads.Enums.SquadButtonClickIntentionEnum)

local Responsive = require(SquadsParent.Responsive)
local usePreferredInput = Responsive.usePreferredInput
local useIsTvRemoteDevice = require(SquadsParent.RoactUtils).Hooks.useIsTvRemoteDevice

local dependencies = require(Squads.dependencies)
local Foundation = dependencies.Foundation
local React = dependencies.React
local _Enums = require(SquadsParent.SquadsCore.Enums)

local SquadExternalContractContext = require(SquadsParent.SquadsCore.SquadExternalContractProvider).SquadExternalContractContext
local SquadState = require(SquadsParent.SquadsCore.Enums).SquadState
local leaveSquad = require(SquadsParent.SquadsCore.Thunks).leaveSquad
local useDispatch = dependencies.Hooks.useDispatch
local useLocalization = dependencies.Hooks.useLocalization
local useSelector = dependencies.Hooks.useSelector

local EventNames = require(SquadsParent.SquadsCore.EventNames)
local SquadPromptType = require(SquadsParent.SquadsCore.Enums).SquadPromptType
local useSquadState = require(SquadsParent.SquadsCore.Hooks).useSquadState

local useTokens = Foundation.Hooks.useTokens

local FFlagPartyDevAPIToRespectThirdPartySettingsEnabled = SharedFlags.FFlagPartyDevAPIToRespectThirdPartySettingsEnabled
local FFlagDebugAppChatEnableDomLocators = SharedFlags.FFlagDebugAppChatEnableDomLocators
local bool1 = game:DefineFastFlag("AppChatSquadButtonColorUpdate", false)
local bool2 = game:DefineFastFlag("AppChatSquadButtonColorVariantB", false)

local bool3 = game:DefineFastFlag("AppChatSquadButtonColorUpdateIxpEnabled", false)

local layerName = game:DefineFastString("AppChatSquadButtonColorUpdateIxpLayer", "Social.AppChat")

return function(tbl1)
    local var1 = useLocalization({
        joinButtonText = "Feature.Squads.Action.Join",
        startButtonText = "Feature.Squads.Action.Start",
        viewButtonText = "Feature.Squads.Action.View"
    })

    local var2 = useDispatch()
    local var3 = usePreferredInput()
    local var4 = useIsTvRemoteDevice()
    local var5 = useTokens()
    local var6 = React.useContext(SquadExternalContractContext)
    local var7 = var6.useParentChannelHasGroupUp(tbl1.conversationId)
    local var8 = not FFlagPartyDevAPIToRespectThirdPartySettingsEnabled or var6.useIsChatEnabled()

    local var9 = useSquadState()

    local var10 = React.useCallback(function(arg1)
        if arg1.Squad and arg1.Squad.Squad then
            return arg1.Squad.Squad.currentSquad
        end

        return nil
    end, {})

    local var11 = useSelector(var10)

    local var12 = React.useMemo(function()
        return var11 and var11.parentChannelId == tbl1.conversationId
    end, { var11, tbl1.conversationId })

    local userIntention = React.useMemo(function()
        return if var12 then SquadButtonClickIntentionEnum.View elseif var7 then SquadButtonClickIntentionEnum.Join else SquadButtonClickIntentionEnum.Create
    end, { var12, var7 })

    local var14 = React.useMemo(function()
        return if var12 then var1.viewButtonText elseif var7 then var1.joinButtonText else var1.startButtonText
    end, {
        var7,
        var12,
        var1.joinButtonText,
        var1.startButtonText,
        var1.viewButtonText
    })

    local var15 = React.useCallback(function()
        var6.fireSquadAnalytics(EventNames.EnterSquadButtonPressed, {
            conversationId = tbl1.conversationId,
            squadButtonSource = tbl1.squadButtonSource,
            squadId = var11 and var11.squadId,
            squadLocation = tbl1.squadLocation,
            userIntention = userIntention
        })
    end, {
        userIntention,
        var11,
        tbl1.conversationId,
        tbl1.squadButtonSource,
        tbl1.squadLocation,
        var6.fireSquadAnalytics
    })

    local useCallback = React.useCallback

    local function func1()
        var15()
        if not var12 and var11 then
            var2(leaveSquad(SquadPromptType.JoinAnotherSquad, var6.setSquadPrompt, function()
                tbl1.onActivated(tbl1.conversationId)
            end, var6.squadLocation, not FFlagPartyDevAPIToRespectThirdPartySettingsEnabled or var8))

            return
        end

        tbl1.onActivated(tbl1.conversationId)
    end

    local onActivated = tbl1.onActivated

    local setSquadPrompt = var6.setSquadPrompt
    local squadLocation = var6.squadLocation
    local var16 = if FFlagPartyDevAPIToRespectThirdPartySettingsEnabled then var8 else nil
    local var13 = useCallback(func1, { var11, var12, onActivated, var15, setSquadPrompt, squadLocation, var16 })

    local bool4 = userIntention == SquadButtonClickIntentionEnum.View
    local bool5 = bool2
    local bool6 = not bool5

    React.useEffect(function()
        if bool3 then
            IXPService:LogFlagLinkedUserLayerExposure(layerName)
        end
    end, {})

    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        tag = bool1
            and {
                ["row align-x-center align-y-center gap-xsmall radius-medium"] = true,
                ["bg-action-standard stroke-action-standard"] = not bool4,
                ["bg-action-soft-emphasis stroke-action-soft-emphasis"] = bool4 and bool6,
                ["bg-action-emphasis stroke-action-emphasis"] = bool4 and bool5
            }
            or "row align-x-center align-y-center gap-xsmall stroke-action-standard radius-medium bg-action-standard",
        AutomaticSize = if tbl1.isFullWidth then Enum.AutomaticSize.None else Enum.AutomaticSize.XY,
        Size = UDim2.new(if tbl1.isFullWidth then 1 else 0, 0, 0, var5.Size.Size_800),
        isDisabled = var9 == SquadState.Initializing,
        onActivated = var13,
        LayoutOrder = tbl1.layoutOrder,
        padding = {
            left = UDim.new(0, var5.Padding.Small),
            right = UDim.new(0, var5.Padding.Small)
        },
        selection = {
            Selectable = tbl1.Selectable
        },
        testId = if FFlagDebugAppChatEnableDomLocators then `{tbl1.testId}{userIntention}` else nil
    }
    local tbl3 = {
        TextLabel = React.createElement(Foundation.Text, {
            tag = bool1
                and {
                    ["auto-xy text-label-small text-no-wrap text-truncate-end"] = true,
                    ["content-action-standard"] = not bool4,
                    ["content-action-soft-emphasis"] = bool4 and bool6,
                    ["content-action-emphasis"] = bool4 and bool5
                }
                or "auto-xy text-label-small content-action-standard text-truncate-end text-no-wrap",
            LayoutOrder = 2,
            Text = var14,
            testId = if FFlagDebugAppChatEnableDomLocators then `{tbl1.testId}{userIntention}--text` else nil,
            padding = {
                right = UDim.new(0, var5.Padding.XXSmall)
            },
            sizeConstraint = not tbl1.isFullWidth and {
                MaxSize = Vector2.new(var5.Size.Size_2800, var5.Size.Size_800)
            } or nil
        }),
        SignifierImage = 0
    }
    local element

    if tbl1.shouldShowSignifier and var3 == Responsive.Input.Directional and not var4 then
        element = React.createElement(Foundation.Icon, {
            LayoutOrder = 3,
            name = UserInputService:GetImageForKeyCode(Enum.KeyCode.ButtonX),
            size = Foundation.Enums.IconSize.Small,
            style = if bool1 and bool4 then if bool5 then var5.Color.ActionEmphasis.Foreground else var5.Color.ActionSoftEmphasis.Foreground else var5.Color.ActionStandard.Foreground
        })
    else
        element = nil
    end

    tbl3.SignifierImage = element
    return createElement(view, tbl2, tbl3)
end
