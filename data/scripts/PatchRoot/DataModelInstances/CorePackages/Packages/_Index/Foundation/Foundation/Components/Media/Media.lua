-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:21:00Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Image = require(Foundation.Components.Image)

local MediaAspectRatio = require(Foundation.Enums.MediaAspectRatio)

local MediaOrientation = require(Foundation.Enums.MediaOrientation)

local _Types = require(Foundation.Components.Types)

local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local tbl1 = {
    [MediaAspectRatio.Ratio1x1] = 1,
    [MediaAspectRatio.Ratio5x4] = 1.25,
    [MediaAspectRatio.Ratio4x3] = 4 / 3,
    [MediaAspectRatio.Ratio3x2] = 1.5,
    [MediaAspectRatio.Ratio16x9] = 16 / 9,
    [MediaAspectRatio.Ratio2x1] = 2
}

local tbl2 = {
    aspectRatio = MediaAspectRatio.Ratio1x1,
    orientation = MediaOrientation.Landscape,
    testId = "--foundation-media"
}

return React.memo(function(arg1) -- name: Media
    local var1 = withDefaults(arg1, tbl2)

    local aspectRatio = React.useMemo(function()
        local var2 = tbl1[var1.aspectRatio]

        if var1.orientation == MediaOrientation.Portrait then
            var2 = 1 / var2
        end

        return {
            AspectRatio = var2,
            AspectType = Enum.AspectType.ScaleWithParentSize,
            DominantAxis = Enum.DominantAxis.Width
        }
    end, { var1.aspectRatio, var1.orientation })

    local content = var1.content
    local source = if content and content.type == "Image" then content.source else nil
    return React.createElement(
        Image,
        withCommonProps(
            var1,
            {
                Image = source,
                ScaleType = Enum.ScaleType.Crop,
                Size = UDim2.fromScale(1, 0),
                aspectRatio = aspectRatio
            }
        )
    )
end)
