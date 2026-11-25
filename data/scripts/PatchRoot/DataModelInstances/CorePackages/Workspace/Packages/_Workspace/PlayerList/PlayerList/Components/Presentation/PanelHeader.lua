-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:01:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local Foundation = require(scriptParentParentParentParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text
local IconButton = Foundation.IconButton
local useLocalization = require(scriptParentParentParentParent.Localization).Hooks.useLocalization

local FFlagPlayerListLocalizeGameText = require(scriptParentParentParent.Flags.FFlagPlayerListLocalizeGameText)

return React.memo(function(tbl1) -- name: PanelHeader
    local var1 = if FFlagPlayerListLocalizeGameText then useLocalization({ leaderboard = "InGame.PlayerList.Leaderboard" }).leaderboard else "Leaderboard"

    return React.createElement(View, {
        Size = UDim2.new(1, 0, 0, tbl1.height),
        LayoutOrder = tbl1.layoutOrder,
        tag = "row flex-x-between align-y-center auto-y padding-x-large"
    }, {
        Title = React.createElement(
            FoundationText,
            {
                Text = tbl1.title or var1,
                tag = "auto-xy text-label-medium content-emphasis",
                LayoutOrder = 1
            }
        ),
        CloseButton = React.createElement(IconButton, {
            icon = {
                name = Foundation.Enums.IconName.X
            },
            size = Foundation.Enums.InputSize.XSmall,
            onActivated = tbl1.onClose,
            isDisabled = tbl1.isDisabled == true,
            LayoutOrder = 2
        })
    })
end)
