-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:31:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local Skeleton = Foundation.Skeleton
local View = Foundation.View

local Radius = Foundation.Enums.Radius
local useTokens = Foundation.Hooks.useTokens

local function ChatHistoryLoadingState()
    local var1 = useTokens()

    return React.createElement(
        View,
        {
            Size = UDim2.fromScale(1, 1),
            tag = "col gap-xlarge",
            testId = "ChatHistoryLoadingState"
        },
        {
            UserMessage = React.createElement(View, {
                LayoutOrder = 1,
                tag = "row size-full-0 auto-y"
            }, {
                Spacer = React.createElement(View, { LayoutOrder = 1, tag = "fill" }),
                Bubble = React.createElement(Skeleton, {
                    LayoutOrder = 2,
                    Size = UDim2.new(0.68, 0, 0, var1.Size.Size_1200),
                    radius = Radius.Large,
                    testId = "ChatHistoryLoadingState.UserMessage"
                })
            }),
            AgentResponse = React.createElement(View, {
                LayoutOrder = 2,
                tag = "col gap-small size-full-0 auto-y"
            }, {
                Line1 = React.createElement(Skeleton, {
                    LayoutOrder = 1,
                    Size = UDim2.new(0.92, 0, 0, var1.Size.Size_300),
                    radius = Radius.Small,
                    testId = "ChatHistoryLoadingState.AgentLine1"
                }),
                Line2 = React.createElement(Skeleton, {
                    LayoutOrder = 2,
                    Size = UDim2.new(0.78, 0, 0, var1.Size.Size_300),
                    radius = Radius.Small,
                    testId = "ChatHistoryLoadingState.AgentLine2"
                }),
                Line3 = React.createElement(Skeleton, {
                    LayoutOrder = 3,
                    Size = UDim2.new(0.54, 0, 0, var1.Size.Size_300),
                    radius = Radius.Small,
                    testId = "ChatHistoryLoadingState.AgentLine3"
                })
            }),
            PlaytestCard = React.createElement(Skeleton, {
                LayoutOrder = 3,
                Size = UDim2.new(1, 0, 0, var1.Size.Size_2400 + var1.Size.Size_800),
                radius = Radius.Medium,
                testId = "ChatHistoryLoadingState.PlaytestCard"
            })
        }
    )
end

return ChatHistoryLoadingState
