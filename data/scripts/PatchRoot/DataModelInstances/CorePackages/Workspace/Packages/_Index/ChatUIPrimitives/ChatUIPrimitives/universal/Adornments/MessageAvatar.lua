-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:21:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local React = require(ChatUIPrimitivesParent.React)
local Foundation = require(ChatUIPrimitivesParent.Foundation)
local _Signals = require(ChatUIPrimitivesParent.Signals)
local SignalsReact = require(ChatUIPrimitivesParent.SignalsReact)

local _Types = require(script.Parent.Parent.Types)

local function toAvatarImage(arg1)
    return if arg1 and arg1.avatarContent then arg1.avatarContent else ""
end

local function AvatarImage(tbl1)
    local var1 = SignalsReact.useSignalBinding(tbl1.getIdentity)
    local image = React.useMemo(function()
        return var1:map(toAvatarImage)
    end, { var1 })
    local tag = Foundation.Hooks.useDefaultTags(tbl1.sizeTag, "stroke-standard stroke-default radius-circle")

    return React.createElement(
        Foundation.Image,
        {
            tag = tag,
            Image = image,
            LayoutOrder = tbl1.LayoutOrder,
            testId = tbl1.testId
        }
    )
end
return React.memo(function(tbl1) -- name: MessageAvatar
    if not tbl1.visible then
        return React.createElement(
            Foundation.View,
            {
                tag = tbl1.gutterTag or tbl1.sizeTag,
                LayoutOrder = tbl1.LayoutOrder,
                testId = tbl1.testId
            }
        )
    end
    return React.createElement(
        AvatarImage,
        {
            getIdentity = tbl1.getIdentity,
            sizeTag = tbl1.sizeTag,
            LayoutOrder = tbl1.LayoutOrder,
            testId = tbl1.testId
        }
    )
end)
