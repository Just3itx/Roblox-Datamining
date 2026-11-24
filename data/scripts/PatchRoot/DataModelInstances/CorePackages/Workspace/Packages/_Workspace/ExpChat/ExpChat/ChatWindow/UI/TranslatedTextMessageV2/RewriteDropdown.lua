-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:01:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local React = require(ExpChatParent.React)
local Foundation = require(ExpChatParent.Foundation)
local Signals = require(ExpChatParent.Signals)
local useSignalBinding = require(ExpChatParent.SignalsReact).useSignalBinding
local GetRewriteDropdownStore = require(ExpChat.Stores.GetRewriteDropdownStore)
local GetMessagesStore = require(ExpChat.Stores.GetMessagesStore)

local Localization = require(ExpChat.Localization)

local Flags = ExpChat.Flags
local FStringInExpChatRewriteReasonKey = require(Flags.FStringInExpChatRewriteReasonKey)

local mergeBindableScalar = require(ExpChat.ChatWindow.Helpers.mergeBindableScalar)

return React.memo(function(tbl1) -- name: RewriteDropdown
    local var1 = Foundation.Hooks.useTokens()

    local var2 = Localization.useLocalization({
        rewrittenReasonLabelText = FStringInExpChatRewriteReasonKey,
        defaultRewrittenReasonLabelText = "CoreScripts.TextChat.ChatWindows.RewrittenReasonLabel"
    })
    local var3 = if var2.rewrittenReasonLabelText and var2.rewrittenReasonLabelText ~= "" then var2.rewrittenReasonLabelText else var2.defaultRewrittenReasonLabelText
    local messagesStore = GetMessagesStore(false)
    local rewriteDropdownStore = GetRewriteDropdownStore(false)

    local var4 = React.useMemo(function()
        local computed = Signals.createComputed(function(arg1)
            local componentId = rewriteDropdownStore.getComponentId(arg1)
            if not componentId then
                return nil
            end
            local openMessageId = rewriteDropdownStore.getOpenMessageId(arg1)
            if not openMessageId then
                return nil
            end

            local messageComponentSignal = messagesStore.getMessageComponentSignal(componentId)
            if not messageComponentSignal then
                return nil
            end
            local var4 = messageComponentSignal(arg1)
            if not var4 then
                return nil
            end
            local var5 = messagesStore.getMessage(var4)(arg1)
            return if var5 then if var4 == openMessageId then var5 else nil else nil
        end)

        return {
            getVisible = Signals.createComputed(function(arg1)
                local var4 = computed(arg1)
                return if var4 then var4.wasRewritten else false
            end),
            getLayoutOrder = Signals.createComputed(function(arg1)
                local componentId = rewriteDropdownStore.getComponentId(arg1)
                if not componentId then
                    return 0
                end
                local layoutOrderSignal = messagesStore.getLayoutOrderSignal(componentId)
                return if layoutOrderSignal then layoutOrderSignal(arg1) + 1 else 0
            end),
            getOriginalText = Signals.createComputed(function(arg1)
                local var4 = computed(arg1)
                return if var4 then var4.originalText or "" else ""
            end)
        }
    end, {})

    local var5 = useSignalBinding(var4.getVisible)
    local layoutOrder = useSignalBinding(var4.getLayoutOrder)
    local var7 = useSignalBinding(var4.getOriginalText)
    local var8 = var7:map(function(arg1): boolean
        return not (arg1 == nil) and arg1 ~= ""
    end)

    return React.createElement("Frame", {
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.XY,
        Size = UDim2.new(1, 0, 0, 0),
        LayoutOrder = layoutOrder,
        Visible = var5
    }, {
        UIPadding = React.createElement("UIPadding", {
            PaddingTop = UDim.new(0, var1.Padding.XXSmall),
            PaddingBottom = UDim.new(0, var1.Padding.XXSmall),
            PaddingRight = tbl1.arButtonPadding
        }),
        React.createElement(Foundation.View, {
            tag = "col align-x-left gap-xxsmall padding-small radius-medium size-full-0 auto-y",
            backgroundStyle = {
                Color3 = var1.Color.Common.Scrim.Color3,
                Transparency = mergeBindableScalar(0.7, tbl1.textTransparency)
            }
        }, {
            OriginalText = React.createElement(Foundation.Text, {
                Text = var7,
                tag = "text-body-small text-align-x-left text-wrap size-full-0 auto-y",
                LayoutOrder = 1,
                RichText = true,
                Visible = var8,
                textStyle = {
                    Color3 = var1.Color.Content.Muted.Color3,
                    Transparency = mergeBindableScalar(var1.Color.Content.Muted.Transparency, tbl1.textTransparency)
                },
                stroke = {
                    Color = Color3.fromRGB(0, 0, 0),
                    Transparency = mergeBindableScalar(0.5, tbl1.textTransparency),
                    Thickness = var1.Stroke.Thin
                }
            }),
            Divider = React.createElement(Foundation.Divider, {
                orientation = Foundation.Enums.Orientation.Horizontal,
                LayoutOrder = 2,
                Visible = React.joinBindings({ tbl1.textTransparency, var8 }):map(function(arg1)
                    return arg1[1] < 1 and arg1[2]
                end),
                DividerVariant = Foundation.Enums.DividerVariant.Default
            }),
            ReasoningText = React.createElement(Foundation.Text, {
                Text = var3,
                tag = "text-body-small text-align-x-left text-wrap size-full-0 auto-y",
                LayoutOrder = 3,
                RichText = true,
                textStyle = {
                    Color3 = var1.Color.Content.Default.Color3,
                    Transparency = mergeBindableScalar(var1.Color.Content.Default.Transparency, tbl1.textTransparency)
                },
                stroke = {
                    Color = Color3.fromRGB(0, 0, 0),
                    Transparency = mergeBindableScalar(0.5, tbl1.textTransparency),
                    Thickness = var1.Stroke.Thin
                }
            })
        })
    })
end)
