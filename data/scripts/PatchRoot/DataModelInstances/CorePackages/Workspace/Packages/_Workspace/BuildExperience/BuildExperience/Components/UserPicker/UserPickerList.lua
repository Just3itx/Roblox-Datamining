-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:20:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization

local UserPickerRow = require(script.Parent.UserPickerRow)
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local List = Foundation.List
local Skeleton = Foundation.Skeleton
local FoundationText = Foundation.Text
local View = Foundation.View

local InputSize = Foundation.Enums.InputSize
local Radius = Foundation.Enums.Radius

local function trim(searchText: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return (string.gsub(searchText, "^%s*(.-)%s*$", "%1"))
end

local function renderSkeletonRow(layoutOrder: number, testId: string)
    return React.createElement(
        View,
        {
            LayoutOrder = layoutOrder,
            tag = "row align-y-center gap-medium size-full-0 auto-y padding-y-small",
            testId = testId
        },
        {
            Avatar = React.createElement(Skeleton, { LayoutOrder = 1, Size = UDim2.fromOffset(36, 36), radius = Radius.Circle }),
            Lines = React.createElement(View, { LayoutOrder = 2, tag = "col fill gap-small auto-y" }, {
                Title = React.createElement(Skeleton, { LayoutOrder = 1, Size = UDim2.new(0.5, 0, 0, 12), radius = Radius.Small }),
                Description = React.createElement(Skeleton, { LayoutOrder = 2, Size = UDim2.new(0.3, 0, 0, 10), radius = Radius.Small })
            })
        }
    )
end

local function UserPickerList(tbl1)
    local noResults = useLocalization({ noResults = LocalizationStrings.USER_PICKER_NO_RESULTS }).noResults
    local testId = tbl1.testId or "user-picker-list"
    local userIds = tbl1.userIds

    if #userIds == 0 and tbl1.isLoading then
        local tbl2 = {}
        for i = 1, 6 do
            tbl2[`skeleton-{i}`] = renderSkeletonRow(i, `{testId}-skeleton-{i}`)
        end
        return React.createElement(
            View,
            {
                LayoutOrder = tbl1.layoutOrder,
                tag = "col gap-small size-full-0 auto-y",
                testId = `{testId}-loading`
            },
            tbl2
        )
    end

    if #userIds == 0 and not tbl1.isLoading then
        if trim(tbl1.searchText) == "" then
            noResults = tbl1.emptyText
        end

        if noResults ~= nil then
            return React.createElement(View, {
                LayoutOrder = tbl1.layoutOrder,
                tag = "col align-x-center size-full-0 auto-y padding-y-xlarge",
                testId = `{testId}-empty`
            }, {
                Text = React.createElement(
                    FoundationText,
                    {
                        Text = noResults,
                        tag = "auto-xy text-body-large text-align-x-center content-muted"
                    }
                )
            })
        end
    end

    local tbl2 = ({})
    for layoutOrder, userId in userIds do
        local str1 = `row-{userId}`
        local createElement = React.createElement
        local var1 = UserPickerRow
        local tbl3 = {
            userId = userId,
            isSelected = tbl1.isSelected(userId),
            isDisabled = not tbl1.canSelect(userId),
            onToggle = 0,
            layoutOrder = 0,
            testId = 0
        }

        function tbl3.onToggle()
            tbl1.toggleSelected(userId)
        end
        tbl3.layoutOrder = layoutOrder
        tbl3.testId = `{testId}-user-{userId}`
        tbl2[str1] = createElement(var1, tbl3)
    end

    return React.createElement(List.Root, {
        LayoutOrder = tbl1.layoutOrder,
        hasDivider = false,
        isContained = false,
        size = InputSize.Medium,
        testId = `{testId}-results`
    }, tbl2)
end

return UserPickerList
