-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:41:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ShareSheetParent = script:FindFirstAncestor("ShareSheet").Parent

local Foundation = require(ShareSheetParent.Foundation)
local React = require(ShareSheetParent.React)
local UserTile = require(ShareSheetParent.UserTile)

local Skeleton = Foundation.Skeleton
local FoundationText = Foundation.Text
local View = Foundation.View
local Radius = Foundation.Enums.Radius
local UserTile2 = UserTile.UserTile
local LayoutMode = UserTile.LayoutMode
local useTokens = Foundation.Hooks.useTokens

local function getItemLayoutMetrics(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local size1400 = arg1.Size.Size_1400
    local small = arg1.Padding.Small
    local xSmall = arg1.Padding.XSmall

    return {
        avatarSize = size1400,
        rowVerticalPadding = small,
        wrapperVerticalPadding = xSmall,
        estimatedRowHeight = size1400 + 2 * small + 2 * xSmall
    }
end

return {
    getItemLayoutMetrics = getItemLayoutMetrics,
    Item = function(tbl1) -- name: PeoplePickerListItem
        local itemLayoutMetrics = getItemLayoutMetrics((useTokens()))

        local testId = tbl1.testId or "people-picker-list-item"
        local bool1 = tbl1.isLoading == true
        local leading = tbl1.leading

        local createElement = React.createElement
        local var1 = View
        local tbl2 = { tag = "col size-full-0 auto-y" }

        local tbl3 = { Wrapper = 0 }
        local createElement2 = React.createElement
        local var2 = View
        local tbl4 = {
            tag = "size-full-0 auto-y",
            padding = {
                top = UDim.new(0, itemLayoutMetrics.wrapperVerticalPadding),
                bottom = UDim.new(0, itemLayoutMetrics.wrapperVerticalPadding)
            }
        }
        local tbl5 = { Row = 0 }
        local createElement3 = React.createElement
        local var3 = View
        local tbl6 = {
            tag = "row align-y-center gap-medium size-full-0 auto-y radius-medium",
            padding = {
                top = UDim.new(0, itemLayoutMetrics.rowVerticalPadding),
                bottom = UDim.new(0, itemLayoutMetrics.rowVerticalPadding)
            },
            onActivated = if bool1 then nil else tbl1.onActivated,
            selection = {
                Selectable = not bool1
            },
            testId = testId
        }
        local tbl7 = {
            Leading = React.createElement(View, {
                Size = UDim2.fromOffset(itemLayoutMetrics.avatarSize, itemLayoutMetrics.avatarSize),
                LayoutOrder = 1,
                testId = if leading.secondUserId then `{testId}--avatar-pile` else `{testId}--avatar`
            }, {
                Tile = if bool1 then React.createElement(Skeleton, { radius = Radius.Circle, testId = `{testId}--avatar-skeleton` }) else React.createElement(
                    UserTile2,
                    {
                        userId = leading.userId,
                        facePileSecondUserId = leading.secondUserId,
                        layoutMode = LayoutMode.compact,
                        userPresenceType = leading.userPresence
                    }
                )
            }),
            Content = 0
        }

        local createElement4 = React.createElement
        local var4 = View
        local tbl8 = { tag = "row align-y-center fill gap-medium auto-y", LayoutOrder = 2 }

        local tbl9 = { TextContainer = 0, Trailing = 0 }
        local createElement5 = React.createElement
        local var5 = View
        local tbl10 = { tag = "col fill gap-xsmall auto-y", LayoutOrder = 1 }

        local tbl11 = { Title = 0, Description = 0 }
        local element

        if bool1 then
            element = React.createElement(View, { tag = "size-full-500", LayoutOrder = 1 }, {
                Shimmer = React.createElement(
                    Skeleton,
                    {
                        Size = UDim2.new(0.5, 0, 1, 0),
                        radius = Radius.Small,
                        testId = `{testId}--title-skeleton`
                    }
                )
            })
        else
            element = React.createElement(FoundationText, {
                Text = tbl1.title,
                tag = "size-full-0 auto-y text-title-large text-wrap text-align-x-left content-emphasis",
                LayoutOrder = 1
            })
        end

        tbl11.Title = element
        local element2

        if bool1 then
            element2 = React.createElement(View, { tag = "size-full-400", LayoutOrder = 2 }, {
                Shimmer = React.createElement(
                    Skeleton,
                    {
                        Size = UDim2.new(0.3, 0, 1, 0),
                        radius = Radius.Small,
                        testId = `{testId}--description-skeleton`
                    }
                )
            })
        elseif tbl1.description == nil then
            element2 = nil
        else
            element2 = React.createElement(FoundationText, {
                Text = tbl1.description,
                tag = "size-full-0 auto-y text-body-medium text-align-x-left text-truncate-split",
                LayoutOrder = 2
            })
        end

        tbl11.Description = element2
        tbl9.TextContainer = createElement5(var5, tbl10, tbl11)

        tbl9.Trailing = if tbl1.trailing == nil or bool1 then nil else React.createElement(View, { tag = "align-x-center align-y-center auto-xy", LayoutOrder = 2 }, tbl1.trailing)
        tbl7.Content = createElement4(var4, tbl8, tbl9)
        tbl5.Row = createElement3(var3, tbl6, tbl7)
        tbl3.Wrapper = createElement2(var2, tbl4, tbl5)
        return createElement(var1, tbl2, tbl3)
    end
}
