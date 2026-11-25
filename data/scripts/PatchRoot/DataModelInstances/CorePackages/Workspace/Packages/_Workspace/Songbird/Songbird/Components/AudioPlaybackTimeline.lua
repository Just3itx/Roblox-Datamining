-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:51:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Songbird = script:FindFirstAncestor("Songbird")

local React = require(Songbird.Parent.React)
local Foundation = require(Songbird.Parent.Foundation)
local ReactUtils = require(Songbird.Parent.ReactUtils)

local ProgressCountdown = require(Songbird.Components.ProgressCountdown)

local createNextOrder = ReactUtils.createNextOrder

local function AudioPlaybackTimeline(tbl1)
    local nextOrder = createNextOrder()

    return React.createElement(
        Foundation.View,
        {
            tag = "size-full-0 auto-y row flex-between align-y-center gap-large",
            LayoutOrder = tbl1.LayoutOrder
        },
        {
            TimeElapsed = React.createElement(
                ProgressCountdown,
                {
                    timeLength = tbl1.duration,
                    timePosition = tbl1.elapsed,
                    counterType = "Elapsed",
                    LayoutOrder = nextOrder()
                }
            ),
            ProgressBar = React.createElement(
                Foundation.View,
                {
                    tag = "size-full-0 auto-y shrink padding-top-xxsmall",
                    LayoutOrder = nextOrder()
                },
                {
                    Slider = React.createElement(Foundation.Slider, {
                        value = tbl1.elapsed:map(function(num1: number)
                            return if tbl1.duration > 0 then num1 / tbl1.duration else 0
                        end),
                        onValueChanged = tbl1.onDragTimeline,
                        onDragStarted = tbl1.onDragTimelineStart,
                        onDragEnded = tbl1.onDragTimelineEnd,
                        size = Foundation.Enums.InputSize.Medium,
                        knobVisibility = Foundation.Enums.ScrollBarVisibility.Auto,
                        variant = Foundation.Enums.SliderVariant.Standard
                    })
                }
            ),
            TimeRemaining = React.createElement(
                ProgressCountdown,
                {
                    timeLength = tbl1.duration,
                    timePosition = tbl1.elapsed,
                    LayoutOrder = nextOrder()
                }
            )
        }
    )
end

return AudioPlaybackTimeline
