-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:21:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarSwitcherParent = script:FindFirstAncestor("AvatarSwitcher").Parent

local React = require(AvatarSwitcherParent.React)
local Foundation = require(AvatarSwitcherParent.Foundation)
local useTokens = Foundation.Hooks.useTokens

local FFlagAvatarSwitcherUiFixes = require(AvatarSwitcherParent.AvatarExperienceFlags).FFlagAvatarSwitcherUiFixes

local function MessageCard(tbl1)
    local size800 = useTokens().Size.Size_800

    return React.createElement(Foundation.View, {
        tag = "col gap-medium stroke-default bg-shift-100 radius-medium padding-large",
        Size = tbl1.Size,
        AutomaticSize = tbl1.AutomaticSize
    }, {
        Header = React.createElement(Foundation.View, {
            tag = "size-full-0 auto-y row align-y-center gap-small"
        }, {
            Image = React.createElement(Foundation.Image, {
                tag = if tbl1.icon == "Info" then "" else "content-system-warning",
                Image = if tbl1.icon == "Info" then "icons/actions/info" else "icons/status/alert",
                Size = UDim2.fromOffset(size800, size800),
                LayoutOrder = 1
            }),
            HeaderText = React.createElement(Foundation.Text, {
                tag = "auto-y text-align-x-left anchor-center-right text-title-medium text-wrap grow",
                Text = tbl1.headerText,
                LayoutOrder = 2
            }),
            CloseButton = tbl1.onClose
                and React.createElement(
                    Foundation.Image,
                    {
                        tag = "size-600 radius-small",
                        Image = "icons/navigation/close",
                        onActivated = tbl1.onClose,
                        LayoutOrder = 3
                    }
                )
        }),
        ContentText = (not FFlagAvatarSwitcherUiFixes or tbl1.contentText)
            and React.createElement(
                Foundation.Text,
                {
                    tag = " size-full-0 auto-y text-align-x-left text-body-medium text-wrap",
                    Text = tbl1.contentText
                }
            )
    })
end
return MessageCard
