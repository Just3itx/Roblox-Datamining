-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Colors = require(script.Parent.Colors)
local Constants = require(script.Parent.Parent.TopBar.Constants)

local tbl1 = {
    UseContainerAspectRatio = false,
    ContainerBackgroundTransparency = 0.3,
    ContainerBackgroundColor = Colors.Black,
    ContainerAspectRatio = 0.9,
    MaxAssetCardsPerRow = 4,
    ContainerSize = function(num1: number): UDim2
        return UDim2.new(0.7, 0, 0.95, -Constants.TopBarHeight * num1)
    end,
    ContainerAnchorPoint = Vector2.new(0.5, 0.5),
    ContainerPosition = function(num1: number): UDim2
        return UDim2.new(0.5, 0, 0.5, Constants.TopBarHeight * num1)
    end,
    AvatarHeadShotSize = 48,
    TopSizeY = 50,
    ClipsDescendants = true,
    PlayerViewportSize = UDim2.new(0.33, 0, 1, -42),
    AssetListSize = UDim2.new(0.67, 0, 1, -42),
    AssetListPosition = UDim2.new(0.33, 0, 0, 42),
    CloseButtonPosition = UDim2.new(0, 6, 0, -30),
    DetailsThumbnailFrameSize = UDim2.new(0.4, 0, 1, -30),
    DetailsThumbnailFramePosition = UDim2.new(0, 25, 0, 30),
    DetailsThumbnailAnchorPoint = Vector2.new(0.5, 0),
    DetailsThumbnailPosition = UDim2.new(0.5, 0, 0, 0),
    DetailsThumbnailARDominantAxis = Enum.DominantAxis.Width,
    DetailsFramePosition = UDim2.new(0.4, 30, 0, 30),
    DetailsFrameSize = UDim2.new(0.6, -30, 1, -30),
    AssetCardMaxSizeX = 190,
    AssetCardMaxSizeY = 279,
    DefaultCameraOffset = CFrame.new(0, 2, -5),
    ToolOffset = CFrame.new(0, 2, -8),
    TryOnPosition = UDim2.new(0, 25, 0, 30),
    TryOnSize = UDim2.new(0.4, 0, 1, -30),
    BorderPaddingSize = 40,
    AssetTextMaxSize = 18
}

setmetatable(tbl1, {
    __newindex = function(_, _, _) end,
    __index = function(_, arg1)
        error("WideView table has no value: " .. tostring(arg1))
    end
})

return tbl1
