-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:21:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationFlow = script:FindFirstAncestor("MomentsCreationFlow")
local MomentsCreationFlowParent = MomentsCreationFlow.Parent

local Foundation = require(MomentsCreationFlowParent.Foundation)
local MomentsCommon = require(MomentsCreationFlowParent.MomentsCommon)
local React = require(MomentsCreationFlowParent.React)

local FoundationText = Foundation.Text
local View = Foundation.View

local useTokens = Foundation.Hooks.useTokens

local getFormatTime = MomentsCommon.Utils.getFormatTime

local DragHandle = require(MomentsCreationFlow.Enums.DragHandle)

return function(tbl1)
    local var1 = useTokens()

    if tbl1.activeHandle ~= DragHandle.LeftHandle and tbl1.activeHandle ~= DragHandle.RightHandle or not tbl1.timeLength then
        return nil
    end

    local var2 = if tbl1.activeHandle == DragHandle.LeftHandle then tbl1.leftHandlePosition elseif tbl1.activeHandle == DragHandle.RightHandle then tbl1.rightHandlePosition else nil

    return React.createElement(View, {
        tag = "align-x-center align-y-bottom anchor-bottom-center col gap-xsmall",
        Position = var2:map(function(xScale: number?): UDim2
            return UDim2.new(xScale, 0, 0, -var1.Padding.Small)
        end)
    }, {
        TextContainer = React.createElement(
            View,
            {
                tag = "anchor-center-center bg-system-contrast size-1600-800 radius-small",
                LayoutOrder = 1
            },
            {
                TimeText = React.createElement(FoundationText, {
                    tag = "anchor-center-center auto-xy content-inverse-default position-center-center text-caption-medium",
                    Text = var2:map(function(arg1)
                        return getFormatTime(arg1 * tbl1.timeLength)
                    end)
                })
            }
        ),
        VerticalBar = React.createElement(View, { tag = "anchor-center-center bg-system-contrast size-50-300", LayoutOrder = 2 })
    })
end
