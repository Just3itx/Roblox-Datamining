-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:01:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local CreatorGroupRow = require(script.Parent.CreatorGroupRow)

local Button = Foundation.Button
local IconButton = Foundation.IconButton
local List = Foundation.List
local RadioGroup = Foundation.RadioGroup
local SearchInput = Foundation.SearchInput
local Sheet = Foundation.Sheet
local FoundationText = Foundation.Text
local View = Foundation.View

local ButtonVariant = Foundation.Enums.ButtonVariant
local FillBehavior = Foundation.Enums.FillBehavior
local IconName = Foundation.Enums.IconName
local InputSize = Foundation.Enums.InputSize

local function MyCreationsFilterView(tbl1)
    local testId = tbl1.testId or "MyCreationsFilterView"

    local tbl2 = ({})
    for layoutOrder, gamesOption in tbl1.gamesOptions do
        local value = gamesOption.value
        tbl2[value] = React.createElement(
            RadioGroup.Item,
            {
                LayoutOrder = layoutOrder,
                value = gamesOption.value,
                label = gamesOption.label,
                size = InputSize.Medium
            }
        )
    end
    local tbl3 = ({})
    for layoutOrder, group in tbl1.groups do
        local str1 = `Group{group.id}`
        tbl3[str1] = React.createElement(CreatorGroupRow, {
            LayoutOrder = layoutOrder,
            name = group.name,
            icon = group.icon,
            isSelected = group.isSelected,
            onActivated = group.onActivated,
            testId = `{testId}.Group.{group.id}`
        })
    end

    local createElement = React.createElement
    local fragment = React.Fragment
    local var1 = nil
    local tbl4 = {
        Header = React.createElement(View, {
            LayoutOrder = tbl1.LayoutOrder,
            tag = { ["composition-layout-detail"] = true, ["size-full-0 auto-y"] = true },
            testId = `{testId}.Layout`
        }, {
            Header = React.createElement(View, {
                tag = {
                    ["composition-content-body"] = true,
                    ["row align-y-center gap-small size-full-0 auto-y padding-y-small"] = true
                },
                testId = testId
            }, {
                Label = React.createElement(FoundationText, {
                    LayoutOrder = 1,
                    Text = tbl1.label,
                    tag = "fill auto-y text-heading-small text-align-x-left text-truncate-end content-emphasis",
                    testId = `{testId}.Label`
                }),
                FilterButton = React.createElement(IconButton, {
                    LayoutOrder = 2,
                    icon = IconName.ThreeBarsHorizontalNarrowing,
                    onActivated = tbl1.onOpenSheet,
                    size = InputSize.Small,
                    testId = `{testId}.FilterButton`,
                    variant = ButtonVariant.Utility
                })
            })
        }),
        Sheet = 0
    }

    local createElement2 = React.createElement
    local root = Sheet.Root
    local tbl5 = {
        isOpen = tbl1.isSheetOpen,
        onClose = tbl1.onSheetClosed,
        ref = tbl1.focusRootRef,
        testId = `{testId}.Sheet`
    }
    local tbl6 = {
        Header = React.createElement(Sheet.Header, nil, {
            Title = React.createElement(FoundationText, {
                LayoutOrder = 1,
                Text = tbl1.titleText,
                tag = "shrink auto-xy text-heading-small text-wrap text-align-x-left content-emphasis"
            })
        }),
        Content = 0,
        Actions = 0
    }

    local createElement3 = React.createElement
    local content = Sheet.Content
    local var2 = nil
    local tbl7 = { Body = 0 }
    local createElement4 = React.createElement
    local var3 = View
    local tbl8 = { tag = "col gap-xlarge size-full-0 auto-y" }

    local tbl9 = {
        Games = React.createElement(RadioGroup.Root, {
            LayoutOrder = 1,
            legend = tbl1.gamesLegend,
            onValueChanged = tbl1.onGamesChanged,
            tag = "size-full-0 auto-y",
            testId = `{testId}.Games`,
            value = tbl1.selectedGames
        }, tbl2),
        Groups = 0
    }
    local element

    if tbl1.isGroupsVisible then
        element = React.createElement(
            View,
            {
                LayoutOrder = 2,
                tag = "col gap-large size-full-0 auto-y",
                testId = `{testId}.Groups`
            },
            {
                Legend = React.createElement(FoundationText, {
                    LayoutOrder = 1,
                    Text = tbl1.groupsLegend,
                    tag = "auto-xy text-title-medium text-wrap text-align-x-left content-emphasis"
                }),
                Search = React.createElement(SearchInput, {
                    LayoutOrder = 2,
                    text = tbl1.groupSearchText,
                    placeholder = tbl1.groupSearchPlaceholder,
                    onChanged = tbl1.onGroupSearchTextChanged,
                    size = InputSize.Medium,
                    width = UDim.new(1, 0),
                    testId = `{testId}.GroupSearch`
                }),
                List = React.createElement(List.Root, {
                    LayoutOrder = 3,
                    hasDivider = true,
                    isContained = true,
                    size = InputSize.Medium,
                    testId = `{testId}.GroupList`
                }, tbl3)
            }
        )
    else
        element = nil
    end

    tbl9.Groups = element
    tbl7.Body = createElement4(var3, tbl8, tbl9)
    tbl6.Content = createElement3(content, var2, tbl7)

    tbl6.Actions = React.createElement(Sheet.Actions, nil, {
        Apply = React.createElement(Button, {
            LayoutOrder = 1,
            text = tbl1.applyText,
            size = InputSize.Medium,
            variant = ButtonVariant.Emphasis,
            fillBehavior = FillBehavior.Fill,
            width = UDim.new(1, 0),
            onActivated = tbl1.onApply,
            testId = `{testId}.Apply`
        }),
        Reset = React.createElement(Button, {
            LayoutOrder = 2,
            text = tbl1.resetText,
            size = InputSize.Medium,
            variant = ButtonVariant.Standard,
            fillBehavior = FillBehavior.Fill,
            width = UDim.new(1, 0),
            onActivated = tbl1.onReset,
            testId = `{testId}.Reset`
        })
    })
    tbl4.Sheet = createElement2(root, tbl5, tbl6)
    return createElement(fragment, var1, tbl4)
end

return MyCreationsFilterView
