-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:21:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local _Foundation = require(ServerDrivenUiParent.Foundation)
local React = require(ServerDrivenUiParent.React)
local LoadableImage = require(ServerDrivenUiParent.UIBlox).App.Loading.LoadableImage

local function SduiDefaultTileImage(tbl1)
    return React.createElement(LoadableImage, {
        BackgroundColor3 = if tbl1.thumbnailBackgroundStyle then tbl1.thumbnailBackgroundStyle.Color3 or nil else nil,
        BackgroundTransparency = tbl1.thumbnailBackgroundStyle and tbl1.thumbnailBackgroundStyle.Transparency or 1,
        Image = tbl1.image,
        Size = UDim2.new(1, 0, 1, if tbl1.isContained then tbl1.cardCornerRadius else 0),
        cornerRadius = UDim.new(0, tbl1.cardCornerRadius),
        showFailedStateWhenLoadingFailed = true,
        useShimmerAnimationWhileLoading = true,
        ZIndex = -2,
        ScaleType = if tbl1.isContained then Enum.ScaleType.Tile else nil,
        TileSize = if tbl1.isContained then UDim2.new(1, 0, 1, -tbl1.cardCornerRadius) else nil
    })
end

return SduiDefaultTileImage
