-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:31:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTileParent = script:FindFirstAncestor("GameTile").Parent

local React = require(GameTileParent.React)
local Foundation = require(GameTileParent.Foundation)
local Button = Foundation.Button
local ButtonVariant = Foundation.Enums.ButtonVariant
local FillBehavior = Foundation.Enums.FillBehavior
local IconName = Foundation.Enums.IconName
local InputSize = Foundation.Enums.InputSize

local useLocalization = require(GameTileParent.Localization).Hooks.useLocalization

return React.memo(function(tbl1) -- name: InstantPlayButton
    local var1 = useLocalization({ play = "Feature.ExperienceDetails.PlayButtonText.Play" })

    return React.createElement(Button, {
        icon = if tbl1.showIcon then IconName.PlayXlarge else nil,
        text = if tbl1.showText then var1.play else nil,
        variant = ButtonVariant.SoftEmphasis,
        size = InputSize.Small,
        fillBehavior = FillBehavior.Fill,
        onActivated = tbl1.onActivated
    })
end)
