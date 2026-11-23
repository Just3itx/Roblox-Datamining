-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:30:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)
local _types = require(AppChat.types)
local Signal = require(AppChatParent.AppCommonLib).Signal
local DeviceType = require(AppChatParent.RobloxAppEnums).DeviceType

local Logger = require(script.Parent.Logger)
local EventNames = require(AppChat.Analytics.EventNames)

local AppChatNetworking = require(AppChatParent.AppChatNetworking)

local UIBlox = require(AppChatParent.UIBlox)
local Images = UIBlox.App.ImageSet.Images
local PeekView = require(AppChatParent.PeekView).PeekView
local PeekViewState = require(AppChatParent.PeekView).PeekViewState
local ContextualMenu = UIBlox.App.Menu.ContextualMenu
local MenuDirection = UIBlox.App.Menu.MenuDirection

local default = require(AppChatParent.ExternalContentSharingProtocol).ExternalContentSharingProtocol.default

local useStyle = UIBlox.Core.Style.useStyle
local useDeviceType = require(AppChatParent.RobloxAppHooks).useDeviceType
local useNavigation = require(AppChatParent.Navigation).useNavigation
local useLocalization = require(AppChatParent.Localization).Hooks.useLocalization
local GetReplyingToStore = require(AppChat.Stores.GetReplyingToStore)

local useReplyingToMessageDispatch = require(AppChat.Components.ChatConversation.MessageInteraction.ReplyingContext.useReplyingToMessageDispatch)
local FFlagAppChatSignalsReplyStore = require(AppChat.Flags.FFlagAppChatSignalsReplyStore)
local useLayerCollector = UIBlox.Core.Layout.LayerCollector.useLayerCollector
local useAnalytics = require(AppChat.Analytics.useAnalytics)

local useDispatch = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useDispatch

local getFFlagAppChatEnableManualTranslation = require(AppChat.Flags.getFFlagAppChatEnableManualTranslation)

local tbl1 = {
    message = nil,
    userOwnsMessage = false,
    inputBoxRef = React.createRef(),
    unitTestDeviceType = nil,
    unitTestScreenSize = nil
}

if tbl1.unitTestDeviceType ~= nil then
    Logger:error("Default unit test device type must ALWAYS BE NIL!")
    error("Default unit test device type was not nil.")
end

if tbl1.unitTestScreenSize ~= nil then
    Logger:error("Default unit test screen size must ALWAYS BE NIL!")
    error("Default unit test screen size was not nil.")
end

function MessageContextMenu(tbl2)
    local var1 = Cryo.Dictionary.union(tbl1, tbl2)
    local replyingToStore = if FFlagAppChatSignalsReplyStore then GetReplyingToStore(false) else nil
    local var2 = useReplyingToMessageDispatch()

    local tokens = useStyle().Tokens

    local var3 = React.useRef(Signal.new())

    local var4 = var1.unitTestScreenSize or useLayerCollector().absoluteSize
    local var5 = useNavigation()
    local var6 = var1.unitTestDeviceType or useDeviceType()
    local var7 = useAnalytics()

    local var8 = useLocalization({
        replyText = "Feature.Chat.Action.Reply",
        copyText = "Feature.Chat.Action.Copy",
        editText = "Feature.Chat.Action.Edit",
        deleteText = "Feature.Chat.Action.Delete",
        reportText = "Feature.Chat.Action.Report",
        translateText = "Feature.Chat.Action.Translate"
    })

    local var9 = React.useCallback(function(arg1)
        if not var7 then
            return
        end

        local fireAnalyticsEvent = var7.fireAnalyticsEvent
        local tbl3 = {
            conversationId = if var1.message then var1.message.conversationId else nil,
            targetMessageSenderId = if var1.message then var1.message.senderTargetId else nil,
            targetMessageId = if var1.message then var1.message.id else nil,
            targetMessageSentAt = if var1.message and var1.message.sent then tostring(var1.message.sent.dateTime) else nil,
            targetMessageLength = var1.message and var1.message.content and #var1.message.content or nil
        }
        fireAnalyticsEvent(arg1, tbl3)
    end, { var1.message })

    local var10 = React.useRef(false)

    local var11 = React.useCallback(function()
        if var1.inputBoxRef and var1.inputBoxRef.current then
            var1.inputBoxRef.current:CaptureFocus()
        end
    end, { var1.inputBoxRef })

    local var12 = React.useCallback(function()
        var5.goBack()
    end, { var5 and var5.goBack })

    local var13 = React.useCallback(function()
        var3.current:fire()
    end, { var3.current })

    local viewStateChanged = React.useCallback(function(closed, _)
        if closed == PeekViewState.Closed then
            var12()
        end
    end, { var12 })

    React.useEffect(function()
        var9(EventNames.ChatMessageMenuOpened)

        if var1.inputBoxRef and var1.inputBoxRef.current then
            var10.current = var1.inputBoxRef.current:IsFocused()
        end
    end, {})

    local var15 = React.useCallback(function()
        if var6 == DeviceType.Phone then
            var13()
            return
        end
        var12()
    end, { var6, var13, var12 })

    local onDismiss = React.useCallback(function()
        var15()
        if var10.current then
            var11()
        end
    end, { var15, var10.current, var11 })

    local useCallback = React.useCallback
    local function func1()
        var9(EventNames.ChatMessageMenuReplyBtnActivated)
        var15()

        if FFlagAppChatSignalsReplyStore and replyingToStore then
            replyingToStore.setReplyingTo(var1.message.id)
        else
            var2(var1.message)
        end

        var11()
    end

    local var17 = if FFlagAppChatSignalsReplyStore then replyingToStore else nil
    local onActivated = useCallback(func1, { var9, var15, var17, var2, var1.message, var11 })

    local var14 = React.useCallback(function()
        var9(EventNames.ChatMessageMenuCopyBtnActivated)
        var15()

        default:shareText({ text = var1.message.content, context = "AppChat-ChatConversation-MessageContextMenu" })
    end, { var9, var15, var1.message })

    local var16 = React.useCallback(function() end)

    local var18 = React.useCallback(function() end)

    local var22 = nil
    if getFFlagAppChatEnableManualTranslation() then
        local var23 = useDispatch()
        var22 = React.useCallback(function()
            var15()
            var23(AppChatNetworking.rodux.TranslateUserMessage.API(var1.message.conversationId, var1.message.id)):catch(function(arg1)
                Logger:error("Error translating message: ", arg1)
            end)
        end, { var1.message, var15, var23 })
    end

    local var19 = React.useCallback(function() end)

    local useMemo = React.useMemo
    local function func2()
        local tbl3 = {
            {
                icon = Images["icons/placeholder/placeholderOff"],
                text = var8.replyText,
                onActivated = onActivated
            },
            {
                icon = Images["icons/actions/edit/copy"],
                text = var8.copyText,
                onActivated = var14
            }
        }

        if var1.userOwnsMessage then
            table.insert(tbl3, { icon = Images["icons/actions/edit/edit"], text = var8.editText, onActivated = var16 })

            table.insert(tbl3, {
                icon = Images["icons/actions/edit/delete"],
                iconColorOverride = tokens.Color.System.Alert.Color3,
                text = var8.deleteText,
                textColorOverride = tokens.Color.System.Alert.Color3,
                onActivated = var18
            })
            return tbl3
        end

        if getFFlagAppChatEnableManualTranslation() then
            table.insert(tbl3, { icon = Images["icons/placeholder/placeholderOff"], text = "Translate", onActivated = var22 })
        end

        table.insert(tbl3, {
            icon = Images["icons/placeholder/placeholderOff"],
            iconColorOverride = tokens.Color.System.Alert.Color3,
            text = var8.reportText,
            textColorOverride = tokens.Color.System.Alert.Color3,
            onActivated = var19
        })

        return tbl3
    end

    local replyText = var8.replyText
    local copyText = var8.copyText
    local editText = var8.editText
    local deleteText = var8.deleteText
    local reportText = var8.reportText
    local translateText = var8.translateText
    local var24 = if getFFlagAppChatEnableManualTranslation() then var22 else nil
    local buttonProps = useMemo(func2, {
        replyText,
        copyText,
        editText,
        deleteText,
        reportText,
        translateText,
        onActivated,
        var14,
        var16,
        var18,
        var24,
        var19,
        var1.userOwnsMessage
    })

    local offset = #buttonProps * 56
    local var26, var27, var28, num1

    if var6 == DeviceType.Desktop or var6 == DeviceType.Tablet then
        var26 = Vector2.new(0.5, 0.5)
        var27 = UDim.new(0.5, 0)
        var28 = UDim.new(0.5, 0)
        num1 = 20
    else
        var4 = Vector2.new(0, 0)
        var26 = Vector2.new(0.5, 1)

        var27 = UDim.new(0, offset)
        var28 = UDim.new(1, 0)
        num1 = 0
    end

    local element = React.createElement(ContextualMenu, {
        screenSize = var4,
        menuDirection = MenuDirection.Up,
        openPositionY = var27,
        anchorPointOverride = var26,
        horizontalAlignment = Enum.HorizontalAlignment.Center,
        contextMenuWidthOverride = var28,
        borderCornerRadius = num1,
        buttonProps = buttonProps,
        isElementBackgroundVisible = true,
        isElementDividerVisible = true,
        open = true,
        onDismiss = onDismiss
    })

    local element2 = React.createElement(
        "ImageButton",
        {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            [React.Event.Activated] = onDismiss
        },
        {
            PeekView = React.createElement(PeekView, {
                briefViewContentHeight = UDim.new(0, offset),
                fullViewContentHeight = UDim.new(1, -offset),
                mountAsFullView = false,
                mountAnimation = true,
                showDraggerInClosedState = false,
                closeSignal = var3.current,
                viewStateChanged = viewStateChanged
            }, { element })
        }
    )

    return if var6 == DeviceType.Desktop or var6 == DeviceType.Tablet then element else element2
end

return React.memo(MessageContextMenu)
