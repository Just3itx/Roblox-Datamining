-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:01:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local ExpChatShared = require(ExpChatParent.ExpChatShared)
local Foundation = require(ExpChatParent.Foundation)
local React = require(ExpChatParent.React)
local UIBlox = require(ExpChatParent.UIBlox)

local Localization = require(ExpChat.Localization)

local Flags = ExpChat.Flags
local FFlagDebugMessageProfiling = require(Flags.FFlagDebugMessageProfiling)
local FFlagEnableInExpChatRewrite = require(Flags.FFlagEnableInExpChatRewrite)
local FFlagExpChatRewriteInline = require(Flags.FFlagExpChatRewriteInline)
local FFlagExpChatRewriteToggleAnalytics = require(Flags.FFlagExpChatRewriteToggleAnalytics)
local FStringInExpChatRewriteLabelKey = require(Flags.FStringInExpChatRewriteLabelKey)

local FIntExpChatWindowTransparencyRewriteInteractableThreshold = require(Flags.FIntExpChatWindowTransparencyRewriteInteractableThreshold)

local FFlagEnableInExpChatSummaryOnLuaForTranslatedMessageV2 = require(Flags.FFlagEnableInExpChatSummaryOnLuaForTranslatedMessageV2)
local FFlagExpChatPolishSummaryMessageUI = require(Flags.FFlagExpChatPolishSummaryMessageUI)
local FFlagExpChatPresetChatEnabled = ExpChatShared.Flags.FFlagExpChatPresetChatEnabled
local isChatWindowEnlargeEnabled = require(ExpChat.isChatWindowEnlargeEnabled)

local FFlagExpChatMessageEffectChatWindowEnlargePadding = require(Flags.FFlagExpChatMessageEffectChatWindowEnlargePadding)

local FFlagExpChatMessageEffectChatWindowEnlargeLineHeight = require(Flags.FFlagExpChatMessageEffectChatWindowEnlargeLineHeight)

local FIntExpChatMessageEffectChatWindowEnlargePaddingPixels = require(Flags.FIntExpChatMessageEffectChatWindowEnlargePaddingPixels)
local getPresetIconRichText = ExpChatShared.getPresetIconRichText
local TextChatMessageChatActionType = require(ExpChat.TextChatMessageChatActionType)
local summaryMessageRichText = require(ExpChat.summaryMessageRichText)

local RewriteToggle = require(script.Parent.RewriteToggle)

local GetMessagesStore = require(ExpChat.Stores.GetMessagesStore)
local GetRewriteDropdownStore = require(ExpChat.Stores.GetRewriteDropdownStore)

local MessageEffect = require(ExpChat.MessageEffects.MessageEffect)
local getMessageTextSize = require(ExpChatParent.ChatUIPrimitives).Utils.getMessageTextSize

local useFinishChatWindowMessageRenderIntervals = require(ExpChatParent.ChatUIPrimitives).Hooks.useFinishChatWindowMessageRenderIntervals
local applyChatWindowMessageEffects = require(ExpChat.MessageEffects.applyChatWindowMessageEffects)
local getChatWindowPrefixOffset = require(ExpChat.MessageEffects.getChatWindowPrefixOffset)
local getChatWindowMessageLineHeight = require(ExpChat.MessageEffects.getChatWindowMessageLineHeight)

local useCursor = UIBlox.App.SelectionCursor.useCursor

local Config = require(ExpChat.Config)

local Helpers = ExpChat.ChatWindow.Helpers
local duplicateInvisibleText = require(Helpers.duplicateInvisibleText)
local mergeBindableScalar = require(Helpers.mergeBindableScalar)

local function calculateTransparency(transparency: number, num1: number): number -- Luacid: Inlined by compiler; 2 call sites recovered
    return transparency + num1 * (1 - transparency)
end

local function appendVerifiedBadge(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return string.gsub(str1, ":(%S-)$", Config.VERIFIED_EMOJI .. ":%1")
end

local function trim(str1: string)
    if str1:match("^()%s*$") then
        return ""
    end

    return (str1:match("^%s*(.*%S)"))
end

local function getPropertyFromObjBinding(arg1, str1: string) -- Luacid: Inlined by compiler; 17 call sites recovered
    return arg1:map(function(arg2)
        return if arg2 then arg2[str1] else nil
    end)
end

local function appendTrustedIndicator(str1: string, trustedLabelText: string, num1: number, textSize: number, arg1)
    local var1 = arg1.Color.Shift.Shift_300.Color3:ToHex()
    local transparency = calculateTransparency(arg1.Color.Shift.Shift_300.Transparency, num1)

    local var2 = arg1.Color.Content.Emphasis.Color3:ToHex()
    local transparency2 = calculateTransparency(arg1.Color.Content.Emphasis.Transparency, num1)

    local num2 = textSize - 4

    local str2 = `{`{`{`{`<mark color='#{var1}' transparency='{transparency}'>`}<font transparency='1' weight='{600}' size='{num2}'><stroke transparency='1'>_`}<font color='#{var2}' transparency='{transparency2}'>{trustedLabelText}</font>`}_</stroke></font>`}</mark>`

    if string.find(str1, ":([%S:]-)$") then
        return string.gsub(str1, ":([%S:]-)$", ` {str2} :%1`)
    end
    return `{str1} {str2}`
end

return React.memo(function(tbl1) -- name: TranslatedTextMessage
    if FFlagDebugMessageProfiling then
        debug.profilebegin("TranslatedTextMessage")
    end

    local isSpatialUiEnabled = tbl1.isSpatialUIEnabled
    local messageTextSize = getMessageTextSize(tbl1.chatWindowSettings, isSpatialUiEnabled)

    local var1 = Localization.useLocalization({
        trustedLabelText = "CoreScripts.TextChat.ChatWindow.TrustedLabel",
        rewrittenLabelText = if FFlagExpChatRewriteInline and FFlagEnableInExpChatRewrite then FStringInExpChatRewriteLabelKey else nil,
        defaultRewrittenLabelText = if FFlagExpChatRewriteInline then if FFlagEnableInExpChatRewrite then "CoreScripts.TextChat.ChatWindow.RewrittenLabel" else nil else nil
    })

    local var2 = if FFlagExpChatRewriteInline and FFlagEnableInExpChatRewrite then if var1.rewrittenLabelText and var1.rewrittenLabelText ~= "" then var1.rewrittenLabelText else var1.defaultRewrittenLabelText else nil

    local var3 = Foundation.Hooks.useTokens()

    local var4 = React.useCallback(function()
        if tbl1.message and tbl1.message.current then
            return tbl1.message.current.messageId
        end

        return nil
    end, { tbl1.message })

    local var5 = useFinishChatWindowMessageRenderIntervals(var4)
    local var6 = React.useCallback(function(arg1)
        if arg1 and arg1.Text and arg1.Text ~= "" then
            var5()
        end
    end, { var5 })

    local var7 = React.useCallback(function()
        tbl1.onTextMessageLabelButtonActivated(tbl1.message.current)
    end, { tbl1.onTextMessageLabelButtonActivated })

    local var8 = React.useCallback(function()
        local current = tbl1.message.current
        GetMessagesStore(false).toggleMessageTranslation(not current.useTranslation, current.messageId)
    end, {})

    local onActivated = if FFlagEnableInExpChatRewrite then React.useCallback(function()
        local current = tbl1.message.current
        if not current or not current.messageId then
            return
        end

        local rewriteDropdownStore = GetRewriteDropdownStore(false)
        if FFlagExpChatRewriteToggleAnalytics then
            local bool1 = rewriteDropdownStore.getOpenMessageId(false) == current.messageId
            local wasRewritten = current.wasRewritten

            if wasRewritten then
                if current.originalText == nil then
                    wasRewritten = false
                else
                    wasRewritten = current.originalText ~= ""
                end
            end

            ExpChatShared.Analytics:TelemetryLogEvent(
                ExpChatShared.Analytics.RewriteDropdownToggledConfig,
                {
                    messageId = current.messageId,
                    isDropdownOpen = tostring(bool1),
                    showOriginalText = tostring(wasRewritten)
                },
                ExpChatShared.Analytics.DefaultStandardizedFields
            )
        end

        rewriteDropdownStore.toggleDropdown(current.messageId)
    end, { tbl1.message }) else nil

    local tbl2 = { tbl1.originalPrefixText, tbl1.isUserVerified }
    table.insert(tbl2, tbl1.isTrustedConnection)
    table.insert(tbl2, tbl1.textTransparency)
    table.insert(tbl2, tbl1.prefixTextProperties)

    local var10 = React.joinBindings(tbl2):map(function(arg1)
        local var10 = arg1[1]
        local var11 = arg1[2]

        if string.len(var10) > 0 then
            if var11 then
                var10 = appendVerifiedBadge(var10)
            end

            local var12 = arg1[3] or false
            local var13 = if arg1[4] == nil then 1 else arg1[4]
            local var14 = arg1[5]

            if var12 then
                var10 = appendTrustedIndicator(var10, var1.trustedLabelText, var13, var14.TextSize, var3)
            end
        end

        return var10
    end)

    local var11 = var10:map(trim)

    local textSize = tbl1.bodyTextProperties:map(function(arg1)
        return if isSpatialUiEnabled then messageTextSize else arg1.TextSize
    end)

    local tbl3 = {
        var10,
        tbl1.shouldShowTranslationToggle,
        tbl1.originalBodyText,
        tbl1.prefixTextProperties
    }

    if FFlagExpChatRewriteInline and FFlagEnableInExpChatRewrite then
        table.insert(tbl3, tbl1.wasRewritten)
        table.insert(tbl3, tbl1.isRewriteWindowOpen)
    end
    local var13 = nil
    if FFlagEnableInExpChatSummaryOnLuaForTranslatedMessageV2 then
        var13 = #tbl3 + 1
        table.insert(tbl3, tbl1.chatActionType)
    end
    local var14 = nil
    if FFlagExpChatPolishSummaryMessageUI or FFlagExpChatPresetChatEnabled then
        var14 = #tbl3 + 1
        table.insert(tbl3, textSize)
    end
    local var15 = nil
    if FFlagExpChatPresetChatEnabled and tbl1.isPresetMessage ~= nil then
        var15 = #tbl3 + 1
        table.insert(tbl3, tbl1.isPresetMessage)
    end
    local var16 = nil
    if isChatWindowEnlargeEnabled() and tbl1.effects ~= nil then
        var16 = #tbl3 + 1
        table.insert(tbl3, tbl1.effects)
    end

    local var17 = React.joinBindings(tbl3):map(function(arg1)
        local var17 = arg1[1]
        local var18 = arg1[2]
        local var19 = arg1[3]
        local var20 = arg1[4]

        if isChatWindowEnlargeEnabled() and var16 ~= nil then
            var19 = applyChatWindowMessageEffects(var19, arg1[var16])
        end
        if FFlagExpChatPresetChatEnabled and var15 ~= nil and arg1[var15] then
            var19 ..= ` {getPresetIconRichText(arg1[var14])}`
        end

        if FFlagEnableInExpChatSummaryOnLuaForTranslatedMessageV2 and arg1[var13] == TextChatMessageChatActionType.Summary then
            local var21 = if FFlagExpChatPolishSummaryMessageUI then arg1[var14] else nil
            var19 = summaryMessageRichText.wrapInSummaryMutedStyle(
                summaryMessageRichText.getSummaryIconPrefix(var21) .. " " .. var19,
                var3.Color.Content.Muted.Color3:ToHex(),
                var21
            )
        end

        if string.len(var17) > 0 then
            if var18 then
                var19 = "     " .. var19
            end

            var19 = duplicateInvisibleText(var17, var20.FontFace, var20.TextSize) .. " " .. var19
        end

        if FFlagExpChatRewriteInline and FFlagEnableInExpChatRewrite then
            local var21 = arg1[5]
            local var22 = arg1[6]
            if var21 then
                local var23 = if var22 then Foundation.Enums.IconName.ChevronLargeUp else Foundation.Enums.IconName.ChevronLargeDown
                var19 = `{var19} <font size='{var20.TextSize - 4}' color='#{var3.Color.Content.Muted.Color3:ToHex()}'>{`({var2})`}<font transparency='1'><stroke transparency='1'>_</stroke></font>{`<font weight='600' family='rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json'>{var23}</font>`}</font>`
            end
        end

        return var19
    end)

    local var18 = textSize:map(function(arg1): UDim2
        return UDim2.new(0, arg1 - 2, 0, arg1 - 2)
    end)
    local var19 = tbl1.originalPrefixText:map(function(arg1): boolean
        return string.len(arg1) > 0
    end)

    local propertyFromObjBinding = getPropertyFromObjBinding(tbl1.prefixTextProperties, "UIGradient")

    local var20 = if isChatWindowEnlargeEnabled() and tbl1.effects ~= nil then React.joinBindings({ tbl1.effects, tbl1.prefixTextProperties }):map(function(arg1): UDim2
        return UDim2.fromOffset(0, getChatWindowPrefixOffset(arg1[1], arg1[2].TextSize))
    end) else nil

    local lineHeight = if FFlagExpChatMessageEffectChatWindowEnlargeLineHeight and isChatWindowEnlargeEnabled() and tbl1.effects ~= nil then React.joinBindings({ tbl1.effects, textSize, tbl1.prefixTextProperties }):map(function(arg1)
        return getChatWindowMessageLineHeight(arg1[1], arg1[2], arg1[3].TextSize)
    end) else nil

    local var22 = nil
    local var23

    if FFlagEnableInExpChatRewrite then
        local wasRewritten = tbl1.wasRewritten

        var23 = wasRewritten:map(function(arg1)
            return arg1 and not FFlagExpChatRewriteInline
        end)

        if FFlagExpChatRewriteInline then
            local chatWindowTransparencyBindable = tbl1.chatWindowTransparencyBindable
            if chatWindowTransparencyBindable == nil then
                var22 = wasRewritten
            elseif typeof(chatWindowTransparencyBindable) == "number" then
                local bool1 = chatWindowTransparencyBindable < FIntExpChatWindowTransparencyRewriteInteractableThreshold
                var22 = wasRewritten:map(function(arg1)
                    return arg1 and bool1
                end)
            else
                var22 = React.joinBindings({ wasRewritten, chatWindowTransparencyBindable }):map(function(arg1)
                    return arg1[1] and arg1[2] < FIntExpChatWindowTransparencyRewriteInteractableThreshold
                end)
            end
        end
    else
        var23 = nil
    end

    local selectionImageObject = useCursor()

    local var25 = if FFlagExpChatMessageEffectChatWindowEnlargePadding and isChatWindowEnlargeEnabled() and tbl1.effects ~= nil then tbl1.effects:map(function(arg1): UDim
        return UDim.new(
            0,
            if arg1 and table.find(arg1, MessageEffect.ChatWindowEnlarge) then FIntExpChatMessageEffectChatWindowEnlargePaddingPixels else 0
        )
    end) else nil

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl4 = {
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.XY,
        Size = UDim2.new(1, 0, 0, 0),
        LayoutOrder = tbl1.layoutOrder,
        Visible = tbl1.visible
    }
    local tbl5 = {
        UIPadding = React.createElement("UIPadding", { PaddingRight = tbl1.arButtonPadding, PaddingTop = var25, PaddingBottom = var25 }),
        ColumnLayout = if FFlagEnableInExpChatRewrite and not FFlagExpChatRewriteInline then React.createElement(
            "UIListLayout",
            {
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder
            }
        ) else nil,
        TextMessage = 0,
        RewriteToggle = 0
    }

    local createElement2 = React.createElement
    local str2 = "Frame"
    local tbl6 = {
        AutomaticSize = Enum.AutomaticSize.XY,
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundTransparency = 1,
        LayoutOrder = if FFlagEnableInExpChatRewrite then 1 else nil
    }
    local tbl7 = {
        PrefixText = React.createElement("TextLabel", {
            AutomaticSize = Enum.AutomaticSize.XY,
            BackgroundTransparency = 1,
            FontFace = getPropertyFromObjBinding(tbl1.prefixTextProperties, "FontFace"),
            LineHeight = lineHeight,
            Position = var20,
            RichText = true,
            Text = var10,
            TextColor3 = getPropertyFromObjBinding(tbl1.prefixTextProperties, "TextColor3"),
            TextSize = getPropertyFromObjBinding(tbl1.prefixTextProperties, "TextSize"),
            TextStrokeColor3 = getPropertyFromObjBinding(tbl1.prefixTextProperties, "TextStrokeColor3"),
            TextStrokeTransparency = mergeBindableScalar(
                getPropertyFromObjBinding(tbl1.prefixTextProperties, "TextStrokeTransparency"),
                tbl1.textTransparency
            ),
            TextTransparency = mergeBindableScalar(0, tbl1.textTransparency),
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            Visible = var19
        }, {
            UIGradient = React.createElement("UIGradient", {
                Enabled = getPropertyFromObjBinding(propertyFromObjBinding, "Enabled"),
                Color = getPropertyFromObjBinding(propertyFromObjBinding, "Color"),
                Offset = getPropertyFromObjBinding(propertyFromObjBinding, "Offset"),
                Rotation = getPropertyFromObjBinding(propertyFromObjBinding, "Rotation"),
                Transparency = getPropertyFromObjBinding(propertyFromObjBinding, "Transparency")
            })
        }),
        BodyText = 0,
        TextMessageButton = 0
    }

    local createElement3 = React.createElement
    local var26 = FFlagExpChatRewriteInline and FFlagEnableInExpChatRewrite and "TextButton" or "TextLabel"
    local tbl8 = {
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundTransparency = 1,
        FontFace = getPropertyFromObjBinding(tbl1.bodyTextProperties, "FontFace"),
        LineHeight = lineHeight,
        RichText = true,
        Size = UDim2.new(1, 0, 0, 0),
        Text = var17,
        TextColor3 = getPropertyFromObjBinding(tbl1.bodyTextProperties, "TextColor3"),
        TextSize = textSize,
        TextStrokeColor3 = getPropertyFromObjBinding(tbl1.bodyTextProperties, "TextStrokeColor3"),
        TextStrokeTransparency = mergeBindableScalar(getPropertyFromObjBinding(tbl1.bodyTextProperties, "TextStrokeTransparency"), tbl1.textTransparency),
        TextTransparency = mergeBindableScalar(0, tbl1.textTransparency),
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        [React.Change.Text] = var6,
        [React.Event.Activated] = if FFlagExpChatRewriteInline then if FFlagEnableInExpChatRewrite then onActivated else nil else nil
    }

    if not (FFlagExpChatRewriteInline and FFlagEnableInExpChatRewrite) then
        var22 = nil
    end

    tbl8.Interactable = var22
    tbl7.BodyText = createElement3(var26, tbl8)

    local createElement4 = React.createElement
    local tbl9 = {
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.XY,
        Position = var20,
        Size = UDim2.new(1, 0, 0, 0),
        Visible = var19
    }
    local tbl10 = {
        Layout = React.createElement(
            "UIListLayout",
            {
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 4)
            }
        ),
        TextButton = React.createElement("TextButton", {
            AutomaticSize = Enum.AutomaticSize.XY,
            BackgroundTransparency = 1,
            FontFace = getPropertyFromObjBinding(tbl1.prefixTextProperties, "FontFace"),
            LineHeight = lineHeight,
            RichText = true,
            SelectionImageObject = selectionImageObject,
            Size = UDim2.new(0, 0, 0, 0),
            Text = var11,
            TextSize = getPropertyFromObjBinding(tbl1.prefixTextProperties, "TextSize"),
            TextStrokeTransparency = 1,
            TextTransparency = 1,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            LayoutOrder = 1,
            [React.Event.Activated] = var7
        }),
        TranslationButton = React.createElement("ImageButton", {
            BackgroundTransparency = 1,
            HoverImage = "rbxasset://textures/translateIconDark.png",
            Image = "rbxasset://textures/translateIcon.png",
            ImageTransparency = mergeBindableScalar(0, tbl1.textTransparency),
            LayoutOrder = 2,
            PressedImage = "rbxasset://textures/translateIconDark.png",
            SelectionImageObject = selectionImageObject,
            Size = var18,
            Visible = tbl1.shouldShowTranslationToggle,
            [React.Event.Activated] = var8
        })
    }
    tbl7.TextMessageButton = createElement4("Frame", tbl9, tbl10)
    tbl5.TextMessage = createElement2(str2, tbl6, tbl7)

    tbl5.RewriteToggle = if FFlagEnableInExpChatRewrite and not FFlagExpChatRewriteInline then React.createElement(
        RewriteToggle,
        {
            isRewriteMenuOpen = tbl1.isRewriteWindowOpen,
            textTransparency = tbl1.textTransparency,
            onActivated = onActivated,
            LayoutOrder = 2,
            Visible = var23
        }
    ) else nil
    local element = createElement(str1, tbl4, tbl5)

    if FFlagDebugMessageProfiling then
        debug.profileend()
    end
    return element
end)
