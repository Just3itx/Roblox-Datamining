-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:30:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent
local EventConnection = require(AppBloxParent.ReactUtils).EventConnection
local Otter = require(AppBloxParent.Otter)
local Roact = require(AppBloxParent.Roact)

local UIBlox = require(AppBloxParent.UIBlox)
local IconButton = UIBlox.App.Button.IconButton
local IconSize = UIBlox.App.ImageSet.Enum.IconSize
local Images = UIBlox.App.ImageSet.Images
local getIconSize = UIBlox.App.ImageSet.getIconSize
local withStyle = UIBlox.Core.Style.withStyle

local t = require(AppBloxParent.t)

local ThumbnailButton = require(script.Parent.ThumbnailButton)
local calcMediaGallerySizesFromHeight = require(script.Parent.calcMediaGallerySizesFromHeight)
local calcMediaGallerySizesFromWidth = require(script.Parent.calcMediaGallerySizesFromWidth)
local getShowItems = require(script.Parent.getShowItems)

local iconSize = getIconSize(IconSize.Medium)

local tbl1 = { frequency = 4, dampingRatio = 1 }

local var1 = Roact.Component:extend("MediaGalleryPreview")

var1.validateProps = t.strictInterface({
    layoutOrder = t.optional(t.integer),
    size = t.optional(t.UDim2),
    fullWidth = t.optional(t.boolean),
    anchorPoint = t.optional(t.Vector2),
    position = t.optional(t.UDim2),
    items = t.array(t.strictInterface({ imageId = t.string, isYouTubeVideo = t.optional(t.boolean) })),
    numberOfThumbnails = t.optional(t.integer),
    onPreviewActivated = t.optional(t.callback),
    onThumbnailActivated = t.optional(t.callback),
    onVideoPlayActivated = t.optional(t.callback)
})

var1.defaultProps = {
    size = UDim2.fromScale(1, 1),
    numberOfThumbnails = 5,
    fullWidth = false
}

function var1.getDerivedStateFromProps(arg1, arg2)
    if arg2.items == arg1.items and arg2.numberOfThumbnails == arg1.numberOfThumbnails then
        return
    end

    local itemsToShow, youTubeVideoItemsSize, imageItemsSize = getShowItems(arg1)
    return {
        items = arg1.items,
        numberOfThumbnails = arg1.numberOfThumbnails,
        itemsToShow = itemsToShow,
        youTubeVideoItemsSize = youTubeVideoItemsSize,
        imageItemsSize = imageItemsSize,
        animationOn = imageItemsSize > 1,
        animatedIndex = youTubeVideoItemsSize + 1,
        selectedIndex = youTubeVideoItemsSize + 1
    }
end

function var1.init(arg1)
    arg1.state = {
        items = nil,
        numberOfThumbnails = 1,
        itemsToShow = nil,
        youTubeVideoItemsSize = 0,
        imageItemsSize = 0,
        animationOn = false,
        animatedIndex = 1,
        selectedIndex = 1,
        showArrows = false,
        focusIndex = 1
    }

    arg1.animationTime = 0
    arg1.scrolling = false
    arg1.scrollMotor = Otter.createSingleMotor(0)

    local contentSize, updateContentSize = Roact.createBinding(UDim2.fromScale(1, 1))
    arg1.contentSize = contentSize
    arg1.updateContentSize = updateContentSize
    local previewSize, updatePreviewSize = Roact.createBinding(UDim2.fromScale(1, 0.5))
    arg1.previewSize = previewSize
    arg1.updatePreviewSize = updatePreviewSize
    local paginationSize, updatePaginationSize = Roact.createBinding(UDim2.fromScale(1, 0.5))
    arg1.paginationSize = paginationSize
    arg1.updatePaginationSize = updatePaginationSize
    local thumbnailSize, updateThumbnailSize = Roact.createBinding(UDim2.fromScale(0, 0))
    arg1.thumbnailSize = thumbnailSize
    arg1.updateThumbnailSize = updateThumbnailSize

    local canvasPosition, updateCanvasPosition = Roact.createBinding(Vector2.new(0, 0))
    arg1.canvasPosition = canvasPosition
    arg1.updateCanvasPosition = updateCanvasPosition
    local progress, updateProgress = Roact.createBinding(0)
    arg1.progress = progress
    arg1.updateProgress = updateProgress
    local previewTransparency, updatePreviewTransparency = Roact.createBinding(0)
    arg1.previewTransparency = previewTransparency
    arg1.updatePreviewTransparency = updatePreviewTransparency

    function arg1.onResize(arg2)
        arg1:updateSizes(arg2)
        arg1.updateCanvasPosition(Vector2.new(arg1:getCanvasPositionX(), 0))
    end

    function arg1.onMouseLeave(_, arg2)
        if arg2.UserInputType ~= Enum.UserInputType.MouseMovement then
            return
        end

        arg1.resetAnimation()
        arg1:setState(function(arg3)
            local selectedIndex = arg3.selectedIndex
            local focusIndex = arg1.getNextFocusIndex(selectedIndex)

            return {
                animationOn = arg3.imageItemsSize > 1,
                animatedIndex = selectedIndex,
                focusIndex = focusIndex
            }
        end)
    end

    function arg1.onPreviewActivated()
        arg1.resetAnimation()
        arg1:setState({ animationOn = false })

        if arg1.props.onPreviewActivated then
            local originalIndex = arg1.state.itemsToShow[arg1.state.selectedIndex].originalIndex

            arg1.props.onPreviewActivated(originalIndex)
        end
    end

    function arg1.onMouseEnterPagination(_, arg2)
        if arg2.UserInputType ~= Enum.UserInputType.MouseMovement then
            return
        end

        arg1:setState(function(arg3)
            if not arg3.showArrows then
                return { showArrows = true }
            end
        end)
    end

    function arg1.onMouseLeavePagination(_, arg2)
        if arg2.UserInputType ~= Enum.UserInputType.MouseMovement then
            return
        end

        arg1:setState(function(arg3)
            if arg3.showArrows then
                return { showArrows = false }
            end
        end)
    end

    function arg1.onCycleLeftActivated()
        if arg1.scrolling then
            return
        end

        local focusIndex = math.max(arg1.state.focusIndex - 1, 1)

        arg1.resetAnimation()
        arg1:setState({ animationOn = false, focusIndex = focusIndex })
    end

    function arg1.onCycleRightActivated()
        if arg1.scrolling then
            return
        end

        local focusIndex = math.min(arg1.state.focusIndex + 1, #arg1.props.items)

        arg1.resetAnimation()
        arg1:setState({ animationOn = false, focusIndex = focusIndex })
    end

    function arg1.onItemActivated(arg2)
        local isYouTubeVideo = arg1.state.itemsToShow[arg2].isYouTubeVideo
        local selectedIndex = arg1.state.selectedIndex

        arg1.resetAnimation()
        arg1:setState({ animationOn = false, selectedIndex = not isYouTubeVideo and arg2 or nil })

        if isYouTubeVideo then
            arg1.onVideoPlayActivated(arg2)
        end

        if arg1.props.onThumbnailActivated then
            arg1.props.onThumbnailActivated(selectedIndex, arg2)
        end
    end

    function arg1.onItemPlayActivated(arg2)
        arg1.resetAnimation()
        arg1:setState({ animationOn = false })

        arg1.onVideoPlayActivated(arg2)
    end

    function arg1.onVideoPlayActivated(arg2)
        if arg1.props.onVideoPlayActivated then
            local originalIndex = arg1.state.itemsToShow[arg2].originalIndex

            arg1.props.onVideoPlayActivated(originalIndex)
        end
    end

    function arg1.getNextFocusIndex(arg2)
        local focusIndex = arg1.state.focusIndex
        local numberOfThumbnails = arg1.props.numberOfThumbnails

        if arg2 < focusIndex then
            return arg2
        end

        if focusIndex + numberOfThumbnails <= arg2 then
            return arg2 - numberOfThumbnails + 1
        end

        return focusIndex
    end

    function arg1.resetAnimation()
        arg1.animationTime = 0
        arg1.updateProgress(0)
        arg1.updatePreviewTransparency(0)
    end

    function arg1.renderSteppedCallback(arg2)
        arg1.animationTime += arg2
        local var16 = arg1.animationTime - 4.5

        if not (arg1.animationTime > 5) then
            arg1.updateProgress(arg1.animationTime / 5)

            if var16 > 0 then
                arg1.updatePreviewTransparency(var16 / 0.5)
            end

            return
        end

        arg1.animationTime = 0
        arg1.updateProgress(0)

        local animatedIndex = arg1.state.animatedIndex
        local youTubeVideoItemsSize = arg1.state.youTubeVideoItemsSize
        local imageItemsSize = arg1.state.imageItemsSize
        local var17 = (animatedIndex - youTubeVideoItemsSize) % imageItemsSize + 1 + youTubeVideoItemsSize

        local focusIndex = arg1.getNextFocusIndex(var17)

        arg1:setState({ animatedIndex = var17, selectedIndex = var17, focusIndex = focusIndex })
    end
    function arg1.scrollMotorOnStep(x: number?)
        arg1.updateCanvasPosition(Vector2.new(x, 0))
    end

    function arg1.scrollMotorOnComplete()
        arg1.scrolling = false
    end

    arg1.scrollMotor:onStep(arg1.scrollMotorOnStep)
    arg1.scrollMotor:onComplete(arg1.scrollMotorOnComplete)
end

function var1.render(arg1)
    local layoutOrder = arg1.props.layoutOrder
    local anchorPoint = arg1.props.anchorPoint
    local position = arg1.props.position
    local size = arg1.props.size
    local numberOfThumbnails = arg1.props.numberOfThumbnails
    local itemsLen = #arg1.props.items

    local itemsToShow = arg1.state.itemsToShow
    local showArrows = arg1.state.showArrows
    local focusIndex = arg1.state.focusIndex
    local selectedIndex = arg1.state.selectedIndex
    local animationOn = arg1.state.animationOn
    local youTubeVideoItemsSize = arg1.state.youTubeVideoItemsSize
    local imageItemsSize = arg1.state.imageItemsSize
    local bool1 = itemsLen > 1 and not animationOn
    local var2 = if animationOn then (selectedIndex - youTubeVideoItemsSize) % imageItemsSize + 1 + youTubeVideoItemsSize or nil else nil
    local bool2 = numberOfThumbnails < itemsLen
    local isDisabled = focusIndex <= 1
    local bool3 = focusIndex + numberOfThumbnails > #itemsToShow

    return withStyle(function(arg2)
        local createElement = Roact.createElement
        local str1 = "Frame"
        local tbl2 = {
            LayoutOrder = layoutOrder,
            Size = size,
            AnchorPoint = anchorPoint,
            Position = position,
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            [Roact.Change.AbsoluteSize] = arg1.onResize,
            [Roact.Event.InputEnded] = bool1 and arg1.onMouseLeave or nil
        }
        local tbl3 = { Content = 0, EventConnection = 0 }
        local createElement2 = Roact.createElement
        local str2 = "Frame"
        local tbl4 = {
            Size = arg1.contentSize,
            BorderSizePixel = 0,
            BackgroundTransparency = 1
        }

        local tbl5 = {
            ListLayout = Roact.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 24)
            }),
            Preview = 0,
            Pagination = 0
        }
        local createElement3 = Roact.createElement
        local str3 = "Frame"
        local tbl6 = {
            LayoutOrder = 1,
            Size = arg1.previewSize,
            BackgroundTransparency = 1
        }
        local tbl7 = {
            AnimationLabel = if animationOn then Roact.createElement(
                "ImageLabel",
                {
                    Size = UDim2.fromScale(1, 1),
                    Image = var2 and itemsToShow[var2].imageId,
                    BackgroundTransparency = 1,
                    ZIndex = -1
                },
                {
                    Corner = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, 8) })
                }
            )
                or nil else nil,
            Button = Roact.createElement(
                "ImageButton",
                {
                    Size = UDim2.fromScale(1, 1),
                    Image = itemsToShow[selectedIndex].imageId,
                    ImageTransparency = arg1.previewTransparency,
                    BackgroundTransparency = 1,
                    AutoButtonColor = false,
                    ZIndex = 1,
                    [Roact.Event.Activated] = arg1.onPreviewActivated
                },
                {
                    Corner = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, 8) })
                }
            )
        }
        tbl5.Preview = createElement3(str3, tbl6, tbl7)

        tbl5.Pagination = Roact.createElement("Frame", {
            LayoutOrder = 2,
            Size = arg1.paginationSize,
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            [Roact.Event.InputBegan] = bool2 and arg1.onMouseEnterPagination or nil,
            [Roact.Event.InputEnded] = bool2 and arg1.onMouseLeavePagination or nil
        }, {
            LeftArrow = showArrows
                and Roact.createElement(IconButton, {
                    size = UDim2.new(0, iconSize, 1, 0),
                    anchorPoint = Vector2.new(0, 0.5),
                    position = UDim2.fromScale(0, 0.5),
                    icon = Images["icons/actions/cycleLeft"],
                    isDisabled = isDisabled,
                    onActivated = arg1.onCycleLeftActivated
                })
                or nil,
            Scroller = arg1:renderScroller(arg2),
            RightArrow = showArrows
                and Roact.createElement(IconButton, {
                    size = UDim2.new(0, iconSize, 1, 0),
                    anchorPoint = Vector2.new(1, 0.5),
                    position = UDim2.fromScale(1, 0.5),
                    icon = Images["icons/actions/cycleRight"],
                    isDisabled = bool3,
                    onActivated = arg1.onCycleRightActivated
                })
                or nil
        })
        tbl3.Content = createElement2(str2, tbl4, tbl5)

        tbl3.EventConnection = animationOn
            and Roact.createElement(EventConnection, { event = RunService.RenderStepped, callback = arg1.renderSteppedCallback })
            or nil
        return createElement(str1, tbl2, tbl3)
    end)
end

function var1.renderScroller(arg1, arg2)
    return Roact.createElement("ScrollingFrame", {
        Size = UDim2.new(1, -iconSize * 2, 1, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        BackgroundTransparency = 1,
        ScrollBarThickness = 0,
        ClipsDescendants = true,
        ScrollingDirection = Enum.ScrollingDirection.X,
        AutomaticCanvasSize = Enum.AutomaticSize.XY,
        CanvasPosition = arg1.canvasPosition,
        Selectable = false
    }, arg1:renderThumbnails(arg2))
end

function var1.renderThumbnails(arg1, arg2)
    local selectedIndex = arg1.state.selectedIndex
    local animationOn = arg1.state.animationOn
    local animatedIndex = arg1.state.animatedIndex

    local tbl2 = {
        ListLayout = Roact.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 12)
        })
    }

    for i, value in ipairs(arg1.state.itemsToShow) do
        local isSelected = i == selectedIndex
        local var2 = animationOn and i == animatedIndex
        local var3 = value.imageId and value.imageId ~= ""

        local var4 = "item" .. i
        local createElement = Roact.createElement
        local str1 = "Frame"
        local tbl3 = {
            LayoutOrder = i,
            Size = arg1.thumbnailSize,
            BorderSizePixel = 0,
            BackgroundTransparency = 1
        }

        local tbl4 = {
            Thumbnail = Roact.createElement(ThumbnailButton, {
                itemKey = i,
                imageId = value.imageId,
                isVideo = value.isYouTubeVideo,
                isSelected = isSelected,
                onActivated = if var3 then arg1.onItemActivated or nil else nil,
                onPlayActivated = if value.isYouTubeVideo then arg1.onItemPlayActivated or nil else nil,
                useScaledPlayButton = true
            }),
            TimerBar = if var2 then arg1:renderTimerBar(arg2) or nil else nil
        }
        tbl2[var4] = createElement(str1, tbl3, tbl4)
    end

    return tbl2
end

function var1.renderTimerBar(arg1, arg2)
    local uiDefault = arg2.Theme.UIDefault
    local secondaryContent = arg2.Theme.SecondaryContent

    return Roact.createElement("Frame", {
        Size = UDim2.new(1, 0, 0, 2),
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.fromScale(0, 1),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        ZIndex = 100
    }, {
        Background = Roact.createElement("Frame", {
            Size = arg1.thumbnailSize,
            AnchorPoint = Vector2.new(0, 1),
            Position = UDim2.fromScale(0, 1),
            BorderSizePixel = 0,
            BackgroundColor3 = uiDefault.Color,
            BackgroundTransparency = uiDefault.Transparency
        }, {
            Corner = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, 8) }),
            Progress = Roact.createElement("Frame", {
                Size = arg1.progress:map(function(xScale: number): UDim2
                    return UDim2.fromScale(xScale, 1)
                end),
                BorderSizePixel = 0,
                BackgroundTransparency = 1,
                ClipsDescendants = true
            }, {
                Foreground = Roact.createElement(
                    "Frame",
                    {
                        Size = arg1.thumbnailSize,
                        BorderSizePixel = 0,
                        BackgroundColor3 = secondaryContent.Color,
                        BackgroundTransparency = secondaryContent.Transparency
                    },
                    {
                        Corner = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, 8) })
                    }
                )
            })
        })
    })
end

function var1.didUpdate(arg1, _, arg2)
    if arg1.state.focusIndex ~= arg2.focusIndex then
        arg1:scrollToNewIndex()
    end

    if arg1.state.selectedIndex ~= arg2.selectedIndex then
        arg1.updatePreviewTransparency(0)
    end
end

function var1.updateSizes(arg1, arg2)
    local absoluteSizeX = arg2.AbsoluteSize.X
    local absoluteSizeY = arg2.AbsoluteSize.Y
    local numberOfThumbnails = arg1.props.numberOfThumbnails

    local var2 = calcMediaGallerySizesFromWidth(absoluteSizeX, numberOfThumbnails, arg1.props.fullWidth)
    if absoluteSizeY < var2.contentSize.Y.Offset then
        var2 = calcMediaGallerySizesFromHeight(absoluteSizeY, numberOfThumbnails, arg1.props.fullWidth)
    end

    arg1.updateContentSize(var2.contentSize)
    arg1.updatePreviewSize(var2.previewSize)
    arg1.updatePaginationSize(var2.paginationSize)
    arg1.updateThumbnailSize(var2.thumbnailSize)
end

function var1.getCanvasPositionX(arg1): number
    local focusIndex = arg1.state.focusIndex
    local offset = arg1.thumbnailSize:getValue().X.Offset
    return (focusIndex - 1) * (offset + 12)
end

function var1.scrollToNewIndex(arg1)
    local x = arg1.canvasPosition:getValue().X
    local canvasPositionX = arg1:getCanvasPositionX()

    arg1.scrollMotor:setGoal(Otter.instant(x))
    arg1.scrollMotor:setGoal(Otter.spring(canvasPositionX, tbl1))
    arg1.scrolling = true
end

return var1
