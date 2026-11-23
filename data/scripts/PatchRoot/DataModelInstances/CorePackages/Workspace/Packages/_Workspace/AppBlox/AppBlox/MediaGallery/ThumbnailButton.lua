-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:30:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent
local Roact = require(AppBloxParent.Roact)
local t = require(AppBloxParent.t)

local UIBlox = require(AppBloxParent.UIBlox)
local Button = UIBlox.App.Button.Button
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local ControlState = UIBlox.Core.Control.Enum.ControlState
local IconSize = UIBlox.App.ImageSet.Enum.IconSize
local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local Interactable = UIBlox.Core.Control.Interactable
local LoadableImage = UIBlox.App.Loading.LoadableImage
local getIconSize = UIBlox.App.ImageSet.getIconSize
local withStyle = UIBlox.Core.Style.withStyle

local HoverButtonBackground = require(script.Parent.HoverButtonBackground)

local iconSize = getIconSize(IconSize.Large)

local uDim2 = UDim2.fromScale(0.4, 0.512)
local uDim2_2 = UDim2.fromOffset(64, 48)
local uDim2_3 = UDim2.fromScale(0.25, 0.33)

local var1 = Roact.Component:extend("ThumbnailButton")

var1.validateProps = t.strictInterface({
    layoutOrder = t.optional(t.number),
    size = t.optional(t.UDim2),
    anchorPoint = t.optional(t.Vector2),
    position = t.optional(t.UDim2),
    itemKey = t.any,
    imageId = t.optional(t.string),
    isVideo = t.optional(t.boolean),
    useScaledPlayButton = t.optional(t.boolean),
    isSelected = t.optional(t.boolean),
    userInteractionEnabled = t.optional(t.boolean),
    onActivated = t.optional(t.callback),
    onPlayActivated = t.optional(t.callback)
})

var1.defaultProps = {
    size = UDim2.fromScale(1, 1),
    imageId = "",
    isVideo = false,
    isSelected = false,
    userInteractionEnabled = true
}

function var1.init(arg1)
    arg1:setState({ controlState = ControlState.Initialize })

    function arg1.onStateChanged(_, controlState)
        arg1:setState({ controlState = controlState })
    end

    function arg1.onActivated()
        if arg1.props.onActivated then
            arg1.props.onActivated(arg1.props.itemKey)
        end
    end

    function arg1.onPlayActivated()
        if arg1.props.onPlayActivated then
            arg1.props.onPlayActivated(arg1.props.itemKey)
        end
    end
end

function var1.renderButton(arg1)
    local useScaledPlayButton = arg1.props.useScaledPlayButton
    local uDim2_4 = if useScaledPlayButton then uDim2 else uDim2_2

    return withStyle(function(arg2)
        local layoutOrder = arg1.props.layoutOrder
        local anchorPoint = arg1.props.anchorPoint
        local position = arg1.props.position
        local size = arg1.props.size
        local isSelected = arg1.props.isSelected
        local imageId = arg1.props.imageId
        local isVideo = arg1.props.isVideo
        local userInteractionEnabled = arg1.props.userInteractionEnabled

        local bool1 = arg1.state.controlState == ControlState.Hover
        local var2 = isSelected and arg2.Theme.BackgroundDefault or arg2.Theme.BackgroundUIDefault

        local createElement = Roact.createElement
        local var3 = Interactable
        local tbl1 = {
            LayoutOrder = layoutOrder,
            Size = size,
            AnchorPoint = anchorPoint,
            Position = position,
            AutoButtonColor = false,
            BackgroundColor3 = var2.Color,
            BackgroundTransparency = var2.Transparency,
            onStateChanged = arg1.onStateChanged,
            userInteractionEnabled = userInteractionEnabled,
            [Roact.Event.Activated] = arg1.onActivated
        }
        local tbl2 = {
            Corner = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, 8) }),
            Tile = Roact.createElement(LoadableImage, {
                Size = UDim2.fromScale(1, 1),
                cornerRadius = UDim.new(0, 8),
                Image = imageId,
                useShimmerAnimationWhileLoading = true,
                ZIndex = -1
            }),
            PlayButton = if isVideo then Roact.createElement(Button, {
                buttonType = ButtonType.PrimaryContextual,
                size = uDim2_4,
                anchorPoint = Vector2.new(0.5, 0.5),
                position = UDim2.fromScale(0.5, 0.5),
                icon = if useScaledPlayButton then nil else Images["icons/common/play"],
                onActivated = arg1.onPlayActivated
            }) else nil,
            PlayIcon = if isVideo and useScaledPlayButton then Roact.createElement(ImageSetLabel, {
                Size = uDim2_3,
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.5),
                Image = Images["icons/common/play"],
                BackgroundTransparency = 1,
                ZIndex = 2
            }) else nil,
            HoverBackground = bool1 and Roact.createElement(HoverButtonBackground) or nil
        }
        return createElement(var3, tbl1, tbl2)
    end)
end

function var1.renderEmptyState(arg1)
    return withStyle(function(arg2)
        local layoutOrder = arg1.props.layoutOrder
        local anchorPoint = arg1.props.anchorPoint
        local position = arg1.props.position
        local size = arg1.props.size

        return Roact.createElement("Frame", {
            LayoutOrder = layoutOrder,
            Size = size,
            AnchorPoint = anchorPoint,
            Position = position,
            BackgroundColor3 = arg2.Theme.BackgroundUIDefault.Color,
            BackgroundTransparency = arg2.Theme.BackgroundUIDefault.Transparency
        }, {
            Corner = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, 8) }),
            Icon = Roact.createElement(ImageSetLabel, {
                Size = UDim2.fromOffset(iconSize, iconSize),
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.5),
                Image = Images["icons/imageUnavailable"],
                ImageColor3 = arg2.Theme.UIDefault.Color,
                ImageTransparency = arg2.Theme.UIDefault.Transparency,
                BackgroundTransparency = 1
            })
        })
    end)
end

function var1.render(arg1)
    if arg1.props.imageId == "" then
        return arg1:renderEmptyState()
    end

    return arg1:renderButton()
end

return var1
