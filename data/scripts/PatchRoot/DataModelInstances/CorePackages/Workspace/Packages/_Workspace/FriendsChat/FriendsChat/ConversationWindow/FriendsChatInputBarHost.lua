-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:01:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local FriendsChat = script:FindFirstAncestor("FriendsChat")
local FriendsChatParent = FriendsChat.Parent

local Foundation = require(FriendsChatParent.Foundation)
local React = require(FriendsChatParent.React)
local SignalsReact = require(FriendsChatParent.SignalsReact)
local useLocalization = require(FriendsChatParent.Localization).Hooks.useLocalization
local ChatUIPrimitives = require(FriendsChatParent.ChatUIPrimitives)
local InputTypeConstants = require(FriendsChatParent.InputType).InputTypeConstants

local ChatInputBoxDisabled = require(FriendsChatParent.AppChat.ChatInputBoxDisabled)
local _ConversationChannels = require(FriendsChatParent.AppChat.ConversationChannels)
local MessageCharacterLimit = require(FriendsChatParent.AppChat.MessageCharacterLimit)
local ChatConversationTelemetryLayer = require(FriendsChatParent.AppChat.ChatConversationTelemetryLayer)
local useChatTimeoutDetailsFromHydration = require(FriendsChatParent.AppChat.useChatTimeoutDetailsFromHydration)
local useTelemetry = require(FriendsChatParent.AppChat.useTelemetry)
local InterventionShared = require(FriendsChatParent.InterventionShared)
local chatInputBoxDisabledPressedSignal = InterventionShared.Signals.chatInputBoxDisabledPressedSignal
local interventionTreatmentShownSignal = InterventionShared.Signals.interventionTreatmentShownSignal
local Constants = InterventionShared.Utils.Constants

local FFlagFriendsChatEnforceInputCharacterLimit = require(FriendsChat.Flags.FFlagFriendsChatEnforceInputCharacterLimit)
local FFlagFriendsChatMessageComposer = require(FriendsChat.Flags.FFlagFriendsChatMessageComposer)
local FFlagAppChatReactiveFeatureRestrictions = require(FriendsChatParent.SharedFlags).FFlagAppChatReactiveFeatureRestrictions
local FFlagExpChatComposerFigmaParity = require(FriendsChatParent.SharedFlags).FFlagExpChatComposerFigmaParity
local FFlagAppChatUniversalFeatureRestriction = require(FriendsChatParent.SharedFlags).FFlagAppChatUniversalFeatureRestriction
local FFlagExpChatTabShortcutNav = require(FriendsChatParent.SharedFlags).FFlagExpChatTabShortcutNav

local ExpChatConversationListAdapter = require(script.Parent.Parent.ConversationList.ExpChatConversationListAdapter)
local GetFriendsChatNavigationStore = require(FriendsChat.Stores.GetFriendsChatNavigationStore)
local useConsumeFocusInputBarRequest = require(script.Parent.useConsumeFocusInputBarRequest)
local useFocusConversationInput = require(script.Parent.useFocusConversationInput)
local useFocusBackButtonOnUp = require(script.Parent.useFocusBackButtonOnUp)
local FFlagFriendsChatConversationListFocusNav = require(FriendsChatParent.SharedFlags).FFlagFriendsChatConversationListFocusNav
local getConversationInputPlaceholder = require(script.Parent.getConversationInputPlaceholder)
local resolveFade = require(script.Parent.Parent.Utils.resolveFade)
local useInExperienceLocalization = ChatUIPrimitives.Hooks.useInExperienceLocalization
local LayoutConstants = require(FriendsChat.LayoutConstants)
local sendFriendsChatMessage = require(script.Parent.sendFriendsChatMessage)
local useFriendsChatComposerViewModel = require(script.Parent.useFriendsChatComposerViewModel)

local ChatInputBarView = ChatUIPrimitives.ChatInputBarView
local MessageComposer = require(FriendsChatParent.ChatUIPrimitives.MessageComposer)
local useChatInputBarSettings = require(FriendsChatParent.ExpChatIntegration.useChatInputBarSettings)
local useChatInputBarOnFocus = require(FriendsChatParent.ExpChatIntegration.useChatInputBarOnFocus)
local useChatWindowSettings = require(FriendsChatParent.ExpChatIntegration.useChatWindowSettings)
local useInterpolatedClientSettings = require(FriendsChatParent.ExpChatIntegration.useInterpolatedClientSettings)

local autocomplete = { commands = nil, emojis = true }

local function FriendsChatInputBarHost(tbl2)
    local var1 = Foundation.Hooks.useTokens()
    local conversationId = tbl2.conversationId
    local isFriendPlaceholder = ExpChatConversationListAdapter.isFriendPlaceholder(conversationId)
    local hasRealConversation = not (conversationId == nil or conversationId == "") and not isFriendPlaceholder
    local var3 = useChatTimeoutDetailsFromHydration({
        conversationId = if hasRealConversation then conversationId else nil,
        conversationModerationType = tbl2.conversationModerationType
    })
    local var4 = SignalsReact.useSignalState(var3)
    local isTimedOut = var4.isTimedOut

    local var5 = useChatWindowSettings()

    local var6 = React.useMemo(function()
        return {
            BackgroundColor3 = var5.ChatWindowBackgroundColor3,
            BackgroundTransparency = var5.ChatWindowBackgroundTransparency
        }
    end, { var5 })

    local canLocalUserChat = not isTimedOut

    local var7 = useChatInputBarSettings()

    local textSize = React.useMemo(function()
        return if tbl2.isSpatialUIEnabled and var7 and var7.SpatialPanelTextSize then var7.SpatialPanelTextSize elseif var7 then var7.TextSize else nil
    end, { var7, tbl2.isSpatialUIEnabled })

    local var9 = useInExperienceLocalization()

    local var10 = ChatUIPrimitives.Hooks.useLastInputGroup()
    local isTouch = var10 == InputTypeConstants.Touch
    local isGamepad = var10 == InputTypeConstants.Gamepad
    local var11 = if var7 and var7.KeyboardKeyCode then var7.KeyboardKeyCode else Enum.KeyCode.Slash

    local placeholderText = React.useMemo(function()
        return getConversationInputPlaceholder({ isGamepad = isGamepad, isTouch = isTouch }, var11, var9, UserInputService)
    end, {
        isGamepad,
        isTouch,
        var11,
        var9
    })
    local disabledChatPlaceholderText = var9("CoreScripts.TextChat.InputBar.Hint.PrivacySettingsDisabled")
    local var14 = useLocalization({ timeoutDisabled = "Feature.Chat.Label.ChatDisabled" })

    local var15 = useTelemetry(ChatConversationTelemetryLayer.Context)
    local var16 = React.useRef(var15.emit)
    var16.current = var15.emit

    local var17 = useInterpolatedClientSettings(tbl2.chatWindowSettings or var6)

    local var18 = useChatInputBarOnFocus()
    local friendsChatNavigationStore = GetFriendsChatNavigationStore(false)

    local onFocusGained = React.useCallback(function()
        if not FFlagFriendsChatConversationListFocusNav then
            friendsChatNavigationStore.setInputBarFocused(true)
        end
        var18.onFocusGained()
    end, { var18.onFocusGained, friendsChatNavigationStore })
    local onFocusLost = React.useCallback(function()
        if not FFlagFriendsChatConversationListFocusNav then
            friendsChatNavigationStore.setInputBarFocused(false)
        end
        var18.onFocusLost()
    end, { var18.onFocusLost, friendsChatNavigationStore })

    local navigationTargetRef = if FFlagFriendsChatMessageComposer then React.useRef(nil) else nil
    local var22 = useFocusConversationInput(tbl2.rootRef, canLocalUserChat, navigationTargetRef)
    local ref = var22.ref
    useConsumeFocusInputBarRequest(var22.focus)
    if FFlagExpChatTabShortcutNav then
        ChatUIPrimitives.Hooks.useInputBarTabNavigation(ref)
    end
    if FFlagFriendsChatConversationListFocusNav then
        useFocusBackButtonOnUp(ref, tbl2.backButtonRef)
    end

    local selectionImageObject = if FFlagFriendsChatConversationListFocusNav then Foundation.Hooks.useCursor(Foundation.Enums.CursorType.RoundedRect) else nil

    local onShown = React.useCallback(function()
        local current = ref.current
        if current then
            current:ReleaseFocus()
        end
    end, {})

    React.useEffect(function()
        return function()
            onFocusLost()
        end
    end, { onFocusLost })

    React.useEffect(function()
        local connection = interventionTreatmentShownSignal:connect(function(arg1)
            if arg1 ~= Constants.TreatmentType.PartyChatNudgeDialog and arg1 ~= Constants.TreatmentType.PartyChatTimeoutDialog then
                return
            end
            local current = ref.current
            if current then
                current:ReleaseFocus()
            end
        end)

        return function()
            connection:disconnect()
        end
    end, {})

    local onSend = React.useCallback(function(str1: string)
        if isTimedOut then
            return
        end
        local text = if typeof(str1) ~= "string" then "" else str1
        if text == "" then
            return
        end

        sendFriendsChatMessage({
            text = text,
            conversationId = conversationId,
            isFriendPlaceholder = isFriendPlaceholder,
            hasRealConversation = hasRealConversation,
            emit = function(arg1, arg2)
                var16.current(arg1, arg2)
            end,
            onFriendPlaceholderConversationCreated = tbl2.onFriendPlaceholderConversationCreated
        })
    end, {
        conversationId,
        hasRealConversation,
        isFriendPlaceholder,
        isTimedOut,
        tbl2.onFriendPlaceholderConversationCreated
    })

    local onActivated = React.useCallback(function()
        if not FFlagAppChatUniversalFeatureRestriction then
            chatInputBoxDisabledPressedSignal:fire(
                {
                    endTimestamp = var4.timeoutEndTimestamp,
                    decisionEventId = var4.decisionEventId,
                    duration = var4.duration
                }
            )
            return
        end

        local abuseVector = require(FriendsChatParent.UniversalFeatureRestrictions.AbuseVector)
        local showFeatureRestriction = require(FriendsChatParent.UniversalFeatureRestrictions.showFeatureRestriction)
        local tbl3 = {
            onShown = onShown,
            onAppeal = function() end
        }
        if FFlagAppChatReactiveFeatureRestrictions then
            local partyChatTimeoutReceivedSignal = InterventionShared.Signals.partyChatTimeoutReceivedSignal
            function tbl3.onAcknowledgementSuccess()
                partyChatTimeoutReceivedSignal:fire(nil)
            end
        end
        showFeatureRestriction(abuseVector.PartyChat, tbl3)
    end, {
        onShown,
        var4.timeoutEndTimestamp,
        var4.decisionEventId,
        var4.duration
    })

    local contentSize = if FFlagFriendsChatMessageComposer then var1.Typography.BodyMedium.FontSize else textSize or var1.Typography.CaptionMedium.FontSize
    local yOffset = math.max(var1.Typography.CaptionMedium.LineHeight, contentSize)
    local element

    if isTimedOut then
        element = React.createElement(Foundation.View, {
            tag = "auto-y",
            Size = UDim2.fromScale(1, 0),
            padding = {
                top = UDim.new(0, contentSize / 2),
                bottom = UDim.new(0, contentSize / 2),
                left = UDim.new(0, var1.Padding.Large),
                right = UDim.new(0, var1.Padding.XSmall)
            }
        }, {
            TimeoutContent = React.createElement("CanvasGroup", {
                BackgroundTransparency = 1,
                GroupTransparency = tbl2.transparencyValue or 0,
                Size = UDim2.new(1, 0, 0, yOffset),
                ZIndex = 5
            }, {
                DisabledInput = React.createElement(ChatInputBoxDisabled, {
                    bodyText = var14.timeoutDisabled,
                    contentSize = contentSize,
                    endTimestamp = var4.timeoutEndTimestamp,
                    font = Enum.Font.BuilderSans,
                    onActivated = onActivated,
                    contentVerticalAlignment = Enum.VerticalAlignment.Center,
                    navigationTargetRef = navigationTargetRef
                })
            })
        })
    else
        element = nil
    end

    local element2

    if FFlagFriendsChatMessageComposer then
        local var28 = useFriendsChatComposerViewModel({
            canLocalUserChat = canLocalUserChat,
            timeoutOverlay = element,
            onSend = onSend,
            onFocusGained = onFocusGained,
            onFocusLost = onFocusLost,
            placeholderText = placeholderText,
            maximumCharacterLimit = if FFlagFriendsChatEnforceInputCharacterLimit then MessageCharacterLimit else nil,
            textBoxRef = ref,
            navigationTargetRef = navigationTargetRef,
            transparency = tbl2.transparencyValue
        })
        element2 = React.createElement(MessageComposer, var28)
    else
        element2 = nil
    end

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl3 = {
        Name = "friendsChatInput",
        LayoutOrder = tbl2.LayoutOrder,
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = var17.BackgroundColor3 or var5.ChatWindowBackgroundColor3,
        BackgroundTransparency = resolveFade(var17.BackgroundTransparency, tbl2.transparencyValue),
        Active = true,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Size = UDim2.fromScale(1, 0),
        [React.Event.MouseEnter] = tbl2.onHovered,
        [React.Event.MouseLeave] = tbl2.onUnhovered,
        ref = tbl2.rootRef
    }
    local tbl4 = {
        bottomCorner = React.createElement("UICorner", {
            BottomLeftRadius = UDim.new(0, LayoutConstants.PanelBottomCornerRadius),
            BottomRightRadius = UDim.new(0, LayoutConstants.PanelBottomCornerRadius),
            TopLeftRadius = UDim.new(0, 0),
            TopRightRadius = UDim.new(0, 0)
        }),
        padding = React.createElement("UIPadding", {
            PaddingTop = UDim.new(0, LayoutConstants.InputBarTopPadding),
            PaddingBottom = UDim.new(0, LayoutConstants.InputBarBottomPadding + LayoutConstants.PanelBottomCornerRadius),
            PaddingLeft = UDim.new(0, LayoutConstants.InputBarSidePadding),
            PaddingRight = UDim.new(0, LayoutConstants.InputBarSidePadding)
        }),
        inputBar = 0
    }
    if not FFlagFriendsChatMessageComposer then
        element2 = React.createElement(ChatInputBarView, {
            onSend = onSend,
            canLocalUserChat = canLocalUserChat or false,
            composerLayout = FFlagExpChatComposerFigmaParity,
            disabledOverlay = element,
            textSize = textSize,
            textBoxRef = ref,
            selectionImageObject = selectionImageObject,
            placeholderText = placeholderText,
            disabledChatPlaceholderText = disabledChatPlaceholderText,
            showSideChip = false,
            autocomplete = autocomplete,
            transparencyValue = tbl2.transparencyValue,
            onFocusGained = onFocusGained,
            onFocusLost = onFocusLost,
            maximumCharacterLimit = if FFlagFriendsChatEnforceInputCharacterLimit then MessageCharacterLimit else nil
        })
    end

    tbl4.inputBar = element2
    return createElement(str1, tbl3, tbl4)
end

return FriendsChatInputBarHost
