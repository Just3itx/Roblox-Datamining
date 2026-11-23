-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:30:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent
local EventConnection = require(AppBloxParent.ReactUtils).EventConnection
local Roact = require(AppBloxParent.Roact)
local t = require(AppBloxParent.t)

local UIBlox = require(AppBloxParent.UIBlox)
local IconButton = UIBlox.App.Button.IconButton
local Images = UIBlox.App.ImageSet.Images
local withStyle = UIBlox.Core.Style.withStyle

local ThumbnailButton = require(script.Parent.ThumbnailButton)
local getShowItems = require(script.Parent.getShowItems)

local var1 = Roact.Component:extend("MediaGalleryFullScreen")

var1.validateProps = t.strictInterface({
    layoutOrder = t.optional(t.integer),
    size = t.optional(t.UDim2),
    anchorPoint = t.optional(t.Vector2),
    position = t.optional(t.UDim2),
    items = t.array(t.interface({ imageId = t.string, isYouTubeVideo = t.optional(t.boolean) })),
    showIndex = t.optional(t.integer),
    onVideoPlayActivated = t.optional(t.callback)
})

var1.defaultProps = {
    size = UDim2.fromScale(1, 1),
    showIndex = 1
}

function var1.getDerivedStateFromProps(arg1, arg2)
    local tbl1

    if arg2.items == arg1.items then
        tbl1 = nil
    else
        local itemsToShow = getShowItems(arg1)

        tbl1 = {
            items = arg1.items,
            itemsToShow = itemsToShow,
            showArrows = #itemsToShow > 1,
            focusIndex = 0
        }
        local focusIndex = arg2.focusIndex or 1
        local showItemsLen = #itemsToShow
        tbl1.focusIndex = math.min(focusIndex, showItemsLen)
    end

    if arg2.showIndex ~= arg1.showIndex then
        tbl1 = tbl1 or {}
        tbl1.showIndex = arg1.showIndex
        local showIndex = arg1.showIndex
        local itemsLen = #arg1.items
        tbl1.focusIndex = math.min(showIndex, itemsLen)
    end

    return tbl1
end

function var1.init(arg1)
    arg1.state = {
        items = nil,
        itemsToShow = nil,
        showArrows = true,
        focusIndex = 1,
        showIndex = 1
    }

    local itemFrameSize, updateItemFrameSize = Roact.createBinding(UDim2.fromScale(1, 1))
    arg1.itemFrameSize = itemFrameSize
    arg1.updateItemFrameSize = updateItemFrameSize
    local arrowButtonSize, updateArrowButtonSize = Roact.createBinding(UDim2.new(0, 96, 1, 0))
    arg1.arrowButtonSize = arrowButtonSize
    arg1.updateArrowButtonSize = updateArrowButtonSize
    local leftArrowPosition, updateLeftArrowPosition = Roact.createBinding(UDim2.new(0.5, 0, 0.5, 0))
    arg1.leftArrowPosition = leftArrowPosition
    arg1.updateLeftArrowPosition = updateLeftArrowPosition
    local rightArrowPosition, updateRightArrowPosition = Roact.createBinding(UDim2.new(0.5, 0, 0.5, 0))
    arg1.rightArrowPosition = rightArrowPosition
    arg1.updateRightArrowPosition = updateRightArrowPosition

    function arg1.onResize(arg2)
        local absoluteSizeX = arg2.AbsoluteSize.X
        local absoluteSizeY = arg2.AbsoluteSize.Y

        local num1 = math.floor(absoluteSizeY * (16 / 9))
        if absoluteSizeX < num1 then
            absoluteSizeY = math.floor(absoluteSizeX / (16 / 9))
        else
            absoluteSizeX = num1
        end

        arg1.updateItemFrameSize(UDim2.new(0, absoluteSizeX, 0, absoluteSizeY))
    end

    function arg1.onImageResize(arg2)
        local absoluteSizeX = arg2.AbsoluteSize.X
        local absoluteSizeY = arg2.AbsoluteSize.Y

        arg1.updateLeftArrowPosition(UDim2.new(0.5, -absoluteSizeX / 2, 0.5, 0))
        arg1.updateRightArrowPosition(UDim2.new(0.5, absoluteSizeX / 2, 0.5, 0))
        arg1.updateArrowButtonSize(UDim2.new(0, 96, 0, absoluteSizeY))
    end

    function arg1.onUserInputBegan(arg2)
        if arg2.UserInputType ~= Enum.UserInputType.Keyboard then
            return
        end

        local focusIndex = arg1.state.focusIndex
        local itemsLen = #arg1.props.items

        if arg2.KeyCode == Enum.KeyCode.Left and focusIndex > 1 then
            arg1.showPreviousItem()
        elseif arg2.KeyCode == Enum.KeyCode.Right and focusIndex < itemsLen then
            arg1.showNextItem()
        end
    end

    function arg1.showPreviousItem()
        local var10 = arg1.state.focusIndex - 1
        local focusIndex = if var10 < 1 then 1 else var10

        arg1:setState({ focusIndex = focusIndex })
    end

    function arg1.showNextItem()
        local itemsLen = #arg1.props.items
        local var10 = arg1.state.focusIndex + 1
        if itemsLen < var10 then
            var10 = itemsLen
        end

        arg1:setState({ focusIndex = var10 })
    end

    function arg1.cycleNext()
        local itemsLen = #arg1.props.items
        local var10 = arg1.state.focusIndex + 1
        local focusIndex = if itemsLen < var10 then 1 else var10

        arg1:setState({ focusIndex = focusIndex })
    end

    function arg1.onVideoPlayActivated(arg2)
        if arg1.props.onVideoPlayActivated then
            local originalIndex = arg1.state.itemsToShow[arg2].originalIndex

            arg1.props.onVideoPlayActivated(originalIndex)
        end
    end
end

local function renderArrowButton(_, str1: string, isDisabled: boolean, anchorPoint: Vector2, position, size, onActivated)
    return Roact.createElement("Frame", {
        Size = size,
        AnchorPoint = anchorPoint,
        Position = position,
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        ZIndex = 100
    }, {
        ArrowButton = Roact.createElement(IconButton, {
            size = UDim2.fromScale(1, 1),
            icon = Images[str1],
            showBackground = true,
            backgroundTransparency = 1,
            isDisabled = isDisabled,
            onActivated = onActivated
        })
    })
end

function var1.render(arg1)
    return withStyle(function(arg2)
        return arg1:renderWithProvider(arg2)
    end)
end

function var1.renderWithProvider(arg1, arg2)
    local layoutOrder = arg1.props.layoutOrder
    local anchorPoint = arg1.props.anchorPoint
    local position = arg1.props.position
    local size = arg1.props.size

    local itemsToShow = arg1.state.itemsToShow
    local showArrows = arg1.state.showArrows
    local focusIndex = arg1.state.focusIndex

    local var2 = itemsToShow[focusIndex]
    local isDisabled = focusIndex <= 1
    local isDisabled2 = #itemsToShow <= focusIndex

    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl1 = {
        LayoutOrder = layoutOrder,
        Size = size,
        AnchorPoint = anchorPoint,
        Position = position,
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        [Roact.Change.AbsoluteSize] = arg1.onResize
    }
    local tbl2 = {
        LeftArrow = if showArrows then renderArrowButton(
            arg2,
            "icons/actions/cycleLeft",
            isDisabled,
            Vector2.new(1, 0.5),
            arg1.leftArrowPosition,
            arg1.arrowButtonSize,
            arg1.showPreviousItem
        ) else nil,
        FullScreenItemFrame = 0,
        RightArrow = 0,
        EventConnection = 0
    }

    local createElement2 = Roact.createElement
    local str2 = "Frame"
    local tbl3 = {
        Size = UDim2.new(1, -192, 1, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        BackgroundTransparency = 1,
        [Roact.Change.AbsoluteSize] = arg1.onImageResize
    }
    local tbl4 = {
        UIAspectRatioConstraint = Roact.createElement("UIAspectRatioConstraint", { AspectRatio = 16 / 9 }),
        Item = Roact.createElement(ThumbnailButton, {
            itemKey = focusIndex,
            imageId = var2.imageId,
            isVideo = var2.isYouTubeVideo,
            userInteractionEnabled = true,
            onActivated = arg1.cycleNext,
            onPlayActivated = if var2.isYouTubeVideo then arg1.onVideoPlayActivated or nil else nil
        })
    }
    tbl2.FullScreenItemFrame = createElement2(str2, tbl3, tbl4)

    tbl2.RightArrow = if showArrows then renderArrowButton(
        arg2,
        "icons/actions/cycleRight",
        isDisabled2,
        Vector2.new(0, 0.5),
        arg1.rightArrowPosition,
        arg1.arrowButtonSize,
        arg1.showNextItem
    ) else nil

    tbl2.EventConnection = showArrows
        and Roact.createElement(EventConnection, { event = UserInputService.InputBegan, callback = arg1.onUserInputBegan })
        or nil
    return createElement(str1, tbl1, tbl2)
end

return var1
