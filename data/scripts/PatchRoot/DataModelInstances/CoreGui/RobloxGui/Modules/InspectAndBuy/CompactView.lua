-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Colors = require(script.Parent.Colors)
local Constants = require(script.Parent.Parent.TopBar.Constants)

local tbl1 = {
    ContainerBackgroundTransparency = 0,
    ContainerBackgroundColor = Colors.Carbon,
    UseContainerAspectRatio = false,
    ContainerAspectRatio = nil,
    MaxAssetCardsPerRow = 3,
    ContainerSize = function(num1: number): UDim2
        return UDim2.new(1, 0, 1, -Constants.TopBarHeight * num1)
    end,
    ContainerAnchorPoint = Vector2.new(0.5, 0),
    ContainerPosition = function(num1: number): UDim2
        return UDim2.new(0.5, 0, 0, Constants.TopBarHeight * num1)
    end,
    AvatarHeadShotSize = 48,
    TopSizeY = 90,
    ClipsDescendants = false,
    PlayerViewportSize = UDim2.new(1, 0, 0.41, 0),
    AssetListSize = UDim2.new(1, 0, 0.59, -42),
    AssetListPosition = UDim2.new(0, 0, 0.41, 42),
    CloseButtonPosition = UDim2.new(0, 6, 0, -20),
    DetailsThumbnailFrameSize = UDim2.new(1, 0, 0.4, 0),
    DetailsThumbnailFramePosition = UDim2.new(0, 0, 0, 15),
    DetailsThumbnailAnchorPoint = Vector2.new(0.5, 0.5),
    DetailsThumbnailPosition = UDim2.new(0.5, 0, 0.5, 0),
    DetailsThumbnailARDominantAxis = Enum.DominantAxis.Height,
    DetailsFramePosition = UDim2.new(0, 15, 0.4, 15),
    DetailsFrameSize = UDim2.new(1, -30, 0.6, -30),
    AssetCardMaxSizeX = 108,
    AssetCardMaxSizeY = 157,
    DefaultCameraOffset = CFrame.new(0, 2, -5),
    ToolOffset = CFrame.new(0, 2, -8),
    TryOnPosition = UDim2.new(0, 0, 0, 15),
    TryOnSize = UDim2.new(1, 0, 0.4, 0),
    BorderPaddingSize = 20,
    AssetTextMaxSize = 14
}

setmetatable(tbl1, {
    __newindex = function(_, _, _) end,
    __index = function(_, arg1)
        error("CompactView table has no value: " .. tostring(arg1))
    end
})

return tbl1
