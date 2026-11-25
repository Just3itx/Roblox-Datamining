-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:01:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local scriptParentParent = script.Parent.Parent
local React = require(scriptParentParent.React)
local Foundation = require(scriptParentParent.Foundation)
local ChatUIPrimitives = require(scriptParentParent.ChatUIPrimitives)
local ExpressionCatalogResource = require(scriptParentParent.ChatUIPrimitives.ExpressionCatalogResource)
local useLastInputMode = require(scriptParentParent.FocusNavigationUtils).useLastInputMode
local TextChannelWindowAnalytics = require(script.Parent.TextChannelWindowAnalytics)
local useInExperienceLocalization = require(scriptParentParent.ChatUIPrimitives).Hooks.useInExperienceLocalization
local Logger = require(script.Parent.Logger)
local Message = require(script.Parent.Message)
local MessageWriterContext = require(script.Parent.MessageWriterContext)
local runVirtualChatCommands = require(script.Parent.runVirtualChatCommands)
local useCanSendToChannel = require(script.Parent.useCanSendToChannel).useCanSendToChannel
local getFFlagExpChatProtectedChatInternalAPIs = require(scriptParentParent.SharedFlags).getFFlagExpChatProtectedChatInternalAPIs
local sendTextToChannel = require(script.Parent.sendTextToChannel)
local getFFlagExpChatUseChatMuteStore = require(script.Parent.getFFlagExpChatUseChatMuteStore)

local FFlagExpChatTextChannelWindowThemeByBackground = require(script.Parent.Flags.FFlagExpChatTextChannelWindowThemeByBackground)
local FFlagExpChatComposerFigmaParity = require(scriptParentParent.SharedFlags).FFlagExpChatComposerFigmaParity

local FFlagExpChatTextChannelWindowExpressionTray = require(script.Parent.Flags.FFlagExpChatTextChannelWindowExpressionTray)

local FFlagExpChatTextChannelWindowExpressionTrayEmoji = require(script.Parent.Flags.FFlagExpChatTextChannelWindowExpressionTrayEmoji)
local FFlagExpChatTextChannelWindowFocusNav = require(script.Parent.Flags.FFlagExpChatTextChannelWindowFocusNav)

local FFlagDebugExpChatTextChannelWindowStaticExpressions = require(script.Parent.Flags.FFlagDebugExpChatTextChannelWindowStaticExpressions)

local FFlagExpChatTextChannelWindowMessageComposer = require(script.Parent.Flags.FFlagExpChatTextChannelWindowMessageComposer)

local FFlagExpChatTCWRestoreSendSelectionGatedByInputMode = require(script.Parent.Flags.FFlagExpChatTCWRestoreSendSelectionGatedByInputMode)

local FFlagExpChatTextChannelWindowQuickWordsNonDirect = require(script.Parent.Flags.FFlagExpChatTextChannelWindowQuickWordsNonDirect)
local isDirectChatChannel = require(script.Parent.isDirectChatChannel)
local getDebugExpressionCatalog = require(script.Parent.TextChannelWindowExpressionTray.getDebugExpressionCatalog)
local sendExpression = require(script.Parent.TextChannelWindowExpressionTray.sendExpression)
local useTextChannelWindowComposerViewModel = require(script.Parent.useTextChannelWindowComposerViewModel)
local catalogResource = if FFlagDebugExpChatTextChannelWindowStaticExpressions then ExpressionCatalogResource.createStatic(getDebugExpressionCatalog()) else nil
local ChatInputBarView = ChatUIPrimitives.ChatInputBarView
local MessageComposer = require(scriptParentParent.ChatUIPrimitives.MessageComposer)
local useFocusInputBar = ChatUIPrimitives.Hooks.useFocusInputBar

return React.memo(function(tbl1) -- name: TextChatWindowInputBarHost
    local targetChannel = tbl1.targetChannel
    local var1 = Foundation.Hooks.useTokens()
    local var2 = tbl1.guiService or GuiService
    local focusNavEnabled = tbl1.focusNavEnabled
    local textBoxRef = tbl1.textBoxRef

    local var3 = useLastInputMode()

    local var4 = useCanSendToChannel(tbl1.targetChannel, tbl1.localUserId)

    local var5 = useInExperienceLocalization()
    local var6 = React.useMemo(function()
        return {
            placeholder = var5("CoreScripts.TextChat.InputBar.Hint.Touch"),
            disabled = var5("CoreScripts.TextChat.InputBar.Hint.PrivacySettingsDisabled"),
            chatUnavailable = var5("CoreScripts.TextChat.InputBar.Hint.ChatUnavailable"),
            readOnly = var5("CoreScripts.TextChat.Error.ReadOnlyChannel"),
            presetDisclaimer = var5("Feature.Chat.PresetChat.Disclaimer")
        }
    end, { var5 })

    local var7 = MessageWriterContext.useMessageWriter()
    local targetChannelName = if targetChannel then targetChannel.Name else nil

    local onSend = React.useCallback(function(str1: string)
        if not var4 then
            return
        end
        if not targetChannel or str1 == "" then
            return
        end

        if focusNavEnabled and (not FFlagExpChatTCWRestoreSendSelectionGatedByInputMode or var3 == "Focus") then
            local current = if textBoxRef then textBoxRef.current else nil

            if current then
                var2.SelectedCoreObject = current
            end
        end
        if getFFlagExpChatUseChatMuteStore() and tbl1.localUserId then
            local var8 = runVirtualChatCommands(str1, tbl1.localUserId)
            if var8 then
                if var7 then
                    var7.write(Message.createSystemMessage(var5(var8.key, if next(var8.args) then var8.args else nil)))
                end

                return
            end
        end
        if FFlagExpChatTextChannelWindowExpressionTrayEmoji then
            task.spawn(sendTextToChannel, targetChannel, str1)
            return
        end
        task.spawn(function()
            local success, result = pcall(function()
                if getFFlagExpChatProtectedChatInternalAPIs() then
                    targetChannel:SendInternalAsync(str1)
                    return
                end
                targetChannel:SendAsync(str1)
            end)

            if success then
                TextChannelWindowAnalytics.emit(TextChannelWindowAnalytics.Counters.Send, {
                    result = "success",
                    has_target = targetChannelName ~= nil,
                    target_text_channel_category = TextChannelWindowAnalytics.getChannelCategory(targetChannelName)
                })
                return
            end

            Logger:warning("SendAsync failed: {}", result)
            TextChannelWindowAnalytics.emit(TextChannelWindowAnalytics.Counters.Send, {
                result = "failure",
                has_target = targetChannelName ~= nil,
                target_text_channel_category = TextChannelWindowAnalytics.getChannelCategory(targetChannelName)
            })
        end)
    end, {
        targetChannel,
        var4,
        var5,
        tbl1.localUserId,
        var7,
        targetChannelName,
        focusNavEnabled,
        var3,
        textBoxRef,
        var2
    })

    local var9 = tbl1.canLocalUserChat == nil or tbl1.canLocalUserChat
    local var10 = var9 and not (targetChannel == nil) and var4
    local disabledChatPlaceholderText = if targetChannel == nil then var6.chatUnavailable elseif var4 then var6.disabled else var6.readOnly

    local autocomplete = React.useMemo(function()
        return { commands = nil, emojis = true }
    end, {})

    local var13 = useFocusInputBar(tbl1.textBoxRef)
    local var8 = React.useCallback(function(arg1)
        return sendExpression(arg1, targetChannel, var9)
    end, { targetChannel, var9 })

    local var15 = FFlagExpChatTextChannelWindowQuickWordsNonDirect and not FFlagExpChatTextChannelWindowExpressionTrayEmoji

    if var15 then
        if targetChannel == nil then
            var15 = false
        else
            var15 = isDirectChatChannel(targetChannel)
        end
    end

    local tbl2 = if FFlagExpChatTextChannelWindowExpressionTray and FFlagExpChatComposerFigmaParity then {
        sendExpression = var8,
        canLocalUserChat = var9,
        canSend = var4 and not (targetChannel == nil) and not var15,
        onKeyboardActivated = var13.focus,
        footerText = var6.presetDisclaimer,
        focusNavEnabled = focusNavEnabled == true and FFlagExpChatTextChannelWindowFocusNav,
        onOpenChanged = if FFlagExpChatTextChannelWindowFocusNav then tbl1.onExpressionTrayOpenChanged else nil,
        catalogResource = catalogResource
    } else nil
    local expressionTray = tbl2
        and {
            catalogResource = tbl2.catalogResource,
            onKeyboardActivated = tbl2.onKeyboardActivated,
            canSend = tbl2.canSend,
            onOpenChanged = tbl2.onOpenChanged
        }
        or nil
    local element

    if disabledChatPlaceholderText and disabledChatPlaceholderText ~= "" then
        element = React.createElement(Foundation.View, {
            tag = "size-full-0 auto-y",
            padding = {
                left = UDim.new(0, 16),
                right = UDim.new(0, 4),
                top = UDim.new(0, 10),
                bottom = UDim.new(0, 10)
            }
        }, {
            Text = React.createElement(Foundation.Text, {
                testId = "--social-exp-chat-text-input-disabled",
                tag = "size-full-0 auto-y text-body-medium text-align-x-left text-truncate-end content-muted",
                Text = disabledChatPlaceholderText
            })
        })
    else
        element = nil
    end

    if FFlagExpChatTextChannelWindowMessageComposer then
        local var17 = useTextChannelWindowComposerViewModel({
            canChat = var10,
            canChatFreely = var9,
            targetChannel = targetChannel,
            disabledOverlay = element,
            onSend = onSend,
            expressionTray = expressionTray,
            windowName = tbl1.windowName,
            placeholderText = var6.placeholder,
            textBoxRef = var13.ref,
            fontFace = tbl1.fontFace
        })
        return React.createElement(MessageComposer, var17)
    end

    return React.createElement(ChatInputBarView, {
        onSend = onSend,
        canLocalUserChat = var10,
        textSize = var1.Typography.CaptionMedium.FontSize,
        fontFace = tbl1.fontFace,
        placeholderText = var6.placeholder,
        disabledChatPlaceholderText = disabledChatPlaceholderText,
        autocomplete = autocomplete,
        maximumCharacterLimit = 200,
        themedColors = FFlagExpChatTextChannelWindowThemeByBackground,
        textBoxRef = var13.ref,
        expressionTray = tbl2,
        composerLayout = FFlagExpChatComposerFigmaParity,
        selectionImageObject = if focusNavEnabled then tbl1.selectionCursor else nil
    })
end)
