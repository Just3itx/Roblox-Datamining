-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:30:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent
local React = require(ServerDrivenUiParent.React)
local _Foundation = require(ServerDrivenUiParent.Foundation)
local LoadableImage = require(ServerDrivenUiParent.UIBlox).App.Loading.LoadableImage

return React.memo(function(tbl1) -- name: SduiTileInsetImage
    local yOffset = if tbl1.isContained then tbl1.cardCornerRadius else 0

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        [React.Tag] = if tbl1.testId then `data-testid={tbl1.testId}` else nil,
        Size = UDim2.new(1, 0, 1, yOffset),
        BorderSizePixel = 0,
        ClipsDescendants = true,
        BackgroundColor3 = if tbl1.backgroundStyle then tbl1.backgroundStyle.Color3 else nil,
        BackgroundTransparency = if tbl1.backgroundStyle then tbl1.backgroundStyle.Transparency else 1,
        ZIndex = -3
    }
    local tbl3 = {
        UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, tbl1.cardCornerRadius) }),
        ThumbnailFrame = 0
    }
    local createElement2 = React.createElement
    local str2 = "Frame"
    local tbl4 = {
        Size = UDim2.new(1, tbl1.imagePadding * -2, 1, tbl1.imagePadding * -2 - yOffset),
        Position = UDim2.fromOffset(tbl1.imagePadding, tbl1.imagePadding),
        BackgroundTransparency = 1
    }
    local tbl5 = { Thumbnail = 0 }
    local var1

    if tbl1.imageComponent then
        var1 = tbl1.imageComponent
    elseif tbl1.image then
        var1 = React.createElement(LoadableImage, {
            BackgroundTransparency = 1,
            Image = tbl1.image,
            Size = UDim2.new(1, 0, 1, 0),
            cornerRadius = UDim.new(0, tbl1.imageCornerRadius),
            showFailedStateWhenLoadingFailed = true,
            useShimmerAnimationWhileLoading = true
        })
    else
        var1 = nil
    end

    tbl5.Thumbnail = var1
    tbl3.ThumbnailFrame = createElement2(str2, tbl4, tbl5)
    return createElement(str1, tbl2, tbl3)
end)
