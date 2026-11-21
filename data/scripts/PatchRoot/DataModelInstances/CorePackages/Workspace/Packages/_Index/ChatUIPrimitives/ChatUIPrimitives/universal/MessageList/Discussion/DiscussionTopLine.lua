-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:40:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local React = require(ChatUIPrimitivesParent.React)
local Foundation = require(ChatUIPrimitivesParent.Foundation)
local _Signals = require(ChatUIPrimitivesParent.Signals)
local SignalsReact = require(ChatUIPrimitivesParent.SignalsReact)

local _Types = require(script.Parent.Parent.Parent.Types)
local MessageTimestamp = require(script.Parent.Parent.Parent.Adornments.MessageTimestamp)

local function toDisplayName(arg1)
    return if arg1 then arg1.displayName else ""
end

return React.memo(function(tbl1) -- name: DiscussionTopLine
    local var1 = SignalsReact.useSignalBinding(tbl1.getIdentity)
    local var2 = React.useMemo(function()
        return var1:map(toDisplayName)
    end, { var1 })

    return React.createElement(Foundation.View, {
        tag = tbl1.tag,
        LayoutOrder = tbl1.LayoutOrder,
        testId = tbl1.testId
    }, {
        Name = React.createElement(Foundation.Text, { tag = tbl1.nameTag, Text = var2, LayoutOrder = 1, testId = "discussion-name" }),
        Timestamp = React.createElement(MessageTimestamp, {
            getSentAtUnixMilliseconds = tbl1.getSentAtUnixMilliseconds,
            tag = tbl1.timestampTag,
            LayoutOrder = 2,
            testId = "discussion-timestamp"
        })
    })
end)
