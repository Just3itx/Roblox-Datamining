-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:00:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Songbird = script:FindFirstAncestor("Songbird")

local Cryo = require(Songbird.Parent.Cryo)
local Foundation = require(Songbird.Parent.Foundation)
local React = require(Songbird.Parent.React)
local createNextOrder = require(Songbird.Parent.ReactUtils).createNextOrder

local MusicPlayingIcon = require(Songbird.Components.MusicPlayingIcon)

local tbl1 = { isMoving = true }

local function TrackingAudioIcon(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)
    local nextOrder = createNextOrder()

    local size900 = Foundation.Hooks.useTokens().Size.Size_900

    return React.createElement(Foundation.View, {
        Size = UDim2.fromOffset(size900, size900)
    }, {
        BaseIcon = React.createElement(
            Foundation.Image,
            {
                Image = "icons/common/musicTrackingBorder_medium",
                Size = UDim2.fromOffset(size900, size900),
                ZIndex = nextOrder()
            }
        ),
        CenterCover = React.createElement(Foundation.View, {
            Size = UDim2.fromOffset(size900 / 2, size900 / 2),
            Position = UDim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Transparency = 1,
            ZIndex = nextOrder()
        }, {
            Bars = React.createElement(
                MusicPlayingIcon,
                {
                    heightRange = NumberRange.new(0.25, 0.9),
                    numAnimatedBars = 4,
                    zIndex = nextOrder(),
                    isMoving = var1.isMoving
                }
            )
        })
    })
end
return TrackingAudioIcon
