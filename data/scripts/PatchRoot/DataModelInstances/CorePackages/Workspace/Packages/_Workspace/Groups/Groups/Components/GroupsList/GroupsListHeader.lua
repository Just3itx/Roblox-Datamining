-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:41:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Groups = script:FindFirstAncestor("Groups")
local GroupsParent = Groups.Parent

local React = require(GroupsParent.React)
local useLocalization = require(GroupsParent.Localization).Hooks.useLocalization
local useNavigation = require(GroupsParent.Navigation).useNavigation

local Foundation = require(GroupsParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text
local Button = Foundation.Button
local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize

local AppHeaderBar = require(GroupsParent.AppHeaderBar)

local TextKeys = require(Groups.Common.TextKeys)
local useGroupsWrapperContext = require(Groups.Contexts.useGroupsWrapperContext)
local FFlagEnableGroupOverviewPane = require(GroupsParent.SharedFlags).FFlagEnableGroupOverviewPane

local function GroupsListHeader(tbl1)
    local var1 = useGroupsWrapperContext()
    local var2 = useNavigation()

    local var3 = useLocalization({ title = TextKeys.HeadingGroups, seeAll = TextKeys.ActionSeeAll })

    local var4 = React.useCallback(function()
        if FFlagEnableGroupOverviewPane and var1.navigateTo.previousView then
            var1.navigateTo.previousView()
            return
        end

        var2.goBack()
    end, { if FFlagEnableGroupOverviewPane then var1.navigateTo.previousView else nil, var2 })

    local var5 = React.useMemo(function()
        return AppHeaderBar.makeBackButton(var4)
    end, { var4 })

    local backButton = React.useMemo(function()
        local button = var5()
        return React.createElement(View, { tag = "align-x-left size-0 auto-xy", LayoutOrder = 1 }, { button = button })
    end, { var5 })

    return React.createElement("Frame", {
        LayoutOrder = tbl1.layoutOrder,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1
    }, {
        LeftSection = React.createElement(View, { tag = "row align-y-center gap-small auto-xy" }, {
            BackButton = backButton,
            Title = React.createElement(
                FoundationText,
                {
                    Text = var3.title,
                    tag = "text-heading-medium text-align-x-left content-default",
                    LayoutOrder = 2
                }
            )
        }),
        SeeAllButton = React.createElement(Button, {
            text = var3.seeAll,
            variant = ButtonVariant.Text,
            size = InputSize.Medium,
            onActivated = var1.navigateTo.seeAllGroups,
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, 0, 0.5, 0)
        })
    })
end

return GroupsListHeader
