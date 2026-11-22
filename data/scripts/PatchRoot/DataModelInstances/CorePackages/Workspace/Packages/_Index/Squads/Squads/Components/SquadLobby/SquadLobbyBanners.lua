-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")
local HttpService = game:GetService("HttpService")

local Squads = script:FindFirstAncestor("Squads")

local SquadsParent = Squads.Parent
local CrossExperience = require(SquadsParent.CrossExperience)
local CrossExperienceVoice = require(SquadsParent.CrossExperienceVoice)
local useLocalUserId = require(SquadsParent.RobloxAppHooks).useLocalUserId
local VoiceChat = require(SquadsParent.VoiceChat)
local useAppPolicy = require(SquadsParent.UniversalAppPolicy).useAppPolicy

local dependencies = require(Squads.dependencies)

local React = dependencies.React
local Foundation = dependencies.Foundation
local SharedFlags = dependencies.SharedFlags

local default = CrossExperienceVoice.CrossExperienceVoiceManager.default
local VoiceStatus = CrossExperience.Utils.VoiceStatus
local VoiceStatusChanged = CrossExperience.Actions.VoiceStatusChanged
local useVoiceStatus = CrossExperienceVoice.Hooks.useVoiceStatus
local useLocalization = dependencies.Hooks.useLocalization
local useDispatch = dependencies.Hooks.useDispatch
local useTokens = Foundation.Hooks.useTokens
local useNavigation = dependencies.useNavigation
local GetFFlagEnableCrossExpVoice = SharedFlags.GetFFlagEnableCrossExpVoice
local useCurrentSquadId = require(SquadsParent.SquadsCore.Hooks).useCurrentSquadId
local useCurrentSquadParentChannelId = require(SquadsParent.SquadsCore.Hooks).useCurrentSquadParentChannelId
local useStore = dependencies.Hooks.useStore
local SquadPromptType = require(SquadsParent.SquadsCore.Enums).SquadPromptType

local SquadExternalContractContext = require(SquadsParent.SquadsCore.SquadExternalContractProvider).SquadExternalContractContext
local getFFlagEnableCrossExpVoiceMemoryCheck = SharedFlags.getFFlagEnableCrossExpVoiceMemoryCheck
local FFlagEnableVoiceEuConsentPrompt = SharedFlags.FFlagEnableVoiceEuConsentPrompt
local FFlagSquadsEnableFoundationTestIds = require(Squads.Flags.FFlagSquadsEnableFoundationTestIds)

local useIsAnyOtherUserPartyVoiceEligible = require(Squads.Hooks.useIsAnyOtherUserPartyVoiceEligible)
local useIsLocalPlayerPartyVoiceEligible = require(SquadsParent.SquadsCore.Hooks).useIsLocalPlayerPartyVoiceEligible
local useIsCurrentSquadPartyVoiceEligible = require(SquadsParent.SquadsCore.Hooks).useIsCurrentSquadPartyVoiceEligible

local SQUAD_VOICE_EU_MODAL_CONSENT_GIVEN_KEY = require(SquadsParent.SquadsCore.Constants).SQUAD_VOICE_EU_MODAL_CONSENT_GIVEN_KEY
local SQUAD_VOICE_EU_MODAL_SEEN_KEY = require(SquadsParent.SquadsCore.Constants).SQUAD_VOICE_EU_MODAL_SEEN_KEY
local getTableAppStorageKey = require(SquadsParent.SquadsCore.appStorageAccess).getTableAppStorageKey
local displayEuConsentPrompt = require(SquadsParent.SquadsCore.displayEuConsentPrompt)

local str1 = game:DefineFastString("PartyVoiceBannerErrorUserNotEligibleURL", "")
local bool1 = game:DefineFastFlag("DisallowSquadLobbyBannersInlineButtons", false)
local bool2 = game:DefineFastFlag("DisablePartyVoiceEligibilityBanner", false)

function openWebview(title: string, url: string)
    local httpService = HttpService
    local input = { title = 0, presentationStyle = 0, visible = true, url = 0 }
    if not game:GetEngineFeature("SetWebViewTitle") then
        title = nil
    end

    input.title = title

    input.url = url
    local str3 = httpService:JSONEncode(input)

    GuiService:BroadcastNotification(str3, 20)
end

local function func1(tbl1)
    local var1 = useTokens()
    local var2 = tbl1.isButtonInline and not bool1

    local var3 = React.useMemo(function()
        local tbl2 = { React.createElement(Foundation.Text, {
                AutomaticSize = Enum.AutomaticSize.XY,
                backgroundStyle = var1.Color.None,
                colorstyle = var1.Color.Content.Emphasis,
                fontStyle = var1.Typography.BodySmall,
                LayoutOrder = 1,
                Text = tbl1.label,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center,
                TextTruncate = Enum.TextTruncate.None,
                TextWrapped = true,
                testId = if FFlagSquadsEnableFoundationTestIds then `{tbl1.testId}--label` else nil
            }) }

        if tbl1.sublabels then
            for i, sublabel in ipairs(tbl1.sublabels) do
                if not sublabel or sublabel == "" then
                    continue
                end

                table.insert(
                    tbl2,
                    React.createElement(Foundation.Text, {
                        AutomaticSize = Enum.AutomaticSize.XY,
                        backgroundStyle = var1.Color.None,
                        colorstyle = var1.Color.Content.Emphasis,
                        fontStyle = var1.Typography.BodySmall,
                        LayoutOrder = i + 1,
                        Text = sublabel,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextYAlignment = Enum.TextYAlignment.Center,
                        TextTruncate = Enum.TextTruncate.None,
                        TextWrapped = true,
                        RichText = true,
                        testId = if FFlagSquadsEnableFoundationTestIds then `{tbl1.testId}--sublabel-{i}` else nil
                    })
                )
            end
        end

        return tbl2
    end, { tbl1.label, tbl1.sublabels, tbl1.testId })

    local createElement = React.createElement
    local str2 = "Frame"
    local tbl2 = {
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.fromScale(1, 0),
        BackgroundColor3 = var1.Color.Surface.Surface_200.Color3,
        BackgroundTransparency = var1.Color.Surface.Surface_200.Transparency,
        LayoutOrder = tbl1.LayoutOrder
    }
    local tbl3 = {
        UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, var1.Radius.Small) }),
        UIPadding = React.createElement("UIPadding", {
            PaddingLeft = UDim.new(0, var1.Gap.XLarge),
            PaddingRight = UDim.new(0, var1.Gap.XLarge),
            PaddingTop = UDim.new(0, var1.Gap.Medium),
            PaddingBottom = UDim.new(0, var1.Gap.Medium)
        }),
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = if var2 then Enum.FillDirection.Horizontal else Enum.FillDirection.Vertical,
            Padding = if var2 then UDim.new(0, var1.Gap.XSmall) else UDim.new(0, var1.Gap.Medium),
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            Wraps = not var2,
            HorizontalFlex = if var2 then Enum.UIFlexAlignment.SpaceBetween else Enum.UIFlexAlignment.Fill,
            VerticalFlex = if var2 then Enum.UIFlexAlignment.Fill else Enum.UIFlexAlignment.None
        }),
        TextFrame = React.createElement(
            Foundation.View,
            {
                tag = "col auto-xy gap-small wrap",
                LayoutOrder = 1,
                testId = tbl1.testId
            },
            var3
        ),
        InlineButton = 0,
        BottomButton = 0
    }
    local element

    if tbl1.onActivated and var2 then
        element = React.createElement(Foundation.Button, {
            LayoutOrder = 2,
            AutomaticSize = Enum.AutomaticSize.Y,
            text = tbl1.buttonLabel,
            variant = Foundation.Enums.ButtonVariant.Link,
            onActivated = tbl1.onActivated,
            testId = if FFlagSquadsEnableFoundationTestIds then `{tbl1.testId}--button` else nil
        })
    else
        element = nil
    end

    tbl3.InlineButton = element
    local element2

    if tbl1.onActivated and not var2 then
        element2 = React.createElement(Foundation.Button, {
            LayoutOrder = 2,
            text = tbl1.buttonLabel,
            variant = Foundation.Enums.ButtonVariant.Standard,
            size = Foundation.Enums.ButtonSize.Small,
            onActivated = tbl1.onActivated,
            fillBehavior = Foundation.Enums.FillBehavior.Fill,
            testId = if FFlagSquadsEnableFoundationTestIds then `{tbl1.testId}--button` else nil
        })
    else
        element2 = nil
    end

    tbl3.BottomButton = element2
    return createElement(str2, tbl2, tbl3)
end

local function func2(tbl1)
    local var1 = useLocalUserId()
    local var2 = useDispatch()
    local var3 = React.useContext(SquadExternalContractContext)
    local var4, var5 = React.useState(false)

    local tableAppStorageKey = getTableAppStorageKey(SQUAD_VOICE_EU_MODAL_SEEN_KEY)
    local tableAppStorageKey2 = getTableAppStorageKey(SQUAD_VOICE_EU_MODAL_CONSENT_GIVEN_KEY)

    React.useEffect(function()
        if tableAppStorageKey[tostring(var1)] and not tableAppStorageKey2[tostring(var1)] then
            var5(true)
        end
    end, { HttpService:JSONEncode(tableAppStorageKey), HttpService:JSONEncode(tableAppStorageKey2) })

    React.useEffect(function()
        local connection = default.VoiceEuModalConsented.Event:Connect(function()
            var5(false)
        end)

        local connection2 = default.VoiceEuModalRefused.Event:Connect(function()
            var5(true)
        end)
        return function()
            connection:Disconnect()
            connection2:Disconnect()
        end
    end, {})

    if not var4 then
        return nil
    end

    return (React.createElement(func1, {
        LayoutOrder = tbl1.LayoutOrder,
        label = "Give consent to the voice recording policy in order to access voice chat.",
        buttonLabel = "Connect",
        isButtonInline = true,
        testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-lobby-banner-eu-consent" else nil,
        onActivated = function()
            var2(displayEuConsentPrompt(var3.setSquadPrompt, tostring(var1), tableAppStorageKey, tableAppStorageKey2))
        end
    }))
end

local function func3(tbl1)
    local var1 = useDispatch()
    local var2 = useStore()
    local var3 = React.useContext(SquadExternalContractContext)
    local partyId = useCurrentSquadId() or ""
    local var5 = useVoiceStatus()

    local bool3 = var5 == CrossExperience.Constants.VOICE_STATUS.ERROR_JOIN_FEASIBILITY_CHECK_FAILED
    local var6 = VoiceStatus.isVoiceRetriableErrorByGameJoin(var5) or VoiceStatus.isVoiceRetriableErrorByVoiceJoin(var5)
    local var7 = useLocalization(
        {
            errorText = "Feature.Squads.Label.VoiceErrorGeneral",
            errorButton = "Feature.Squads.Action.VoiceErrorGeneral"
        }
    )

    local var8 = React.useCallback(function()
        local function onCancel(shouldIgnoreMemoryWarning: boolean?)
            var1(VoiceStatusChanged({ status = CrossExperience.Constants.VOICE_STATUS.RCC_CONNECTING }))

            default:join({ partyId = partyId, force = true, shouldIgnoreMemoryWarning = shouldIgnoreMemoryWarning })
        end

        if getFFlagEnableCrossExpVoiceMemoryCheck() and bool3 then
            if default:performJoinFeasibilityCheck() then
                onCancel()
                return
            end
            var3.setSquadPrompt(var2, {
                hideCancelButton = false,
                promptType = SquadPromptType.ConnectVoiceWithLowMemory,
                onConfirm = function() end,
                onCancel = function()
                    onCancel(true)
                end
            })

            return
        end

        if not VoiceStatus.isVoiceRetriableErrorByGameJoin(var5) then
            if VoiceStatus.isVoiceRetriableErrorByVoiceJoin(var5) then
                default:rejoinVoice()
            end

            return
        end

        if getFFlagEnableCrossExpVoiceMemoryCheck() then
            onCancel()
            return
        end
        var1(VoiceStatusChanged({ status = CrossExperience.Constants.VOICE_STATUS.RCC_CONNECTING }))

        default:join({ partyId = partyId, force = true })
    end, { var5, partyId, bool3 })

    if getFFlagEnableCrossExpVoiceMemoryCheck() then
        var6 = bool3 or var6
    end

    if not var6 then
        return nil
    end

    local createElement = React.createElement
    local func4 = func1
    local tbl2 = {
        LayoutOrder = tbl1.LayoutOrder,
        label = var7.errorText,
        buttonLabel = var7.errorButton,
        isButtonInline = true,
        onActivated = 0,
        testId = 0
    }
    if partyId == "" then
        var8 = nil
    end

    tbl2.onActivated = var8
    tbl2.testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-lobby-banner-voice-error" else nil
    return (createElement(func4, tbl2))
end

local function func4(tbl1)
    local var1 = useIsCurrentSquadPartyVoiceEligible()
    local var2 = useIsLocalPlayerPartyVoiceEligible()
    local var3 = useIsAnyOtherUserPartyVoiceEligible()
    local var4 = useLocalization({
        errorText = "Feature.Squads.Label.VoiceErrorUserIneligible",
        errorButton = "Feature.Squads.Action.VoiceErrorUserIneligible"
    })

    local var5 = useAppPolicy(function(arg1)
        return arg1.getWebViewSupport()
    end)

    local var6 = React.useCallback(function()
        if str1 ~= "" then
            openWebview(var4.errorButton, str1)
        end
    end, { var4.errorButton })

    if not var1 or var2 or not var3 then
        return nil
    end

    local createElement = React.createElement
    local func5 = func1
    local tbl2 = {
        LayoutOrder = tbl1.LayoutOrder,
        label = var4.errorText,
        buttonLabel = var4.errorButton,
        isButtonInline = false,
        onActivated = 0,
        testId = 0
    }
    if not var5 or str1 == "" then
        var6 = nil
    end

    tbl2.onActivated = var6

    tbl2.testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-lobby-banner-user-voice-ineligible" else nil
    return createElement(func5, tbl2)
end

local function func5(tbl1)
    local var1 = useVoiceStatus()
    local var2 = useCurrentSquadId() or ""
    local var3 = React.useMemo(function()
        return VoiceChat.Utils.GetSettingsAppAvailable()
    end, {})

    local var4 = useAppPolicy(function<T>(arg1: T): T
        return arg1
    end)

    local errorSubtext1 = React.useMemo(function()
        return (if var3 then var4.getMicSettingsDeeplinkDirectionsLocaleKey() else var4.getMicSettingsDirectionsLocaleKey()) or nil
    end, { var4, var3 })

    local errorSubtext2 = React.useMemo(function(): string?
        return if var4.getRequiresAppRestartOnMicAccessChange() then "Feature.SettingsHub.Prompt.RestartOnMicAccessChange" else nil
    end, { var4, var3 })

    local var7 = useLocalization({
        errorText = "Feature.SettingsHub.Prompt.Subtitle.AllowMicrophoneAccess",
        errorSubtext1 = errorSubtext1,
        errorSubtext2 = errorSubtext2,
        errorButton = "Feature.SettingsHub.Action.OpenSettings"
    })

    local var8 = VoiceStatus.isMicPermissionsError(var1)

    local var9 = React.useCallback(function()
        pcall(function()
            VoiceChat.Utils.SwitchToMicrophoneSettings()
        end)
    end, {})

    if not var8 then
        return nil
    end

    local createElement = React.createElement
    local func6 = func1
    local tbl2 = {
        LayoutOrder = tbl1.LayoutOrder,
        label = var7.errorText,
        sublabels = { var7.errorSubtext1, var7.errorSubtext2 },
        buttonLabel = var7.errorButton,
        isButtonInline = true,
        onActivated = 0,
        testId = 0
    }
    if var2 == "" or not var3 then
        var9 = nil
    end

    tbl2.onActivated = var9
    tbl2.testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-lobby-banner-mic-permissions" else nil
    return (createElement(func6, tbl2))
end

local function func6(tbl1)
    local var1 = useNavigation()
    local conversationId = useCurrentSquadParentChannelId() or ""
    local var3 = useIsCurrentSquadPartyVoiceEligible()
    local var4 = useIsLocalPlayerPartyVoiceEligible()
    if var3 ~= false then
        var4 = false
    end

    local var5 = useLocalization({
        errorText = "Feature.Squads.Label.VoiceErrorPartyNotVoiceEligible",
        errorButton = "Feature.Squads.Action.VoiceErrorPartyNotVoiceEligible"
    })

    local onActivated = React.useCallback(function()
        if conversationId == "" then
            return
        end

        pcall(function()
            var1.navigate("CreateUnfilteredChatPartialModal", { conversationId = conversationId })
        end)
    end, { conversationId, var1 })

    if not var4 then
        return nil
    end

    return React.createElement(func1, {
        LayoutOrder = tbl1.LayoutOrder,
        label = var5.errorText,
        buttonLabel = var5.errorButton,
        isButtonInline = false,
        onActivated = onActivated,
        testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-lobby-banner-party-voice-ineligible" else nil
    })
end

return function(tbl1)
    local var1 = useTokens()
    local var2 = React.useCallback(function(arg1)
        if arg1 then
            tbl1.onAbsoluteSizeChanged(arg1.AbsoluteSize)
        end
    end, { tbl1.onAbsoluteSizeChanged })

    return React.createElement("Frame", {
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.fromScale(1, 0),
        BackgroundTransparency = 1,
        [React.Change.AbsoluteSize] = var2
    }, {
        UIPadding = React.createElement(
            "UIPadding",
            {
                PaddingLeft = UDim.new(0, var1.Padding.XLarge),
                PaddingRight = UDim.new(0, var1.Padding.XLarge)
            }
        ),
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, var1.Gap.Medium)
        }),
        VoiceErrorBanner = if GetFFlagEnableCrossExpVoice() then React.createElement(func3, { LayoutOrder = 1 }) else nil,
        PartyVoiceEligibilityBanner = if GetFFlagEnableCrossExpVoice() and not bool2 then React.createElement(func6, { LayoutOrder = 2 }) else nil,
        PartyVoiceUserEligibilityBanner = if GetFFlagEnableCrossExpVoice() then React.createElement(func4, { LayoutOrder = 3 }) else nil,
        VoiceMicPermissionsBanner = if GetFFlagEnableCrossExpVoice() then React.createElement(func5, { LayoutOrder = 4 }) else nil,
        VoiceEuModalConnectBanner = if GetFFlagEnableCrossExpVoice() and FFlagEnableVoiceEuConsentPrompt then React.createElement(func2, { LayoutOrder = 5 }) else nil
    })
end
