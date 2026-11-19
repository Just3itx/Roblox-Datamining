-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:50:57Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Text = require(Foundation.Components.Text)

local ShortcutSeparator = require(Foundation.Enums.ShortcutSeparator)

local _useShortcutVariants = require(script.Parent.useShortcutVariants)

local tbl1 = {
    [ShortcutSeparator.Or] = "/",
    [ShortcutSeparator.More] = "…"
}

local function Separator(tbl2)
    return React.createElement(Text, {
        Text = tbl1[tbl2.separator],
        tag = tbl2.variantProps.separator.tag,
        LayoutOrder = tbl2.LayoutOrder,
        testId = tbl2.testId
    })
end

return Separator
