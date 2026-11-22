-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local Foundation = require(MomentsCreationParent.Foundation)
local React = require(MomentsCreationParent.React)

local FoundationText = Foundation.Text
local View = Foundation.View

local useTokens = Foundation.Hooks.useTokens

local getFormatTime = require(MomentsCreation.Utils.getFormatTime)

local DragHandle = require(MomentsCreation.Enums.DragHandle)

return function(tbl1)
    local var1 = useTokens()

    if tbl1.activeHandle ~= DragHandle.LeftHandle and tbl1.activeHandle ~= DragHandle.RightHandle or not tbl1.timeLength then
        return nil
    end

    local var2 = if tbl1.activeHandle == DragHandle.LeftHandle then tbl1.leftHandlePosition elseif tbl1.activeHandle == DragHandle.RightHandle then tbl1.rightHandlePosition else nil

    if var2 == nil then
        return nil
    end

    local timeLength = tbl1.timeLength

    return React.createElement(View, {
        tag = "col align-x-center align-y-bottom gap-xsmall anchor-bottom-center",
        Position = var2:map(function(xScale: number): UDim2
            return UDim2.new(xScale, 0, 0, -var1.Padding.Small)
        end)
    }, {
        TextContainer = React.createElement(
            View,
            {
                tag = "anchor-center-center size-1600-800 radius-small bg-system-contrast",
                LayoutOrder = 1
            },
            {
                TimeText = React.createElement(FoundationText, {
                    tag = "position-center-center anchor-center-center auto-xy text-caption-medium content-inverse-default",
                    Text = var2:map(function(num1: number)
                        return getFormatTime(num1 * timeLength)
                    end)
                })
            }
        ),
        VerticalBar = React.createElement(View, { tag = "anchor-center-center size-50-300 bg-system-contrast", LayoutOrder = 2 })
    })
end
