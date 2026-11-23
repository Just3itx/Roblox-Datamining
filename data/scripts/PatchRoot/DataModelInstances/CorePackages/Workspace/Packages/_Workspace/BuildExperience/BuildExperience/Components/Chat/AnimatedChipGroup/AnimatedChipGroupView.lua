-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:31:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local Chip = Foundation.Chip
local ChipSize = Foundation.Enums.ChipSize
local Radius = Foundation.Enums.Radius
local ScrollView = Foundation.ScrollView
local Skeleton = Foundation.Skeleton
local View = Foundation.View
local Visibility = Foundation.Enums.Visibility

local function AnimatedChipSlot(tbl1)
    return React.createElement(View, {
        LayoutOrder = tbl1.index,
        tag = "auto-xy"
    }, {
        Skeleton = React.createElement(Skeleton, {
            LayoutOrder = tbl1.index,
            Position = UDim2.fromOffset(0, 0),
            radius = Radius.Circle,
            Size = UDim2.fromOffset(tbl1.tokens.Size.Size_2800, tbl1.tokens.Size.Size_800),
            Visible = tbl1.animationState.hasStarted:map(function(arg1): boolean
                return not arg1
            end),
            testId = `PromptChipGroup.Skeleton{tbl1.index}`
        }),
        Chip = React.createElement(View, {
            GroupTransparency = tbl1.animationState.groupTransparency,
            Visible = tbl1.animationState.hasStarted,
            tag = "auto-xy",
            testId = `PromptChipGroup.Fade{tbl1.index}`
        }, {
            Content = React.createElement(Chip, {
                leading = tbl1.chip.leading,
                onActivated = tbl1.chip.onActivated,
                size = ChipSize.Medium,
                text = tbl1.chip.text,
                testId = `PromptChipGroup.Chips--chip-{tbl1.index}`
            })
        })
    })
end

local function AnimatedChipGroupView(tbl1)
    local tbl2 = ({})
    for index, chip in tbl1.chips do
        local str1 = `Chip{index}`
        tbl2[str1] = React.createElement(
            AnimatedChipSlot,
            {
                animationState = tbl1.chipAnimationStates[index],
                chip = chip,
                index = index,
                tokens = tbl1.tokens
            }
        )
    end
    return React.createElement(
        View,
        {
            tag = "size-full-0 auto-y",
            ref = tbl1.chipGroupRef,
            testId = "PromptChipGroup.Chips"
        },
        {
            Scroll = React.createElement(ScrollView, {
                tag = "size-full-0 auto-y",
                layout = {
                    FillDirection = Enum.FillDirection.Horizontal,
                    Padding = UDim.new(0, tbl1.tokens.Padding.Small)
                },
                scroll = {
                    AutomaticSize = Enum.AutomaticSize.Y,
                    AutomaticCanvasSize = Enum.AutomaticSize.X,
                    CanvasSize = UDim2.fromScale(0, 1),
                    ScrollingDirection = Enum.ScrollingDirection.X,
                    scrollBarVisibility = Visibility.None
                }
            }, tbl2)
        }
    )
end

return AnimatedChipGroupView
