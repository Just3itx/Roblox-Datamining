-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:20:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatformParent = script:FindFirstAncestor("ProfilePlatform").Parent

local React = require(ProfilePlatformParent.React)
local UIBlox = require(ProfilePlatformParent.UIBlox)

local PeekView = require(ProfilePlatformParent.PeekView)
local PeekViewState = PeekView.PeekViewState
local PeekView2 = PeekView.PeekView

local useStyle = UIBlox.Core.Style.useStyle

return function(tbl1)
    local var1 = useStyle()
    local var2, var3 = React.useState(0)

    local briefToFullTransitionPercent = React.useCallback(function(num1: number)
        var3(num1)
    end, {})

    local viewStateChanged = React.useCallback(function(closed, _)
        local onPeekViewClosed = tbl1.onPeekViewClosed
        if closed == PeekViewState.Closed and onPeekViewClosed then
            onPeekViewClosed()
        end
    end, { tbl1.onPeekViewClosed })

    local viewWidth = tbl1.viewWidth
    local uDim2 = UDim2.new(0, viewWidth, 1, 0)
    local topBarHeight = tbl1.topBarHeight
    local bool1 = var2 > 0.95
    local bool2 = var2 > 0 and not bool1
    return React.createElement(
        "Frame",
        {
            Position = UDim2.fromOffset(0, 0),
            Size = uDim2,
            BackgroundTransparency = 1,
            BorderSizePixel = 0
        },
        {
            PeekViewTopBar = if bool1 then tbl1.renderTopBar() else nil,
            PeekViewTopBarEffectHolder = if bool2 then React.createElement("Frame", {
                Size = UDim2.new(1, 0, 0, topBarHeight),
                Position = UDim2.new(0, 0, 0, 0),
                BackgroundColor3 = var1.Theme.BackgroundDefault.Color,
                BorderSizePixel = 0,
                BackgroundTransparency = 1 - var2
            }) else nil,
            PeekViewContainer = React.createElement("Frame", {
                Size = UDim2.new(1, 0, 1, -topBarHeight + 6),
                Position = UDim2.new(0, 0, 0, topBarHeight - 6),
                BackgroundTransparency = 1,
                ClipsDescendants = true
            }, {
                PeekView = React.createElement(PeekView2, {
                    briefViewContentHeight = tbl1.briefViewContentHeight,
                    bottomDockedContainerHeight = 0,
                    mountAsFullView = tbl1.mountAsFullView,
                    viewStateChanged = viewStateChanged,
                    briefToFullTransitionPercent = briefToFullTransitionPercent
                }, {
                    UIListLayout = React.createElement("UIListLayout", {
                        Padding = UDim.new(0, 0),
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        HorizontalAlignment = Enum.HorizontalAlignment.Left,
                        VerticalAlignment = Enum.VerticalAlignment.Top
                    }),
                    Content = tbl1.renderContent()
                })
            })
        }
    )
end
