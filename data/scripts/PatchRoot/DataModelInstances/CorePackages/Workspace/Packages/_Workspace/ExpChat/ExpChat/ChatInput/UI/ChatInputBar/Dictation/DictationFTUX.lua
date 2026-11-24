-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local React = require(ExpChatParent.React)
local Foundation = require(ExpChatParent.Foundation)
local Popover = Foundation.Popover
local PopoverSide = Foundation.Enums.PopoverSide
local PopoverAlign = Foundation.Enums.PopoverAlign

local Localization = require(ExpChat.Localization)
local useIsChatBackgroundVisible = require(ExpChat.Stores.GetTransparencyStore.useIsChatBackgroundVisible)

return React.memo(function(tbl1) -- name: DictationFTUX
    local isOpen = useIsChatBackgroundVisible()
    local var2 = Foundation.Hooks.useTokens()

    local var3 = Localization.useLocalization({ longPressHint = "CoreScripts.TextChat.ChatWindow.HandFreeTranscriptionFTUX" })

    local var4 = if not var3.longPressHint or var3.longPressHint == "" then "Hold to go hands free" else var3.longPressHint

    return React.createElement(Popover.Root, { isOpen = isOpen }, {
        Anchor = React.createElement(Popover.Anchor, { anchorRef = tbl1.anchorRef }),
        Content = React.createElement(
            Popover.Content,
            {
                hasArrow = true,
                side = {
                    position = PopoverSide.Top,
                    offset = var2.Size.Size_200
                },
                align = PopoverAlign.Center,
                selectionGroup = false
            },
            React.createElement(Foundation.View, {
                tag = "col gap-xsmall auto-xy padding-x-small padding-y-xsmall radius-small",
                backgroundStyle = var2.Inverse.Surface.Surface_0,
                sizeConstraint = {
                    MaxSize = Vector2.new(320, math.huge)
                },
                onActivated = tbl1.onDismiss
            }, {
                Title = React.createElement(
                    Foundation.Text,
                    {
                        tag = "auto-xy text-body-medium text-wrap content-inverse-default",
                        Text = var4
                    }
                )
            })
        )
    })
end)
