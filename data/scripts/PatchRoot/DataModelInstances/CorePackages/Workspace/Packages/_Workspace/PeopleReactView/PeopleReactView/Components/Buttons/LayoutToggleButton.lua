-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:21:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeopleReactViewParent = script:FindFirstAncestor("PeopleReactView").Parent

local React = require(PeopleReactViewParent.React)

local Foundation = require(PeopleReactViewParent.Foundation)
local IconName = Foundation.Enums.IconName
local InputSize = Foundation.Enums.InputSize
local Icon = Foundation.Icon
local View = Foundation.View

local GameSettings = UserSettings().GameSettings

return React.memo(function(tbl1) -- name: LayoutToggleButton
    local var1 = React.useCallback(function(peoplePageLayout)
        return function()
            GameSettings.PeoplePageLayout = peoplePageLayout
            tbl1.setLayout(peoplePageLayout)
        end
    end, {})

    return React.createElement(
        View,
        {
            tag = "row auto-xy bg-shift-100 radius-medium gap-xxsmall padding-xsmall",
            LayoutOrder = tbl1.LayoutOrder
        },
        {
            CardLayoutButton = React.createElement(
                View,
                {
                    tag = {
                        ["row align-x-center align-y-center size-1000-1000 radius-medium"] = true,
                        ["bg-shift-300"] = tbl1.layout == Enum.PeoplePageLayout.Card
                    },
                    LayoutOrder = 1,
                    onActivated = var1(Enum.PeoplePageLayout.Card)
                },
                {
                    Icon = React.createElement(Icon, { name = IconName.Grid, size = InputSize.Medium })
                }
            ),
            ListLayoutButton = React.createElement(
                View,
                {
                    tag = {
                        ["row align-x-center align-y-center size-1000-1000 radius-medium"] = true,
                        ["bg-shift-300"] = tbl1.layout == Enum.PeoplePageLayout.List
                    },
                    LayoutOrder = 2,
                    onActivated = var1(Enum.PeoplePageLayout.List)
                },
                {
                    Icon = React.createElement(Icon, { name = IconName.ListBulleted, size = InputSize.Medium })
                }
            )
        }
    )
end)
