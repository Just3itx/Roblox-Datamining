-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local React = require(ChatUIPrimitivesParent.React)
local Foundation = require(ChatUIPrimitivesParent.Foundation)
local _Signals = require(ChatUIPrimitivesParent.Signals)
local SignalsReact = require(ChatUIPrimitivesParent.SignalsReact)

local _Types = require(script.Parent.Parent.Parent.Types)
local Sizing = require(script.Parent.Parent.Parent.Sizing)

local function BubbleAvatar(tbl1)
    local var1 = SignalsReact.useSignalBinding(tbl1.getIdentity)
    local tag = Sizing.useSizing().avatar.tag
    local var2 = Foundation.Hooks.useDefaultTags(tag, "stroke-standard stroke-default radius-circle")

    if not tbl1.visible then
        return React.createElement(Foundation.View, { tag = tag, LayoutOrder = tbl1.LayoutOrder, testId = tbl1.testId })
    end

    return React.createElement(Foundation.Image, {
        tag = var2,
        Image = var1:map(function(arg1)
            return if arg1 and arg1.avatarContent then arg1.avatarContent else ""
        end),
        LayoutOrder = tbl1.LayoutOrder,
        testId = tbl1.testId
    })
end

return BubbleAvatar
