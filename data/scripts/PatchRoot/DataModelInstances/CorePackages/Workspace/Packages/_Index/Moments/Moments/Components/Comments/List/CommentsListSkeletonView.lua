-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:50:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Foundation = require(MomentsParent.Foundation)
local React = require(MomentsParent.React)

local CommentRowSkeletonView = require(script.Parent.Rows.CommentRowSkeletonView)

local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens

local function getRowShapes(arg1)
    local size = arg1.Size
    return {
        {
            authorWidth = size.Size_2400,
            timestampWidth = size.Size_500,
            bodyLineWidths = { 1, 0.62 }
        },
        {
            authorWidth = size.Size_1600,
            timestampWidth = size.Size_600,
            bodyLineWidths = { 0.45 }
        },
        {
            authorWidth = size.Size_2800,
            timestampWidth = size.Size_500,
            bodyLineWidths = { 0.96, 1, 0.38 }
        },
        {
            authorWidth = size.Size_2000,
            timestampWidth = size.Size_700,
            bodyLineWidths = { 0.8 }
        },
        {
            authorWidth = size.Size_2600,
            timestampWidth = size.Size_500,
            bodyLineWidths = { 1, 0.5 }
        },
        {
            authorWidth = size.Size_1800,
            timestampWidth = size.Size_600,
            bodyLineWidths = { 0.3 }
        },
        {
            authorWidth = size.Size_2200,
            timestampWidth = size.Size_500,
            bodyLineWidths = { 0.97, 0.72 }
        },
        {
            authorWidth = size.Size_3000,
            timestampWidth = size.Size_600,
            bodyLineWidths = { 0.55 }
        }
    }
end

local function CommentsListSkeletonView(tbl1)
    local var1 = useTokens()

    local tbl2 = ({})
    for layoutOrder, value2 in getRowShapes(var1) do
        local str1 = `Row{layoutOrder}`
        tbl2[str1] = React.createElement(CommentRowSkeletonView, {
            LayoutOrder = layoutOrder,
            authorWidth = value2.authorWidth,
            timestampWidth = value2.timestampWidth,
            bodyLineWidths = value2.bodyLineWidths,
            testId = `{tbl1.testId}--row-{layoutOrder}`
        })
    end

    return React.createElement(View, { LayoutOrder = tbl1.LayoutOrder, tag = "col size-full clip", testId = tbl1.testId }, tbl2)
end

return CommentsListSkeletonView
