-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:01:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local Foundation = require(scriptParentParentParentParent.Foundation)
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens

local Constants = require(scriptParentParentParent.Common.Constants)
local usePreferredBackgroundStyle = require(scriptParentParentParent.Hooks.usePreferredBackgroundStyle)

return React.memo(function(tbl1) -- name: LeaderboardRowShell
    local var1 = useTokens()
    local backgroundStyle = usePreferredBackgroundStyle(var1.Color.OverMedia.OverMedia_100)

    local var3 = tbl1.flexTag or Constants.ROW_FLEX_TAG
    local tbl2 = {
        RowContent = React.createElement(View, { tag = `size-full {var3}` }, tbl1.children)
    }

    if tbl1.isHighlighted then
        tbl2.Highlight = React.createElement(View, { backgroundStyle = backgroundStyle, tag = "size-full", ZIndex = 0 })
    end

    if tbl1.showDivider then
        tbl2.Divider = React.createElement(Foundation.Divider, { AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1) })
    end

    local selection = tbl1.selection
    if selection == nil then
        if tbl1.onActivated then
            selection = Constants.SELECTABLE
        else
            selection = Constants.NOT_SELECTABLE
        end
    end
    return React.createElement(View, {
        Size = UDim2.new(1, 0, 0, tbl1.rowHeight),
        LayoutOrder = tbl1.layoutOrder,
        onActivated = tbl1.onActivated,
        ref = tbl1.rowRef,
        selection = selection,
        testId = "leaderboard-row-shell"
    }, tbl2)
end)
