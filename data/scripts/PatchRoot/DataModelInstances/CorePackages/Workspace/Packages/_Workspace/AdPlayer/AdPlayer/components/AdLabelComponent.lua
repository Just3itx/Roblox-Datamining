-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:30:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AdPlayerParent = script:FindFirstAncestor("AdPlayer").Parent
local React = require(AdPlayerParent.React)
local Foundation = require(AdPlayerParent.Foundation)
local FoundationText = Foundation.Text
local View = Foundation.View
local Image = Foundation.Image
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance

return function(tbl1)
    local visible = tbl1.Visible
    local image = tbl1.Image

    return React.createElement(
        View,
        {
            tag = "position-center-left anchor-center-left size-900-500 row align-x-center align-y-center gap-xsmall"
        },
        {
            adText = React.createElement(
                FoundationText,
                {
                    tag = "size-400 content-emphasis text-body-small",
                    Text = "Ad",
                    TextScaled = true,
                    Visible = visible
                }
            ),
            icon = React.createElement(Image, {
                tag = "size-300",
                Image = image,
                LayoutOrder = 2,
                onActivated = tbl1.handleToggleAdsModal,
                Visible = visible,
                stateLayer = {
                    affordance = StateLayerAffordance.None
                }
            })
        }
    )
end
