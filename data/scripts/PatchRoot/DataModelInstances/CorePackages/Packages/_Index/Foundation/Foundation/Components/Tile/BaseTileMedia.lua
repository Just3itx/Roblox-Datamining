-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T09:01:38Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local TileAspectRatio = require(Foundation.Enums.TileAspectRatio)
local _Types = require(Foundation.Components.Types)
local getTestIdTag = require(Foundation.Utility.getTestIdTag)
local mapBindable = require(Foundation.Utility.mapBindable)
local useTokens = require(Foundation.Providers.Style.useTokens)

local tbl1 = {
    [TileAspectRatio.Ratio1x1] = 1,
    [TileAspectRatio.Ratio16x9] = 16 / 9,
    [TileAspectRatio.Ratio2x3] = 2 / 3
}

local uDim2 = UDim2.fromScale(1, 1)
local uDim = UDim.new(0, 0)

return React.memo(function(tbl2) -- name: BaseTileMedia
    local var1 = useTokens()

    local aspectRatio = tbl1[tbl2.aspectRatio]
    local tileSize = if typeof(tbl2.tileSize) == "UDim2" then tbl2.tileSize else nil
    local offset = if tileSize == nil or tileSize.X.Scale ~= 0 then nil else tileSize.X.Offset
    local uDim2_2 = if offset ~= nil then UDim2.fromOffset(offset, offset / aspectRatio) else uDim2

    local var3 = if tbl2.maxHeight == nil then uDim2_2 else tbl2.maxHeight:map(function(yOffset: number?)
        if yOffset ~= nil then
            return UDim2.new(1, 0, 0, yOffset)
        end

        return uDim2_2
    end)

    local uDim3 = UDim.new(0, var1.Radius.Medium)
    local uDim4 = if tbl2.isContained then uDim else uDim3
    local createElement = React.createElement
    local str1 = if tbl2.content == nil then "Frame" else "CanvasGroup"

    local tbl3 = {
        BackgroundColor3 = mapBindable(tbl2.backgroundStyle, function(arg1)
            return arg1.Color3
        end),
        BackgroundTransparency = mapBindable(tbl2.backgroundStyle, function(arg1)
            return arg1.Transparency
        end),
        BorderSizePixel = 0,
        ClipsDescendants = true,
        LayoutOrder = tbl2.LayoutOrder,
        Size = var3,
        [React.Tag] = getTestIdTag(tbl2.testId)
    }

    local tbl4 = {
        Corner = React.createElement("UICorner", {
            TopLeftRadius = uDim3,
            TopRightRadius = uDim3,
            BottomLeftRadius = uDim4,
            BottomRightRadius = uDim4,
            [React.Tag] = getTestIdTag(`{tbl2.testId}--corner`)
        }),
        AspectRatio = if offset == nil or tbl2.maxHeight ~= nil then React.createElement(
            "UIAspectRatioConstraint",
            {
                AspectRatio = aspectRatio,
                AspectType = Enum.AspectType.FitWithinMaxSize,
                DominantAxis = Enum.DominantAxis.Width
            }
        ) else nil,
        Content = tbl2.content
    }
    return createElement(str1, tbl3, tbl4)
end)
