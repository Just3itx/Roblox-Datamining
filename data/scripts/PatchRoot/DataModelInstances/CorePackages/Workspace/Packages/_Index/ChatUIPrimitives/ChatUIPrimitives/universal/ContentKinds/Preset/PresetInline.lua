-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
local ChatUIPrimitivesParent = ChatUIPrimitives.Parent
local React = require(ChatUIPrimitivesParent.React)
local Foundation = require(ChatUIPrimitivesParent.Foundation)
local _Signals = require(ChatUIPrimitivesParent.Signals)
local SignalsReact = require(ChatUIPrimitivesParent.SignalsReact)

local escapeRichText = require(ChatUIPrimitives.Utils.escapeRichText)
local _PresetTypes = require(script.Parent.PresetTypes)
local getPresetIconRichText = require(script.Parent.getPresetIconRichText)

local function PresetInline(tbl1)
    local var1 = Foundation.Hooks.useTokens()
    local var2 = SignalsReact.useSignalBinding(tbl1.getContent)
    local var3 = React.useMemo(function()
        return getPresetIconRichText(var1.Typography.BodyLarge.FontSize)
    end, { var1 })

    return React.createElement(Foundation.Text, {
        tag = "size-full-0 auto-y text-wrap text-align-x-left text-align-y-top",
        Text = var2:map(function(arg1): string
            return `{escapeRichText(arg1.displayText)} {var3}`
        end),
        RichText = true,
        LayoutOrder = tbl1.LayoutOrder
    })
end

return PresetInline
