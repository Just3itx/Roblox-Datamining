-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:41:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Groups = script:FindFirstAncestor("Groups")
local GroupsParent = Groups.Parent

local React = require(GroupsParent.React)
local Foundation = require(GroupsParent.Foundation)
local useLocalization = require(GroupsParent.Localization).Hooks.useLocalization

local View = Foundation.View
local Button = Foundation.Button
local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize

local TextKeys = require(Groups.Common.TextKeys)
local useGroupsWrapperContext = require(Groups.Contexts.useGroupsWrapperContext)
local useGroupsAnalytics = require(Groups.Hooks.useGroupsAnalytics)
local EventNames = require(Groups.Analytics.EventNames)
local SearchBarWrapper = require(script.Parent.SearchBarWrapper)

local function GroupsListToolbar(tbl1)
    local var1 = useGroupsWrapperContext()
    local var2 = useGroupsAnalytics()
    local var3 = useLocalization({ searchPlaceholder = TextKeys.LabelSearchMyGroups, createGroup = TextKeys.ActionCreateGroup })

    local searchPlaceholder = tbl1.searchPlaceholder or var3.searchPlaceholder

    local onActivated = React.useCallback(function()
        var2.fireAnalyticsEvent(EventNames.GroupsListCreateGroupClicked)
        var1.navigateTo.createGroup()
    end, { var1.navigateTo.createGroup, var2 })

    return React.createElement(
        View,
        {
            LayoutOrder = tbl1.layoutOrder,
            tag = "col size-full-0 auto-y align-x-left gap-medium"
        },
        {
            Search = React.createElement(
                SearchBarWrapper,
                {
                    LayoutOrder = 1,
                    placeholderText = searchPlaceholder,
                    onTextChanged = tbl1.onSearchTextChanged
                }
            ),
            CreateGroupButton = React.createElement(
                View,
                {
                    LayoutOrder = 2,
                    tag = "col",
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y
                },
                {
                    Button = React.createElement(Button, {
                        text = var3.createGroup,
                        variant = ButtonVariant.Standard,
                        size = InputSize.Medium,
                        width = UDim.new(1, 0),
                        isDisabled = tbl1.canCreateGroup == false,
                        onActivated = onActivated
                    })
                }
            )
        }
    )
end

return GroupsListToolbar
