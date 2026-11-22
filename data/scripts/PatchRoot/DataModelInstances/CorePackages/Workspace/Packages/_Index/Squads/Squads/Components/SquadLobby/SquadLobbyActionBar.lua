-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:41:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Squads = script:FindFirstAncestor("Squads")
local AppStorageService = game:GetService("AppStorageService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local SquadsParent = Squads.Parent
local _CrossExperience = require(SquadsParent.CrossExperience)
local CrossExperienceVoice = require(SquadsParent.CrossExperienceVoice)
local FocusNavigationUtils = require(SquadsParent.FocusNavigationUtils)
local Foundation = require(SquadsParent.Foundation)
local React = require(SquadsParent.React)
local RoactUtils = require(SquadsParent.RoactUtils)
local RobloxAppSessionization = require(SquadsParent.RobloxAppSessionization)
local SocialCommon = require(SquadsParent.SocialCommon)
local UIBlox = require(SquadsParent.UIBlox)
local VoiceChat = require(SquadsParent.VoiceChat)
local useAppPolicy = require(SquadsParent.UniversalAppPolicy).useAppPolicy
local useLocalUserId = require(SquadsParent.RobloxAppHooks).useLocalUserId

local Constants = require(Squads.Common.Constants)
local dependencies = require(Squads.dependencies)
local SquadPartySheetActionEnum = require(Squads.Enums.SquadPartySheetActionEnum)
local FFlagSquadLobbyActionBarFixMicLevelRerender = require(Squads.Flags.FFlagSquadLobbyActionBarFixMicLevelRerender)

local SharedFlags = dependencies.SharedFlags

local SquadCoordinationExperienceJoinExperimentation = dependencies.SocialExperiments.SquadCoordinationExperienceJoinExperimentation
local SquadLobbySessionProvider = require(SquadsParent.SquadsCore.SquadSessionProvider).SquadLobbySessionProvider
local SquadState = require(SquadsParent.SquadsCore.Enums).SquadState
local leaveSquad = require(SquadsParent.SquadsCore.Thunks).leaveSquad
local useCurrentSquadParentChannelId = require(SquadsParent.SquadsCore.Hooks).useCurrentSquadParentChannelId
local useCurrentSquadSelector = dependencies.Hooks.useCurrentSquadSelector
local useDispatch = dependencies.Hooks.useDispatch
local useLocalization = dependencies.Hooks.useLocalization

local Badge = Foundation.Badge
local BadgeVariant = Foundation.Enums.BadgeVariant
local useTokens = Foundation.Hooks.useTokens

local useLastInputMethod = FocusNavigationUtils.useLastInputMethod

local ExternalEventConnection = RoactUtils.ExternalEventConnection

local EventNames = require(SquadsParent.SquadsCore.EventNames)

local SquadExternalContractContext = require(SquadsParent.SquadsCore.SquadExternalContractProvider).SquadExternalContractContext
local InputUtilities = SocialCommon.Utils.InputUtilities

local SessionType = RobloxAppSessionization.SessionType

local ControlState = UIBlox.Core.Control.Enum.ControlState
local withHoverTooltip = UIBlox.App.Dialog.TooltipV2.withHoverTooltip
local withTooltip = UIBlox.App.Dialog.TooltipV2.withTooltip

local useParticipant = CrossExperienceVoice.Hooks.useParticipant
local useParticipants = CrossExperienceVoice.Hooks.useParticipants
local useIsVoiceConnected = CrossExperienceVoice.Hooks.useIsVoiceConnected
local useIsVoiceFocused = CrossExperienceVoice.Hooks.useIsVoiceFocused
local useIsVoiceDisconnected = CrossExperienceVoice.Hooks.useIsVoiceDisconnected
local useBackgroundExperience = CrossExperienceVoice.Hooks.useBackgroundExperience
local useIsActiveParticipant = CrossExperienceVoice.Hooks.useIsActiveParticipant
local useIsParticipantMuted = CrossExperienceVoice.Hooks.useIsParticipantMuted
local useVoiceStatus = CrossExperienceVoice.Hooks.useVoiceStatus
local CrossExperienceVoiceManager = CrossExperienceVoice.CrossExperienceVoiceManager
local GetFFlagEnableCrossExpVoice = SharedFlags.GetFFlagEnableCrossExpVoice
local bool1 = game:DefineFastFlag("EnableCrossExpVoiceDebug", false)
local FFlagSquadsEnableFoundationTestIds = require(Squads.Flags.FFlagSquadsEnableFoundationTestIds)
local engineFeature = game:GetEngineFeature("AudioFocusManagement")

local str1 = game:DefineFastString("SquadExperiencePickerTooltipSeenStorageValue", "True")

local FFlagPartyDevAPIToRespectThirdPartySettingsEnabled = SharedFlags.FFlagPartyDevAPIToRespectThirdPartySettingsEnabled

local str2 = if SquadCoordinationExperienceJoinExperimentation.getIsSearchIconOnExpPickerEnabled() then "size-800-800" else "size-600-600"

local tbl1 = {
    ["icons/menu/platformChatOff"] = "speech-bubble-align-center",
    ["icons/common/play"] = "play-large",
    ["icons/common/search"] = "magnifying-glass",
    ["icons/navigation/close"] = "x",
    ["icons/controls/headphone"] = "headphones",
    ["icons/actions/truncationCollapse_small"] = "chevron-large-up",
    ["icons/status/player/developer"] = "hammer-code"
}

local str3 = if SquadCoordinationExperienceJoinExperimentation.getIsSearchIconOnExpPickerEnabled() then "icons/common/search" else "icons/common/play"

local function getTooltipWasShownFromAppStorage(key: string): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local success, result = pcall(function(): string
        return AppStorageService:GetItem(key)
    end)

    return if success and result ~= nil then result == str1 else false
end

local function setTooltipWasShownFromAppStorage(key: string) -- Luacid: Inlined by compiler; 1 call site recovered
    pcall(function()
        AppStorageService:SetItem(key, str1)
        AppStorageService:Flush()
    end)
end

local function func1(tbl2)
    local var1, var2 = React.useBinding(ControlState.Initialize)
    local var3 = useTokens()
    local var4 = useLastInputMethod()

    local tbl3 = {
        headerText = tbl2.tooltipText
    }

    local var5, var6 = React.useState(false)

    React.useEffect(function()
        if not SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() then
            return
        end

        if tbl2.enableFirstTimeTooltip
            and tbl2.showFtuxCustomConditionsMet
            and (tbl2.currentHoveredButton == "" or tbl2.currentHoveredButton == tbl2.triggerPointName)
            and not getTooltipWasShownFromAppStorage(tbl2.ftuxAppStorageKey)
        then
            setTooltipWasShownFromAppStorage(tbl2.ftuxAppStorageKey)

            if tbl2.currentHoveredButton == "" then
                var6(true)
            end
        elseif not tbl2.enableFirstTimeTooltip
            or tbl2.currentHoveredButton ~= "" and tbl2.currentHoveredButton ~= tbl2.triggerPointName
        then
            var6(false)
        end
    end, {
        tbl2.currentHoveredButton,
        tbl2.enableFirstTimeTooltip,
        tbl2.ftuxAppStorageKey,
        tbl2.showFtuxCustomConditionsMet,
        tbl2.triggerPointName
    })

    local callback = React.useCallback(function(arg1)
        if InputUtilities.isActivationInput(arg1) or var4 == "Gamepad" then
            var6(false)
        end
    end, { var4 })

    local tbl4 = {
        DisplayOrder = 6,
        disabled = false,
        guiTarget = CoreGui,
        active = if SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() then var5 else nil,
        triggerPointName = tbl2.triggerPointName
    }

    local function func2(arg1, arg2, callback2: ((...any) -> (...any))?)
        local onStateChanged = React.useCallback(function(arg3)
            local rawValue = ControlState.fromRawValue(arg3)

            if SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() then
                if rawValue == ControlState.Hover then
                    tbl2.onHoverCalled(tbl2.triggerPointName)
                elseif rawValue == ControlState.Default then
                    tbl2.onHoverCalled("")
                end
            end

            if callback2 then
                callback2(var1:getValue(), rawValue)
            end
            var2(rawValue)
        end, {
            var1,
            tbl2.onHoverCalled,
            tbl2.triggerPointName,
            var2
        })
        local var9 = React.useCallback(function()
            if tbl2.onActivated then
                tbl2.onActivated(var5)
            end
        end, { var5, tbl2.onActivated })

        local createElement = React.createElement
        local str4 = "Frame"
        local tbl5 = {
            AutomaticSize = tbl2.automaticSize,
            LayoutOrder = tbl2.layoutOrder,
            Size = UDim2.fromOffset(40, 40),
            BackgroundTransparency = 1,
            [React.Change.AbsolutePosition] = arg1,
            [React.Change.AbsoluteSize] = arg2
        }
        local tableValue1 = if SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() and var5 then React.createElement(ExternalEventConnection, { event = UserInputService.InputEnded, callback = callback }) else nil
        local createElement2 = React.createElement
        local view = Foundation.View
        local tbl6 = {
            Size = UDim2.fromScale(1, 1),
            backgroundStyle = tbl2.backgroundStyle,
            cornerRadius = UDim.new(0, var3.Radius.Circle),
            isDisabled = tbl2.isDisabled,
            onActivated = 0,
            onStateChanged = 0
        }

        if not SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() then
            var9 = tbl2.onActivated
        end

        tbl6.onActivated = var9

        tbl6.onStateChanged = onStateChanged
        return createElement(str4, tbl5, { InputEndedConnection = tableValue1, createElement2(view, tbl6, tbl2.children) })
    end

    local function func3(arg1)
        return func2(arg1, arg1, nil)
    end

    local function func4(arg1, callback)
        return func2(arg1, arg1, callback)
    end

    if SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() and var5 then
        return (withTooltip(tbl3, tbl4, func3))
    end

    return (withHoverTooltip(tbl3, tbl4, func4))
end

local function tagToSize(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return {
        ["size-600-600"] = arg1.Size.Size_600,
        ["size-800-800"] = arg1.Size.Size_800
    }
end

local function renderStandardImage(contentMuted, image, arg1, arg2, testId: string?)
    local name = tbl1[image]
    if not name then
        return React.createElement(Foundation.Image, {
            Image = image,
            tag = {
                ["content-emphasis"] = not contentMuted,
                ["content-muted"] = contentMuted,
                ["anchor-center-center position-center-center " .. arg1] = true
            },
            testId = testId
        })
    end

    local tbl2 = tagToSize(arg2)
    return React.createElement(Foundation.Icon, {
        name = name,
        style = if contentMuted then arg2.Color.Content.Muted else arg2.Color.Content.Emphasis,
        size = tbl2[arg1] or tbl2["size-600-600"],
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        testId = testId
    })
end

local function getLoadingIndicatorIcon(arg1, arg2, bool2: boolean?, bool3: boolean?, num1: number?)
    local str4 = if arg1.Config.ColorMode.IsLight == "true" then "MicDark" else "MicLight"

    if not bool2 or not arg2 or arg2.isMuted then
        return VoiceChat.Utils.GetIcon("Muted", str4)
    elseif bool3 then
        return VoiceChat.Utils.GetIcon("Unmuted", str4, num1)
    end
    return VoiceChat.Utils.GetIcon("Unmuted0", str4)
end

local function renderToggleAudioFocusButton(arg1, tooltipText, onActivated, currentHoveredButton, onHoverCalled)
    local createElement = React.createElement
    local func2 = func1
    local tbl2 = {
        automaticSize = Enum.AutomaticSize.X,
        currentHoveredButton = 0,
        enableFirstTimeTooltip = 0,
        ftuxAppStorageKey = 0,
        isDisabled = false,
        layoutOrder = 0,
        onActivated = 0,
        onHoverCalled = 0,
        showFtuxCustomConditionsMet = 0,
        tooltipText = 0,
        triggerPointName = "ToggleAudioFocusButton"
    }

    if not SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() then
        currentHoveredButton = nil
    end

    tbl2.currentHoveredButton = currentHoveredButton

    tbl2.enableFirstTimeTooltip = not SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() and nil

    tbl2.ftuxAppStorageKey = if SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() then "" else nil

    tbl2.onActivated = onActivated
    if not SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() then
        onHoverCalled = nil
    end

    tbl2.onHoverCalled = onHoverCalled

    tbl2.showFtuxCustomConditionsMet = not SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() and nil

    tbl2.tooltipText = tooltipText
    return createElement(func2, tbl2, {
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center
        }),
        UIPadding = React.createElement(
            "UIPadding",
            {
                PaddingLeft = UDim.new(0, arg1.Padding.Small),
                PaddingRight = UDim.new(0, arg1.Padding.Small)
            }
        ),
        ToggleFocusButtonIcon = React.createElement(Foundation.Image, {
            Image = "icons/controls/headphone",
            tag = "anchor-center-center position-center-center size-900 content-emphasis",
            testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-lobby-action-bar--audio-focus-button--icon" else nil
        }),
        CaretIcon = React.createElement(Foundation.Image, {
            Image = "icons/actions/truncationCollapse_small",
            tag = "anchor-center-center position-center-center size-300-300 content-emphasis",
            testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-lobby-action-bar--audio-focus-button--caret" else nil
        })
    })
end

return function(tbl2)
    local var1 = useDispatch()
    local var2 = useLocalization({
        audioText = "Feature.Squads.Label.Audio",
        findExperiencesText = if SquadCoordinationExperienceJoinExperimentation.getIsNewTooltipCopyEnabled() then "Feature.Squads.Label.FindExperiencesPlayTogether" else "Feature.Squads.Label.FindExperiences",
        leavePartyText = "Feature.Squads.Label.LeaveParty",
        muteMicText = "Feature.Squads.Label.MuteMic",
        unmuteMicText = "Feature.Squads.Label.UnmuteMic",
        viewChatText = "Feature.Squads.Label.ViewChat"
    })

    local var3 = useTokens()

    local parentChannelId = useCurrentSquadParentChannelId()
    local var5 = useCurrentSquadSelector()

    local voiceStatus = useVoiceStatus()

    local var7, var8 = React.useState("")

    local var9 = React.useCallback(function(arg1)
        var8(arg1)
    end, {})

    local membersLen = var5 and var5.members and #var5.members or 0

    local var10 = React.useCallback(function(arg1)
        return arg1.getCanUsePlatformChat()
    end, {})
    local var11 = useAppPolicy(var10)

    local var12 = React.useMemo(function(): string
        return HttpService:GenerateGUID()
    end, {})

    local var13 = if SquadCoordinationExperienceJoinExperimentation.getIsSquadLobbySessionEnabled() then React.useContext(SquadLobbySessionProvider.Context) else nil
    local var14 = React.useContext(SquadExternalContractContext)
    local var15 = not FFlagPartyDevAPIToRespectThirdPartySettingsEnabled or var14.useIsChatEnabled()

    local onActivated = React.useCallback(function(isFtuxTooltipShown)
        var14.fireSquadAnalytics(EventNames.PartySheetAction, {
            parentChannelId = parentChannelId,
            actionType = SquadPartySheetActionEnum.ChatButtonClicked,
            isFtuxTooltipShown = isFtuxTooltipShown,
            voiceStatus = voiceStatus
        })
        if parentChannelId and parentChannelId ~= "" and tbl2.navigateToChat then
            tbl2.navigateToChat(parentChannelId)
            return
        end
        tbl2.navigateAwayFromSquad()
    end, {
        tbl2.navigateAwayFromSquad,
        tbl2.navigateToChat,
        parentChannelId,
        var14.fireSquadAnalytics,
        voiceStatus
    })

    local useCallback = React.useCallback

    local function func2(isFtuxTooltipShown)
        if SquadCoordinationExperienceJoinExperimentation.getIsSquadLobbySessionEnabled() then
            var13.updateMetadata(SessionType.Metadata.SquadLobbyPage.ExperiencePickerUuid, HttpService:GenerateGUID(false))
        end

        var14.fireSquadAnalytics(EventNames.PartySheetAction, {
            parentChannelId = parentChannelId,
            actionType = SquadPartySheetActionEnum.PickExperienceButtonClicked,
            isFtuxTooltipShown = isFtuxTooltipShown,
            voiceStatus = voiceStatus
        })

        if SquadCoordinationExperienceJoinExperimentation.getShouldOpenSLPFromExpPickerEnabled() then
            var14.showSearchOverlay(var1)
            return
        end
        tbl2.navigateToHomePage()
    end

    local navigateToHomePage = tbl2.navigateToHomePage
    local fireSquadAnalytics = var14.fireSquadAnalytics
    local var17 = if SquadCoordinationExperienceJoinExperimentation.getShouldOpenSLPFromExpPickerEnabled() then var1 else nil
    local showSearchOverlay = if SquadCoordinationExperienceJoinExperimentation.getShouldOpenSLPFromExpPickerEnabled() then var14.showSearchOverlay else nil
    local updateMetadata = if SquadCoordinationExperienceJoinExperimentation.getIsSquadLobbySessionEnabled() then var13.updateMetadata else nil
    local var4 = useCallback(
        func2,
        {
            parentChannelId,
            navigateToHomePage,
            fireSquadAnalytics,
            var17,
            showSearchOverlay,
            updateMetadata,
            voiceStatus
        }
    )

    local useCallback2 = React.useCallback

    local function func3(isFtuxTooltipShown)
        var14.fireSquadAnalytics(EventNames.PartySheetAction, {
            parentChannelId = parentChannelId,
            actionType = SquadPartySheetActionEnum.EndCallButtonClicked,
            isFtuxTooltipShown = isFtuxTooltipShown,
            voiceStatus = voiceStatus
        })

        var1(leaveSquad(nil, var14.setSquadPrompt, function()
            tbl2.navigateAwayFromSquad()
        end, var14.squadLocation, not FFlagPartyDevAPIToRespectThirdPartySettingsEnabled or var15))
    end

    local navigateAwayFromSquad = tbl2.navigateAwayFromSquad

    local fireSquadAnalytics2 = var14.fireSquadAnalytics
    local setSquadPrompt = var14.setSquadPrompt
    local squadLocation = var14.squadLocation
    local var19 = if FFlagPartyDevAPIToRespectThirdPartySettingsEnabled then var15 else nil
    local var6 = useCallback2(
        func3,
        {
            var1,
            navigateAwayFromSquad,
            parentChannelId,
            fireSquadAnalytics2,
            setSquadPrompt,
            squadLocation,
            var19,
            voiceStatus
        }
    )

    local isDisabled = tbl2.squadState ~= SquadState.Active

    local useMemo = React.useMemo

    local function func4()
        local testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-lobby-action-bar--chat-button--icon" else nil
        local createElement = React.createElement
        local func5 = func1
        local tbl3 = {
            currentHoveredButton = if SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() then var7 else nil,
            enableFirstTimeTooltip = not SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() and nil,
            ftuxAppStorageKey = if SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() then "" else nil,
            isDisabled = isDisabled,
            layoutOrder = 2,
            onActivated = onActivated,
            onHoverCalled = if SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() then var9 else nil,
            showFtuxCustomConditionsMet = not SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() and nil,
            tooltipText = var2.viewChatText,
            triggerPointName = "ChatButton"
        }
        local tbl4 = { [1] = nil, nil }
        local element

        if tbl2.hasUnreadMessages then
            element = React.createElement(Badge, {
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.new(1, -var3.Size.Size_250, 0, var3.Size.Size_250),
                variant = BadgeVariant.Alert,
                testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-lobby-action-bar--chat-button--unread-badge" else nil
            })
        else
            element = nil
        end

        tbl4.UnreadMessagesBadge = element
        do
            (function(move, destination, values)
                move(values, 1, values.n, 1, destination)
            end)(table.move, tbl4, table.pack(renderStandardImage(isDisabled, "icons/menu/platformChatOff", "size-800-800", var3, testId)))
        end
        return createElement(func5, tbl3, tbl4)
    end

    local var21 = if SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() then var7 else nil
    local viewChatText = var2.viewChatText
    local var22 = if SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() then var9 else nil
    local var23 = useMemo(func4, { var21, var3, isDisabled, viewChatText, onActivated, var22, tbl2.hasUnreadMessages })

    local useMemo2 = React.useMemo

    local function func5()
        local testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-lobby-action-bar--pick-experience-button--icon" else nil
        if tbl2.isInExperience then
            return nil
        end

        return (React.createElement(func1, {
            currentHoveredButton = if SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() then var7 else nil,
            enableFirstTimeTooltip = if SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() then true else nil,
            ftuxAppStorageKey = if SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() then "SquadExperiencePickerTooltipSeen" else nil,
            isDisabled = isDisabled,
            layoutOrder = 3,
            onActivated = var4,
            onHoverCalled = if SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() then var9 else nil,
            showFtuxCustomConditionsMet = if SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() then membersLen >= 2 else nil,
            tooltipText = var2.findExperiencesText,
            triggerPointName = "PickExperienceButton"
        }, renderStandardImage(isDisabled, str3, str2, var3, testId)))
    end

    local var24 = if SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() then var7 else nil
    local findExperiencesText = var2.findExperiencesText
    local var25 = if SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() then membersLen else nil
    local var26 = if SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() then var9 else nil
    local pickExperienceButton = useMemo2(
        func5,
        {
            var24,
            var3,
            isDisabled,
            findExperiencesText,
            var25,
            var26,
            tbl2.isInExperience,
            tbl2.navigateToHomePage
        }
    )

    local useMemo3 = React.useMemo

    local function func6()
        local backgroundStyle = if isDisabled then var3.Color.ActionStandard.Background else var3.Color.System.Alert
        local testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-lobby-action-bar--end-call-button--icon" else nil
        return React.createElement(
            func1,
            {
                backgroundStyle = backgroundStyle,
                currentHoveredButton = if SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() then var7 else nil,
                enableFirstTimeTooltip = not SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() and nil,
                ftuxAppStorageKey = if SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() then "" else nil,
                isDisabled = isDisabled,
                layoutOrder = 4,
                onActivated = var6,
                onHoverCalled = if SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() then var9 else nil,
                showFtuxCustomConditionsMet = not SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() and nil,
                tooltipText = var2.leavePartyText,
                triggerPointName = "EndCallButton"
            },
            renderStandardImage(isDisabled, "icons/navigation/close", "size-600-600", var3, testId)
        )
    end

    local var28 = if SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() then var7 else nil
    local leavePartyText = var2.leavePartyText
    local var29 = if SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() then var9 else nil
    local endCallButton = useMemo3(func6, { var28, var3, isDisabled, leavePartyText, var6, var29 })

    local var31 = nil
    local var32, var33

    if GetFFlagEnableCrossExpVoice() then
        local num1 = tonumber(useLocalUserId()) or -1
        local var34 = React.useRef(0)
        local input = useBackgroundExperience()
        local input2 = useParticipant(num1)
        local var35 = useIsVoiceConnected()
        local var36 = useIsVoiceDisconnected()
        local var37 = useIsVoiceFocused() or tbl2.forceIsVoiceFocused
        local var38 = useParticipants()
        local var39 = useIsActiveParticipant(num1)
        local bool2 = if FFlagSquadLobbyActionBarFixMicLevelRerender then useIsParticipantMuted(num1) == true else nil
        local var40, var41 = React.useState(0)
        local bool3 = engineFeature

        local var16 = React.useCallback(function(_)
            print("----------- CEV FOREGROUND -----------")
            print("Experience info", HttpService:JSONEncode(input))
            print("Current Voice Participant", HttpService:JSONEncode(input2))
            print("Squads Store Participants", HttpService:JSONEncode(var38 or {}))
            print("--------------------------------------")
            CrossExperienceVoiceManager.default:dumpDebugData()
        end, { var38, input2 })

        local var18 = React.useCallback(function(_)
            if not input2 then
                return
            end

            if input2.isMuted then
                CrossExperienceVoiceManager.default:unmuteVoiceParticipant(input2.userId)
                return
            end
            CrossExperienceVoiceManager.default:muteVoiceParticipant(input2.userId)
        end, { input2 })

        local bool4 = not isDisabled

        if bool4 then
            if var35 then
                if input2 == nil then
                    bool4 = false
                else
                    bool4 = not input2.isMuted and var39 == true
                end
            else
                bool4 = var35
            end
        end

        React.useEffect(function()
            if FFlagSquadLobbyActionBarFixMicLevelRerender and not bool4 then
                return nil
            end
            local var44 = tbl2.renderStepService or RunService
            var44:BindToRenderStep(var12, 1, function()
                if var34.current > 3 then
                    var41(math.random())
                    var34.current = 0
                    return
                end
                var34.current += 1
            end)

            return function()
                var44:UnbindFromRenderStep(var12)
            end
        end, FFlagSquadLobbyActionBarFixMicLevelRerender and { bool4, tbl2.renderStepService } or { tbl2.renderStepService })

        var32 = React.useMemo(function()
            if not isDisabled and bool3 and var35 then
                return renderToggleAudioFocusButton(var3, var2.audioText, tbl2.toggleVoiceChatMenu, var7, var9)
            end

            return nil
        end, {
            var3,
            bool3,
            var7,
            isDisabled,
            var35,
            var2.audioText,
            var9,
            tbl2.toggleVoiceChatMenu
        })

        if bool1 then
            local useMemo4 = React.useMemo

            local function func7()
                local testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-lobby-action-bar--debug-voice-button--icon" else nil

                return React.createElement(
                    func1,
                    {
                        currentHoveredButton = if SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() then var7 else nil,
                        enableFirstTimeTooltip = not SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() and nil,
                        ftuxAppStorageKey = if SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() then "" else nil,
                        isDisabled = isDisabled,
                        layoutOrder = 5,
                        onActivated = var16,
                        onHoverCalled = if SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() then var9 else nil,
                        showFtuxCustomConditionsMet = not SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() and nil,
                        tooltipText = "Debug voice",
                        triggerPointName = "DebugVoiceButton"
                    },
                    renderStandardImage(isDisabled, "icons/status/player/developer", "size-600-600", var3, testId)
                )
            end

            local var44 = if SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() then var7 else nil
            local var45 = if SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() then var9 else nil
            var31 = useMemo4(func7, { var44, var3, isDisabled, var16, var45 })
        end

        local useMemo4 = React.useMemo

        local function func7()
            return getLoadingIndicatorIcon(var3, input2, var35, not isDisabled and var39, var40)
        end

        local var44 = if FFlagSquadLobbyActionBarFixMicLevelRerender then bool2 else nil
        local var45 = useMemo4(func7, { var39, isDisabled, var35, var40, input2, var3, var44 })

        local useMemo5 = React.useMemo

        local function func8()
            if var36 then
                return nil
            end
            if not isDisabled and engineFeature and not var37 then
                return nil
            end

            local contentMuted = not var35 or input2 == nil or isDisabled
            local var46 = not var35 or not input2 or input2.isMuted
            local testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-lobby-action-bar--mic-button--icon" else nil

            return React.createElement(func1, {
                currentHoveredButton = if SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() then var7 else nil,
                enableFirstTimeTooltip = not SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() and nil,
                ftuxAppStorageKey = if SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() then "" else nil,
                isDisabled = contentMuted,
                layoutOrder = 1,
                onActivated = var18,
                onHoverCalled = if SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() then var9 else nil,
                showFtuxCustomConditionsMet = not SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() and nil,
                tooltipText = if var46 then var2.unmuteMicText else var2.muteMicText,
                triggerPointName = "ToggleMicButton"
            }, renderStandardImage(contentMuted, var45, "size-800-800", var3, testId))
        end

        local var46 = if SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() then var7 else nil
        local muteMicText = var2.muteMicText
        local unmuteMicText = var2.unmuteMicText
        local var47 = if SquadCoordinationExperienceJoinExperimentation.getShouldShowFTUXOnExpPickerEnabled() then var9 else nil

        if not FFlagSquadLobbyActionBarFixMicLevelRerender then
            bool2 = nil
        end

        var33 = useMemo5(
            func8,
            {
                var46,
                var3,
                var45,
                isDisabled,
                var37,
                var35,
                muteMicText,
                unmuteMicText,
                var47,
                var18,
                input2,
                var36,
                bool2
            }
        )
    else
        var32 = nil
        var33 = nil
    end

    local createElement = React.createElement
    local view = Foundation.View
    local tbl3 = {
        AutomaticSize = Enum.AutomaticSize.X,
        AnchorPoint = tbl2.anchorPoint,
        Position = tbl2.position,
        Size = UDim2.fromOffset(0, Constants.SQUAD_LOBBY_ACTION_BAR_HEIGHT),
        backgroundStyle = var3.Color.OverMedia.OverMedia_0,
        cornerRadius = UDim.new(0, var3.Radius.Circle),
        layout = {
            FillDirection = Enum.FillDirection.Horizontal,
            Padding = UDim.new(0, var3.Gap.Large),
            SortOrder = Enum.SortOrder.LayoutOrder
        },
        padding = var3.Padding.Small,
        testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-lobby-action-bar" else nil
    }
    local tbl4 = {
        ToggleAudioFocusButton = var32,
        ToggleMicButton = var33,
        ChatButton = 0,
        PickExperienceButton = 0,
        EndCallButton = 0,
        DebugVoiceButton = 0
    }

    if not var11 then
        var23 = nil
    end

    tbl4.ChatButton = var23
    tbl4.PickExperienceButton = pickExperienceButton
    tbl4.EndCallButton = endCallButton
    tbl4.DebugVoiceButton = var31
    return createElement(view, tbl3, tbl4)
end
