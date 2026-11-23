-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:31:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarSwitcherParent = script:FindFirstAncestor("AvatarSwitcher").Parent

local React = require(AvatarSwitcherParent.React)
local Foundation = require(AvatarSwitcherParent.Foundation)
local useLocalization = require(AvatarSwitcherParent.Localization).Hooks.useLocalization

local function TopBar(tbl1)
    local var1 = useLocalization({ headerText = "Feature.AvatarSwitcher.Heading.SwitchAvatar" })

    return (React.createElement(
        Foundation.View,
        { tag = "size-full-1200 row align-y-center gap-medium padding-x-medium" },
        {
            CloseButton = React.createElement(
                Foundation.Image,
                {
                    tag = "size-600 radius-small",
                    Image = "icons/navigation/close",
                    onActivated = tbl1.onClose
                }
            ),
            HeaderText = React.createElement(Foundation.Text, { tag = "auto-x text-title-large", Text = var1.headerText, LayoutOrder = 2 })
        }
    ))
end

return TopBar
