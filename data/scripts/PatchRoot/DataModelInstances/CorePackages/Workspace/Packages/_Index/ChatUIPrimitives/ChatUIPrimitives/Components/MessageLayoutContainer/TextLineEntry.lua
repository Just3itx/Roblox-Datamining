-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:10:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
local ChatUIPrimitivesParent = ChatUIPrimitives.Parent

local React = require(ChatUIPrimitivesParent.React)
local Signals = require(ChatUIPrimitivesParent.Signals)
local SignalsReact = require(ChatUIPrimitivesParent.SignalsReact)
local Foundation = require(ChatUIPrimitivesParent.Foundation)

local _Types = require(ChatUIPrimitives.Types)
local useStableSignal = require(ChatUIPrimitives.Hooks.useStableSignal)
local formatInlineIcon = require(ChatUIPrimitives.Utils.formatInlineIcon)
local resolveDisplayText = require(ChatUIPrimitives.Translation.resolveDisplayText)
local useTranslateToggle = require(ChatUIPrimitives.Translation.useTranslateToggle)
local TextChannelWindowPerfTracker = require(ChatUIPrimitives.Telemetry.TextChannelWindowPerfTracker)
local RewriteToggle = require(script.Parent.RewriteToggle)
local TranslateHitOverlay = require(script.Parent.TranslateHitOverlay)
local FFlagTCWTranslationSupport = require(ChatUIPrimitives.Flags.FFlagTCWTranslationSupport)
local FFlagExpChatLazyMountRewriteToggle = require(ChatUIPrimitives.Flags.FFlagExpChatLazyMountRewriteToggle)
local FFlagExpChatLatestUsernameWithoutRender = require(ChatUIPrimitives.Flags.FFlagExpChatLatestUsernameWithoutRender)
local useLatestUsername = require(script.Parent.useLatestUsername)
local SelectableUsername = require(script.Parent.SelectableUsername)

local IconName = Foundation.Enums.IconName
local useSignalBinding = SignalsReact.useSignalBinding

local signal = Signals.createSignal(nil)

local function noop() end

local tbl1 = {
    affordance = Foundation.Enums.StateLayerAffordance.None
}
local function ceilToEven(num1: number): number -- Luacid: Inlined by compiler; 4 call sites recovered
    local num2 = math.ceil(num1)
    if num2 % 2 == 1 then
        num2 += 1
    end
    return math.max(0, num2)
end

local function builderIconSize(num1: number): string -- Luacid: Inlined by compiler; 3 call sites recovered
    return tostring((ceilToEven(num1 * 3 / 4)))
end

local function getPresetBoltIconAttributes(num1: number) -- Luacid: unused: defined but never referenced
    return {
        weight = "700",
        size = builderIconSize(num1)
    }
end
return React.memo(function(tbl2) -- name: TextLineEntry
    local var1 = Foundation.Hooks.useTokens()

    local var2 = React.useMemo(function()
        local color3 = var1.DarkMode.Content.Muted.Color3
        return string.format(
            "<font color=\"rgb(%d,%d,%d)\">",
            math.round(color3.R * 255),
            math.round(color3.G * 255),
            math.round(color3.B * 255)
        )
    end, { var1 })

    local var3 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            local messageId = tbl2.getMessageId(arg1)

            if messageId then
                return tbl2.getMessagesMap(arg1)[messageId]
            end

            return nil
        end)
    end, { tbl2.getMessageId, tbl2.getMessagesMap })

    local var4, var5 = useStableSignal(false)

    local var6 = SignalsReact.useSignalState(tbl2.getMessageId)
    React.useEffect(function()
        var5(false)
    end, { var6, var5 })
    React.useEffect(function()
        if var6 then
            TextChannelWindowPerfTracker.finishMessageIntervals(var6)
        end
    end, { var6 })

    local messageBinding = useSignalBinding(var3)
    local layoutOrder = useSignalBinding(tbl2.getLayoutOrder)
    local showOriginal = SignalsReact.useSignalState(var4)

    local var10 = SignalsReact.useSignalState(var3)

    local var11 = React.useRef(nil)
    local buttonRef = if FFlagExpChatLatestUsernameWithoutRender then useLatestUsername(tbl2.getMessageId, tbl2.getLatestMessageId, tbl2.reportLatestUsername) else var11
    local var13 = SignalsReact.useSignalState(
        if FFlagExpChatLatestUsernameWithoutRender then signal else tbl2.getLatestMessageId or signal
    )
    local bool1 = not (var6 == nil) and var6 == var13
    local reportLatestUsername = tbl2.reportLatestUsername
    React.useEffect(function()
        if FFlagExpChatLatestUsernameWithoutRender then
            return
        end
        if reportLatestUsername ~= nil and bool1 then
            reportLatestUsername(var11.current)
            return function()
                reportLatestUsername(nil)
            end
        end
    end, { bool1, reportLatestUsername })

    local var14 = if FFlagTCWTranslationSupport then useTranslateToggle(var10, var6, tbl2.isTranslationSettingEnabled == true) else nil
    local isOffered = not (var14 == nil) and var14.isOffered
    local shouldShowTranslation = not (var14 == nil) and var14.shouldShowTranslation

    local var15 = React.useMemo(function()
        if var10 and var10.presetId and var10.presetId ~= "" then
            return formatInlineIcon(IconName.LightningBolt, { weight = "700", size = builderIconSize(var1.Typography.BodyLarge.FontSize) })
        end

        return ""
    end, { var10, var1 })

    local var16 = React.useMemo(function()
        if var10 and var10.iconName and var10.iconName ~= "" then
            return formatInlineIcon(var10.iconName, { weight = "600", size = builderIconSize(var1.Typography.BodyLarge.FontSize) })
        end

        return ""
    end, { var10, var1 })

    local var17 = React.useMemo(function()
        if not var10 then
            return ""
        end

        local var17 = if FFlagTCWTranslationSupport then resolveDisplayText(var10, isOffered and shouldShowTranslation) else var10.content
        local prefixText = var10.prefixText or ""
        if var10.messageType == "user" then
            local str1 = if isOffered then "     " else ""
            local var18 = var15
            if var18 ~= "" then
                return `{prefixText} {str1}{var17} {var18}`
            end
            return `{prefixText} {str1}{var17}`
        elseif var10.messageType == "system-roblox" then
            return var17
        end

        if var16 == "" then
            return var2 .. var17 .. "</font>"
        end

        return var2 .. var16 .. " " .. var17 .. "</font>"
    end, {
        var10,
        var15,
        var16,
        var2,
        shouldShowTranslation,
        isOffered
    })
    local selectable = var10 ~= nil

    local onToggle = React.useCallback(function()
        var5(not var4())
    end, { var4, var5 })

    local fontStyle = React.useMemo(function(): {Font: any}?
        return if tbl2.fontFace then {
            Font = tbl2.fontFace
        } else nil
    end, { tbl2.fontFace or false })

    local prefixText = var10 and var10.prefixText or ""
    local bool3 = tbl2.selectableRows == true and var10 ~= nil and var10.messageType == "user" and prefixText ~= ""
    local bool4 = tbl2.selectableRows == true and not bool3
    local fontFace = tbl2.fontFace
    if fontFace == nil then
        local font = var1.Typography.BodyLarge.Font
        if typeof(font) == "Font" then
            fontFace = font
        elseif typeof(font) == "EnumItem" then
            fontFace = Font.fromEnum(font)
        end
    end

    local label = React.createElement(Foundation.Text, {
        tag = "size-full-0 auto-y text-body-large text-wrap text-align-x-left text-align-y-top content-emphasis",
        Text = var17,
        RichText = true,
        fontStyle = fontStyle,
        LayoutOrder = 1
    })

    local tbl3 = {
        rewriteToggle = React.createElement(
            RewriteToggle,
            {
                messageBinding = messageBinding,
                showOriginal = showOriginal,
                onToggle = onToggle,
                LayoutOrder = 2
            }
        )
    }

    if FFlagExpChatLazyMountRewriteToggle and (var10 == nil or var10.wasRewritten ~= true) then
        tbl3.rewriteToggle = nil
        tbl3.rewriteToggleSpacer = React.createElement("Frame", { BackgroundTransparency = 1, Size = UDim2.fromScale(0, 0), LayoutOrder = 2 })
    end

    local var20 = isOffered and var14 ~= nil
    if bool3 or var20 then
        tbl3.messageRow = React.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                LayoutOrder = 1
            },
            {
                label = label,
                usernameSelection = if bool3 then React.createElement(SelectableUsername, {
                    prefixText = prefixText,
                    fontFace = fontFace,
                    textSize = var1.Typography.BodyLarge.FontSize,
                    selectionCursor = tbl2.selectionCursor,
                    buttonRef = buttonRef
                }) else nil,
                translateHit = if var20 then React.createElement(TranslateHitOverlay, {
                    prefixText = prefixText,
                    fontFace = fontFace,
                    textSize = var1.Typography.BodyLarge.FontSize,
                    onActivated = var14.onToggle
                }) else nil
            }
        )
    else
        tbl3.label = label
    end

    return React.createElement(Foundation.View, {
        tag = "col gap-xsmall size-full-0 auto-y",
        backgroundStyle = {
            Color3 = Color3.new(0, 0, 0),
            Transparency = 1
        },
        LayoutOrder = layoutOrder,
        Visible = selectable,
        onActivated = if bool4 then noop else nil,
        stateLayer = if bool4 then tbl1 else nil,
        selection = bool4 and {
            Selectable = selectable,
            SelectionImageObject = tbl2.selectionCursor
        } or nil
    }, tbl3)
end)
