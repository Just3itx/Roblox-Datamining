-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:31:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local React = require(ChatUIPrimitivesParent.React)
local Foundation = require(ChatUIPrimitivesParent.Foundation)
local _Signals = require(ChatUIPrimitivesParent.Signals)
local SignalsReact = require(ChatUIPrimitivesParent.SignalsReact)

local _Types = require(script.Parent.Parent.Parent.Types)
local Sizing = require(script.Parent.Parent.Parent.Sizing)

local flexItem = {
    ItemLineAlignment = Enum.ItemLineAlignment.Start
}
local function BubbleUsername(tbl2)
    local var1 = SignalsReact.useSignalBinding(tbl2.getIdentity)
    local var2 = Sizing.useSizing()
    local tag = Foundation.Hooks.useDefaultTags(var2.username.tag, "auto-xy text-align-x-left")

    return React.createElement(Foundation.Text, {
        tag = tag,
        flexItem = flexItem,
        Text = var1:map(function(arg1)
            return if arg1 then arg1.displayName else ""
        end),
        LayoutOrder = tbl2.LayoutOrder,
        testId = tbl2.testId
    })
end

return BubbleUsername
