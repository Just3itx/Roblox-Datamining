-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:01:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParentParent = scriptParent.Parent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent
local Roact = require(scriptParentParentParentParentParent.Roact)
local Cryo = require(scriptParentParentParentParentParent.Cryo)
local t = require(scriptParentParentParentParentParent.t)
local withStyle = require(scriptParentParentParentParent.Core.Style.withStyle)
local useStyleMetadata = require(scriptParentParentParentParent.Core.Style.useStyleMetadata)
local ImageSetComponent = require(scriptParentParentParentParent.Core.ImageSet.ImageSetComponent)
local LoadableImage = require(scriptParentParentParentParent.App.Loading.LoadableImage)
local TileSelectionOverlay = require(scriptParent.TileSelectionOverlay)
local TileUnselectedOverlay = require(scriptParent.TileUnselectedOverlay)

local var1 = Roact.PureComponent:extend("TileThumbnail")

var1.validateProps = t.strictInterface({
    hasRoundedCorners = t.optional(t.boolean),
    cornerRadius = t.optional(t.UDim),
    Image = t.optional(t.union(t.string, t.table)),
    imageSize = t.optional(t.UDim2),
    imageColor = t.optional(t.Color3),
    imageTransparency = t.optional(t.number),
    isSelected = t.optional(t.boolean),
    multiSelect = t.optional(t.boolean),
    overlayComponents = t.optional(t.table),
    backgroundImage = t.optional(t.union(t.string, t.table)),
    scaleType = t.optional(t.enum(Enum.ScaleType)),
    onThumbnailLoaded = t.optional(t.callback),
    hasSurfaceOverrides = t.optional(t.boolean)
})

var1.defaultProps = {
    imageSize = UDim2.fromScale(1, 1),
    imageTransparency = 0,
    cornerRadius = UDim.new(0, 10),
    scaleType = Enum.ScaleType.Stretch
}

function var1.render(arg1)
    local hasRoundedCorners = arg1.props.hasRoundedCorners
    local image = arg1.props.Image
    local imageSize = arg1.props.imageSize
    local imageColor = arg1.props.imageColor
    local imageTransparency = arg1.props.imageTransparency
    local isSelected = arg1.props.isSelected
    local multiSelect = arg1.props.multiSelect
    local overlayComponents = arg1.props.overlayComponents
    local backgroundImage = arg1.props.backgroundImage
    local cornerRadius = arg1.props.cornerRadius
    local scaleType = arg1.props.scaleType

    local bool1 = typeof(image) == "table"

    return withStyle(function(arg2)
        local theme = arg2.Theme
        local hasSurfaceOverrides = arg1.props.hasSurfaceOverrides
        local createElement = Roact.createElement
        local str1 = "Frame"
        local tbl1 = {
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1)
        }
        local tbl2 = {
            ImageContainer = 0,
            ComponentsFrame = 0,
            SelectionOverlay = 0,
            UnselectedOverlay = 0
        }
        local createElement2 = Roact.createElement
        local str2 = "Frame"
        local tbl3 = {
            BackgroundColor3 = theme.PlaceHolder.Color,
            BackgroundTransparency = theme.PlaceHolder.Transparency,
            BorderSizePixel = 0,
            Size = UDim2.fromScale(1, 1),
            ZIndex = 0
        }
        local tbl4 = {
            BackgroundImage = Roact.createElement(ImageSetComponent.Label, {
                Image = backgroundImage,
                ImageColor3 = if hasSurfaceOverrides then theme.BackgroundUIDefault.Color:Lerp(theme.PlayerBackgroundDefault.Color, theme.Overlay.Transparency) else nil,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.5),
                Size = UDim2.fromScale(1, 1),
                ZIndex = 0
            }, {
                ImageSetImage = bool1
                    and Roact.createElement(
                        ImageSetComponent.Label,
                        {
                            AnchorPoint = Vector2.new(0.5, 0.5),
                            BackgroundTransparency = 1,
                            Image = image,
                            ImageColor3 = imageColor or theme.UIEmphasis.Color,
                            ImageTransparency = imageTransparency,
                            Position = UDim2.fromScale(0.5, 0.5),
                            Size = imageSize,
                            ScaleType = scaleType
                        },
                        {
                            UICorner = hasRoundedCorners and Roact.createElement("UICorner", { CornerRadius = cornerRadius }) or nil
                        }
                    )
                    or Roact.createElement(LoadableImage, {
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        BackgroundColor3 = theme.PlaceHolder.Color,
                        BackgroundTransparency = 1,
                        Image = image,
                        Position = UDim2.fromScale(0.5, 0.5),
                        Size = imageSize,
                        cornerRadius = hasRoundedCorners and cornerRadius or nil,
                        showFailedStateWhenLoadingFailed = true,
                        useShimmerAnimationWhileLoading = true,
                        ScaleType = scaleType,
                        onLoaded = arg1.props.onThumbnailLoaded
                    }),
                UICorner = hasRoundedCorners and Roact.createElement("UICorner", { CornerRadius = cornerRadius }) or nil
            }),
            UICorner = hasRoundedCorners and Roact.createElement("UICorner", { CornerRadius = cornerRadius }) or nil
        }
        tbl2.ImageContainer = createElement2(str2, tbl3, tbl4)

        tbl2.ComponentsFrame = overlayComponents
            and Roact.createElement(
                "Frame",
                {
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    ZIndex = 1
                },
                overlayComponents
            )
        tbl2.SelectionOverlay = isSelected
            and Roact.createElement(TileSelectionOverlay, { ZIndex = 2, cornerRadius = hasRoundedCorners and cornerRadius or nil })

        tbl2.UnselectedOverlay = multiSelect and not isSelected and Roact.createElement(TileUnselectedOverlay, { ZIndex = 2 })
        return createElement(str1, tbl1, tbl2)
    end)
end

local function TileThumbnailFunctionalWrapper(arg1)
    local var2 = useStyleMetadata()

    return Roact.createElement(
        var1,
        Cryo.Dictionary.join(arg1, { hasSurfaceOverrides = if var2 then var2.HasSurfaceOverrides else false })
    )
end

return TileThumbnailFunctionalWrapper
