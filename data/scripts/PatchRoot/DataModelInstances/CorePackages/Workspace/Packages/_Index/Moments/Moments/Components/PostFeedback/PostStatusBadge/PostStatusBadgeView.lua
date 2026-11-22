-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:31:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Foundation = require(MomentsParent.Foundation)
local React = require(MomentsParent.React)

local FoundationProvider = Foundation.FoundationProvider
local FoundationText = Foundation.Text
local View = Foundation.View

local ColorMode = Foundation.Enums.ColorMode

local function PostStatusBadgeView(tbl1)
    return React.createElement(View, {
        tag = "position-top-left anchor-top-left auto-xy padding-small",
        ZIndex = tbl1.ZIndex,
        testId = "moments-post-status-badge"
    }, {
        DarkScope = React.createElement(FoundationProvider, {
            colorMode = ColorMode.Dark
        }, {
            Pill = React.createElement(
                View,
                {
                    tag = "row align-y-center size-0-600 auto-x padding-x-small radius-circle bg-over-media-300"
                },
                {
                    Label = React.createElement(FoundationText, { tag = "auto-xy text-caption-medium content-emphasis", Text = tbl1.label })
                }
            )
        })
    })
end

return PostStatusBadgeView
