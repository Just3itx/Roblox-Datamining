-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:51:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Foundation = require(MomentsParent.Foundation)
local React = require(MomentsParent.React)

local FFlagMomentsCommentRowRedesign = require(Moments.Flags.FFlagMomentsCommentRowRedesign)
local FFlagMomentsCommentRowTrailingReaction = require(Moments.Flags.FFlagMomentsCommentRowTrailingReaction)
local getLineHeights = require(script.Parent.getLineHeights)

local Skeleton = Foundation.Skeleton
local View = Foundation.View

local Radius = Foundation.Enums.Radius
local useTokens = Foundation.Hooks.useTokens

local function CommentRowSkeletonView(tbl1)
    local var1 = useTokens()
    local size300 = var1.Size.Size_300
    local lineHeights = getLineHeights(if FFlagMomentsCommentRowRedesign then var1.Typography.TitleMedium else var1.Typography.TitleSmall)
    local var2 = if FFlagMomentsCommentRowRedesign then var1.Size.Size_800 else var1.Size.Size_700
    local var3, var4 = getLineHeights(var1.Typography.BodyMedium)

    local tbl2 = ({})
    for layoutOrder, bodyLineWidth in tbl1.bodyLineWidths do
        local str1 = `Line{layoutOrder}`
        local createElement = React.createElement
        local var5 = View
        local tbl3 = {
            LayoutOrder = layoutOrder,
            Size = UDim2.new(1, 0, 0, if layoutOrder == 1 then var3 else var4),
            tag = "row align-y-center"
        }
        local tbl4 = {
            Bar = React.createElement(Skeleton, {
                Size = UDim2.new(bodyLineWidth, 0, 0, size300),
                radius = Radius.Medium,
                testId = `{tbl1.testId}--body-line-{layoutOrder}`
            })
        }
        tbl2[str1] = createElement(var5, tbl3, tbl4)
    end

    local createElement = React.createElement
    local var5 = View
    local tbl3 = {
        LayoutOrder = tbl1.LayoutOrder,
        tag = {
            ["row gap-medium size-full-0 auto-y padding-top-small"] = true,
            ["padding-bottom-small"] = FFlagMomentsCommentRowRedesign
        },
        testId = tbl1.testId
    }
    local tbl4 = {
        Avatar = React.createElement(Skeleton, {
            LayoutOrder = 1,
            Size = UDim2.fromOffset(var2, var2),
            radius = Radius.Circle,
            testId = `{tbl1.testId}--avatar`
        }),
        TextColumn = 0,
        Trailing = 0
    }
    local createElement2 = React.createElement
    local var6 = View
    local tbl5 = {
        LayoutOrder = 2,
        tag = {
            ["col fill auto-y"] = true,
            ["gap-xsmall"] = FFlagMomentsCommentRowRedesign,
            ["gap-small"] = not FFlagMomentsCommentRowRedesign
        }
    }
    local tbl6 = { MainContent = 0, Reaction = 0, Footer = 0 }
    local createElement3 = React.createElement
    local var7 = View
    local tbl7 = {
        LayoutOrder = 1,
        tag = {
            ["col size-full-0 auto-y"] = true,
            ["gap-xxsmall"] = FFlagMomentsCommentRowRedesign,
            ["gap-xsmall"] = not FFlagMomentsCommentRowRedesign
        }
    }
    local tbl8 = {
        Header = React.createElement(
            View,
            {
                LayoutOrder = 1,
                Size = UDim2.new(1, 0, 0, lineHeights),
                tag = "row align-y-center gap-medium"
            },
            {
                Author = React.createElement(Skeleton, {
                    LayoutOrder = 1,
                    Size = UDim2.fromOffset(tbl1.authorWidth, size300),
                    radius = Radius.Medium,
                    testId = `{tbl1.testId}--author`
                }),
                Timestamp = if FFlagMomentsCommentRowRedesign then nil else React.createElement(Skeleton, {
                    LayoutOrder = 2,
                    Size = UDim2.fromOffset(tbl1.timestampWidth, size300),
                    radius = Radius.Medium,
                    testId = `{tbl1.testId}--timestamp`
                })
            }
        ),
        Body = React.createElement(View, { LayoutOrder = 2, tag = "col size-full-0 auto-y" }, tbl2)
    }
    tbl6.MainContent = createElement3(var7, tbl7, tbl8)
    local element

    if FFlagMomentsCommentRowRedesign then
        element = nil
    else
        element = React.createElement(View, {
            LayoutOrder = 2,
            tag = "row align-y-center gap-xsmall auto-xy padding-bottom-small",
            testId = `{tbl1.testId}--reaction`
        }, {
            Icon = React.createElement(
                Skeleton,
                {
                    LayoutOrder = 1,
                    Size = UDim2.fromOffset(var1.Size.Size_500, var1.Size.Size_500),
                    radius = Radius.Circle
                }
            ),
            Count = React.createElement(
                Skeleton,
                {
                    LayoutOrder = 2,
                    Size = UDim2.fromOffset(var1.Size.Size_400, size300),
                    radius = Radius.Medium
                }
            )
        })
    end

    tbl6.Reaction = element
    local var8

    if FFlagMomentsCommentRowRedesign then
        local createElement4 = React.createElement
        local var9 = View
        local tbl9 = {
            LayoutOrder = 2,
            Size = UDim2.new(1, 0, 0, var1.Size.Size_600),
            tag = "row align-y-center gap-small",
            testId = `{tbl1.testId}--footer`
        }
        local tbl10 = {
            Timestamp = React.createElement(View, {
                LayoutOrder = 1,
                tag = "row align-y-center fill auto-y"
            }, {
                Bar = React.createElement(Skeleton, {
                    Size = UDim2.fromOffset(tbl1.timestampWidth, size300),
                    radius = Radius.Medium,
                    testId = `{tbl1.testId}--timestamp`
                })
            }),
            Reaction = 0
        }
        local element2

        if FFlagMomentsCommentRowTrailingReaction then
            element2 = nil
        else
            element2 = React.createElement(View, {
                LayoutOrder = 2,
                tag = "row align-y-center gap-xsmall auto-xy padding-right-small",
                testId = `{tbl1.testId}--reaction`
            }, {
                Icon = React.createElement(
                    Skeleton,
                    {
                        LayoutOrder = 1,
                        Size = UDim2.fromOffset(var1.Size.Size_400, var1.Size.Size_400),
                        radius = Radius.Circle
                    }
                ),
                Count = React.createElement(Skeleton, {
                    LayoutOrder = 2,
                    Size = UDim2.fromOffset(var1.Size.Size_400, size300),
                    radius = Radius.Medium,
                    testId = `{tbl1.testId}--reaction-count`
                })
            })
        end

        tbl10.Reaction = element2
        var8 = createElement4(var9, tbl9, tbl10)
    else
        var8 = nil
    end

    tbl6.Footer = var8
    tbl4.TextColumn = createElement2(var6, tbl5, tbl6)
    local element2

    if FFlagMomentsCommentRowTrailingReaction then
        element2 = React.createElement(
            View,
            { LayoutOrder = 3, tag = "col align-x-right align-y-center self-stretch auto-x" },
            {
                Reaction = React.createElement(View, {
                    tag = "row align-y-center gap-xsmall auto-xy",
                    padding = {
                        right = UDim.new(0, (var1.Size.Size_600 - var1.Size.Size_400) / 2)
                    },
                    testId = `{tbl1.testId}--reaction`
                }, {
                    Icon = React.createElement(
                        Skeleton,
                        {
                            LayoutOrder = 1,
                            Size = UDim2.fromOffset(var1.Size.Size_400, var1.Size.Size_400),
                            radius = Radius.Circle
                        }
                    ),
                    Count = React.createElement(Skeleton, {
                        LayoutOrder = 2,
                        Size = UDim2.fromOffset(var1.Size.Size_400, size300),
                        radius = Radius.Medium,
                        testId = `{tbl1.testId}--reaction-count`
                    })
                })
            }
        )
    else
        element2 = nil
    end

    tbl4.Trailing = element2
    return createElement(var5, tbl3, tbl4)
end

return CommentRowSkeletonView
