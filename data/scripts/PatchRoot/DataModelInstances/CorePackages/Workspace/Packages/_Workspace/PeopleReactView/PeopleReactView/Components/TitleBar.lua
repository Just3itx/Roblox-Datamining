-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:30:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeopleReactView = script:FindFirstAncestor("PeopleReactView")
local PeopleReactViewParent = PeopleReactView.Parent

local React = require(PeopleReactViewParent.React)
local Foundation = require(PeopleReactViewParent.Foundation)

local useLocalization = require(PeopleReactViewParent.Localization).Hooks.useLocalization

local FoundationText = Foundation.Text
local View = Foundation.View

local LayoutToggleButton = require(PeopleReactView.Components.Buttons.LayoutToggleButton)

local Constants = require(PeopleReactView.Constants)

return React.memo(function(tbl1) -- name: TitleBar
    local var1 = useLocalization({ header = Constants.PEOPLEPAGE.PEOPLE_LIST.HEADER })

    return React.createElement(
        View,
        {
            tag = "row size-full-0 auto-y align-y-center flex-x-between",
            LayoutOrder = tbl1.LayoutOrder
        },
        {
            Title = React.createElement(
                FoundationText,
                {
                    tag = "auto-xy content-default text-heading-small text-align-x-left",
                    Text = var1.header,
                    LayoutOrder = 1
                }
            ),
            LayoutToggleButton = React.createElement(LayoutToggleButton, { layout = tbl1.layout, setLayout = tbl1.setLayout, LayoutOrder = 2 })
        }
    )
end)
