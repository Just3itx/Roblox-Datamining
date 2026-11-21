-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:41:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
local ChatUIPrimitivesParent = ChatUIPrimitives.Parent
local React = require(ChatUIPrimitivesParent.React)
local Foundation = require(ChatUIPrimitivesParent.Foundation)
local _Signals = require(ChatUIPrimitivesParent.Signals)
local SignalsReact = require(ChatUIPrimitivesParent.SignalsReact)

local escapeRichText = require(ChatUIPrimitives.Utils.escapeRichText)
local formatInlineIcon = require(ChatUIPrimitives.Utils.formatInlineIcon)
local SystemContentModel = require(script.Parent.Parent.ContentKinds.System.SystemContentModel)
local Sizing = require(script.Parent.Parent.Sizing)
local _groupMessages = require(script.Parent.groupMessages)

local function systemRichText(arg1)
    local content = arg1.message.contents[1]
    local detail = if content == nil then nil else SystemContentModel.getDetail(content)

    if detail == nil then
        return ""
    end
    local var1 = escapeRichText(detail.text)
    if detail.iconName ~= nil then
        return `{formatInlineIcon(detail.iconName, { weight = "600" })} {var1}`
    end
    return var1
end

local function SystemItem(tbl1)
    local var1 = SignalsReact.useSignalBinding(function(arg1)
        return (systemRichText(tbl1.itemSignal(arg1)))
    end)
    local var2 = Sizing.useSizing()
    local tag = Foundation.Hooks.useDefaultTags(var2.system.tag, "size-full-0 auto-y text-wrap text-align-x-center content-muted")

    return React.createElement(Foundation.Text, { tag = tag, Text = var1, RichText = true, testId = "message-system" })
end

return SystemItem
