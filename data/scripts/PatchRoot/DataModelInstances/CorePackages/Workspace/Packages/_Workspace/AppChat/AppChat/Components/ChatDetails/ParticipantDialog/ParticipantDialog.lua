-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:00:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local _types = require(AppChat.types)

local Foundation = require(AppChatParent.Foundation)
local FocusNavigationUtils = require(AppChatParent.FocusNavigationUtils)
local InputHandlers = require(AppChatParent.InputHandlers)
local Logger = require(script.Parent.Logger)
local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)
local memo = React.memo
local useLayerCollector = require(AppChatParent.UIBlox).Core.Layout.LayerCollector.useLayerCollector
local useTelemetry = require(AppChat.Telemetry.useTelemetry)
local ChatDetailsTelemetryEvents = require(AppChat.Components.ChatDetails.ChatDetailsTelemetryEvents)
local ChatDialogTelemetryLayer = require(AppChat.Telemetry.Layers.ChatDialogTelemetryLayer)

local Menu = Foundation.Menu
local PopoverAlign = Foundation.Enums.PopoverAlign
local PopoverSide = Foundation.Enums.PopoverSide
local InputSize = Foundation.Enums.InputSize

local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local useAppFocusRoot = FocusNavigationUtils.useAppFocusRoot

local uDim = UDim.new(0, 400)

local tbl1 = {
    conversationId = nil,
    participantId = nil,
    anchorRef = nil,
    showRemoveUserButton = false,
    showViewProfileButton = true,
    showChatButton = false,
    showTrustedFriendButton = false,
    isWideMode = false,
    unitTestScreenSize = nil,
    viewProfileText = "localizedText.ViewProfile",
    chatText = "localizedText.Chat",
    reportUserText = "localizedText.ReportUser",
    removeFromGroupText = "localizedText.RemoveFromGroup",
    trustedFriendText = "localizedText.AddTrustedFriend",
    isTrustedFriendButtonDisabled = false,
    openViewProfile = function(_)
        Logger:warning("openViewProfile was not passed to ParticipantDialog")
    end,
    openChat = function(...)
        Logger:warning("openChat was not passed to ParticipantDialog")
    end,
    openReportUser = function(...)
        Logger:warning("openReportUser was not passed to ParticipantDialog")
    end,
    openRemoveUserDialog = function(...)
        Logger:warning("openRemoveUserDialog was not passed to ParticipantDialog")
    end,
    openTrustedFriend = function(...)
        Logger:warning("openTrustedFriend was not passed to ParticipantDialog")
    end,
    onDismiss = function(_)
        Logger:warning("onDismiss was not passed to ParticipantDialog")
    end
}

function ParticipantDialog(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)
    local var2 = useTelemetry(ChatDialogTelemetryLayer.Context)
    local var3 = React.useRef(nil)
    local var4 = useLayerCollector()
    local var5, var6 = React.useState(true)
    local conversationId = var1.conversationId
    local participantId = var1.participantId
    local showRemoveUserButton = var1.showRemoveUserButton
    local var7 = var1.unitTestScreenSize or var4.absoluteSize
    local anchorRef = if var1.anchorRef and var1.anchorRef.current then var1.anchorRef else nil
    local var8 = var1.onDismiss or function() end

    local function onPressedOutside() -- Luacid: Inlined by compiler; 1 call site recovered
        var6(false)
        var8()
    end

    local customEventHandlers = {
        [FocusNavigationEventNameEnum.NavigateBack] = {
            handler = InputHandlers.onRelease(function(arg1)
                arg1.cancelled = true
                onPressedOutside()
            end)
        }
    }

    local ref = useAppFocusRoot({
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.ContextualMenu,
        isFocusable = var5,
        customEventHandlers = customEventHandlers
    })

    local var10 = React.useRef(false)

    local items = {}
    local function onDisabledActivated() end

    local function insertAction(text: string?, callback: ((...any) -> (...any))?, isDisabled: boolean?) -- Luacid: Inlined by compiler; 5 call sites recovered
        table.insert(items, {
            text = text,
            isDisabled = isDisabled,
            onActivated = not isDisabled and function()
                if var10.current then
                    return
                end
                var10.current = true
                var6(false)
                if callback then
                    callback()
                end
            end or onDisabledActivated
        })
    end

    if var1.showViewProfileButton then
        insertAction(var1.viewProfileText, function()
            Logger:info("User activated viewProfile | userId: {}", participantId)
            var1.openViewProfile(participantId)
        end, nil)
    end

    if var1.showTrustedFriendButton then
        insertAction(var1.trustedFriendText, function()
            Logger:info("User activated openTrustedFriend | userId: {}", participantId)
            var1.openTrustedFriend(participantId)
        end, var1.isTrustedFriendButtonDisabled)
    end

    if var1.showChatButton then
        insertAction(var1.chatText, function()
            Logger:info("User activated openChat | userId: {}", participantId)
            var2.emit(ChatDetailsTelemetryEvents.ParticipantDialogChatClicked, {})
            var1.openChat(participantId)
        end, nil)
    end

    insertAction(var1.reportUserText, function()
        Logger:info("User activated reportUser | userId: {}, conversationId: {}", participantId, conversationId)
        var2.emit(ChatDetailsTelemetryEvents.ParticipantDialogReportUserClicked, {})
        var1.openReportUser(participantId, conversationId)
    end, nil)

    if showRemoveUserButton then
        insertAction(var1.removeFromGroupText, function()
            var1.openRemoveUserDialog(participantId, conversationId)
        end, nil)
    end

    if anchorRef then
        local absolutePosition = anchorRef.current.AbsolutePosition
        local absoluteSize = anchorRef.current.AbsoluteSize
        local side = if absolutePosition.Y + absoluteSize.Y / 2 > var7.Y / 2 then PopoverSide.Top else PopoverSide.Bottom
        return (React.createElement(Menu, {
            align = PopoverAlign.End,
            anchorRef = anchorRef,
            isOpen = var5,
            items = items,
            onPressedOutside = onPressedOutside,
            ref = ref,
            side = side,
            size = InputSize.Medium,
            width = if var1.isWideMode then uDim else nil
        }))
    end

    local createElement = React.createElement
    local view = Foundation.View
    local tbl5 = {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1
    }
    local tbl6 = {
        MenuAnchor = React.createElement("Frame", {
            AnchorPoint = Vector2.new(0.5, 1),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Position = UDim2.new(0.5, 0, 1, -10),
            Size = UDim2.fromOffset(400, 1),
            ref = var3
        }),
        Menu = React.createElement(Menu, {
            align = PopoverAlign.Center,
            anchorRef = var3,
            isOpen = var5,
            items = items,
            onPressedOutside = onPressedOutside,
            ref = ref,
            side = PopoverSide.Top,
            size = InputSize.Medium,
            width = if var1.isWideMode then uDim else nil
        })
    }
    return createElement(view, tbl5, tbl6)
end

return memo(ParticipantDialog)
