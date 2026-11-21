-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:31:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local React = require(ChatUIPrimitivesParent.React)
local Foundation = require(ChatUIPrimitivesParent.Foundation)
local _Signals = require(ChatUIPrimitivesParent.Signals)
local SignalsReact = require(ChatUIPrimitivesParent.SignalsReact)
local createNextOrder = require(ChatUIPrimitivesParent.ReactUtils).createNextOrder

local _Types = require(script.Parent.Parent.Types)

local function IdentityInline(tbl1)
    local nextOrder = createNextOrder()
    local var1 = SignalsReact.useSignalBinding(tbl1.getIdentity)

    return React.createElement(
        Foundation.View,
        {
            tag = "row align-x-left align-y-center gap-xsmall auto-xy",
            LayoutOrder = tbl1.LayoutOrder
        },
        {
            avatar = React.createElement(Foundation.Image, {
                tag = "size-400-400 stroke-standard stroke-default radius-circle",
                Image = var1:map(function(arg1)
                    return if arg1 and arg1.avatarContent then arg1.avatarContent else ""
                end),
                LayoutOrder = nextOrder()
            }),
            displayName = React.createElement(Foundation.Text, {
                tag = "auto-xy",
                Text = var1:map(function(arg1): string
                    if arg1 then
                        return `{arg1.displayName}:`
                    end

                    return ""
                end),
                LayoutOrder = nextOrder()
            })
        }
    )
end
return IdentityInline
