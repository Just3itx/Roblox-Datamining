-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local _StyleTypes = require(scriptParentParent.Style.StyleTypes)

local ImageSetComponent = require(scriptParentParentParent.Core.ImageSet.ImageSetComponent)
local _ImagesTypes = require(scriptParentParent.ImageSet.ImagesTypes)

local function ScrollBar(tbl1)
    local userInteractionEnabled = tbl1.userInteractionEnabled
    local width = tbl1.width
    local anchorPoint = tbl1.anchorPoint
    local position = tbl1.position
    local zIndex = tbl1.zIndex
    local transparency = tbl1.transparency
    local backgroundColor = tbl1.backgroundColor
    local paddingStartEnd = tbl1.paddingStartEnd

    local handleWidth = tbl1.handleWidth
    local handleColor = tbl1.handleColor
    local handleCornerRadius = tbl1.handleCornerRadius
    local handleIcon = tbl1.handleIcon
    local handleIconSize = tbl1.handleIconSize
    local handleIconColor = tbl1.handleIconColor
    local onDragging = tbl1.onDragging

    local viewSize = tbl1.viewSize
    local canvasSize = tbl1.canvasSize
    local canvasPosition = tbl1.canvasPosition

    local var1, var2 = React.useState(false)
    local var3, var4 = React.useBinding(0)
    local var5, var6 = React.useState(false)
    local var7 = React.useRef(0)
    local var8 = React.useRef(0)

    local var9 = React.useCallback(function(arg1)
        var4(arg1.AbsoluteSize.Y)
    end, { var4 })

    local var10 = React.useCallback(function(arg1)
        local parent = arg1.Parent
        if parent ~= nil and math.ceil(arg1.AbsoluteSize.Y) < parent.AbsoluteSize.Y then
            var2(true)
            return
        end
        var2(false)
    end, { var2 })

    local var11 = React.useMemo(function()
        return React.joinBindings({ viewSize = viewSize, canvasSize = canvasSize }):map(function(arg1): UDim2
            local yScale = math.clamp(arg1.viewSize.Y / arg1.canvasSize.Y, 0, 1)
            return UDim2.new(0, handleWidth, yScale, 0)
        end)
    end, { handleWidth, viewSize, canvasSize })

    local var12 = React.useMemo(function()
        return React.joinBindings({ canvasPosition = canvasPosition, canvasSize = canvasSize }):map(function(arg1): UDim2
            local yScale = arg1.canvasPosition.Y / arg1.canvasSize.Y
            return UDim2.fromScale(0.5, yScale)
        end)
    end, { canvasSize, canvasPosition })

    local var13 = React.useCallback(function(_, arg1)
        if not var1 or not userInteractionEnabled or var5 then
            return
        end

        if arg1 and arg1.UserInputType == Enum.UserInputType.MouseButton1 then
            var7.current = arg1.Position.Y
            var8.current = canvasPosition:getValue().Y

            var6(true)
        end
    end, {
        var1,
        userInteractionEnabled,
        var5,
        var7,
        var8,
        canvasPosition,
        var6
    })

    local var14 = React.useCallback(function(arg1)
        if not userInteractionEnabled or not var5 or arg1.UserInputType ~= Enum.UserInputType.MouseMovement then
            return
        end

        local var14 = (arg1.Position.Y - var7.current) / (var3:getValue() - paddingStartEnd)

        local y = viewSize:getValue().Y
        local current = var8.current
        local y2 = canvasSize:getValue().Y
        local num1 = math.clamp(current + var14 * y2, 0, y2 - y)

        onDragging(num1)
    end, {
        userInteractionEnabled,
        var5,
        var7,
        var3,
        paddingStartEnd,
        viewSize,
        var8,
        canvasSize,
        onDragging
    })

    local var15 = React.useCallback(function(arg1)
        if userInteractionEnabled and var5 and (not arg1 or arg1.UserInputType == Enum.UserInputType.MouseButton1) then
            var6(false)
        end
    end, { userInteractionEnabled, var5, var6 })

    React.useEffect(function()
        if not (var1 and var5) then
            return function() end
        end

        local connection = UserInputService.InputChanged:Connect(var14)
        local connection2 = UserInputService.InputEnded:Connect(var15)
        local connection3 = UserInputService.WindowFocusReleased:Connect(var15)

        return function()
            connection:Disconnect()
            connection2:Disconnect()
            connection3:Disconnect()
        end
    end, {
        var1,
        var5,
        var14,
        var15
    })

    local createElement = React.createElement
    local str1 = "CanvasGroup"
    local tbl2 = {
        Selectable = false,
        Size = UDim2.new(0, width, 1, 0),
        AnchorPoint = anchorPoint,
        Position = position,
        GroupTransparency = if var1 then if var5 then 0 else transparency else 1,
        BackgroundColor3 = if backgroundColor then backgroundColor.Color else nil,
        BackgroundTransparency = if backgroundColor then backgroundColor.Transparency else 1,
        BorderSizePixel = 0,
        ZIndex = zIndex
    }
    local tbl3 = {
        Padding = if paddingStartEnd then React.createElement(
            "UIPadding",
            {
                PaddingTop = UDim.new(0, paddingStartEnd),
                PaddingBottom = UDim.new(0, paddingStartEnd)
            }
        ) else nil,
        Track = 0
    }

    local createElement2 = React.createElement
    local str2 = "Frame"
    local tbl4 = {
        Selectable = false,
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        [React.Change.AbsoluteSize] = var9
    }
    local tbl5 = {
        TrackUICorner = if handleCornerRadius then React.createElement("UICorner", { CornerRadius = UDim.new(0, handleCornerRadius) }) else nil,
        Handle = 0
    }

    local createElement3 = React.createElement
    local str3 = "Frame"
    local tbl6 = {
        Active = var1 and userInteractionEnabled,
        Selectable = false,
        Size = var11,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = var12,
        BackgroundColor3 = if handleColor then handleColor.Color else nil,
        BackgroundTransparency = if handleColor then handleColor.Transparency else 0,
        BorderSizePixel = 0,
        [React.Change.AbsoluteSize] = var10,
        [React.Event.InputBegan] = var13
    }
    local tbl7 = {
        HandleUICorner = if handleCornerRadius then React.createElement("UICorner", { CornerRadius = UDim.new(0, handleCornerRadius) }) else nil,
        Icon = 0
    }
    local element

    if handleIcon then
        element = React.createElement(ImageSetComponent.Label, {
            Selectable = false,
            Size = UDim2.fromOffset(handleIconSize, handleIconSize),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Image = handleIcon,
            ImageColor3 = if handleIconColor then handleIconColor.Color else nil,
            ImageTransparency = if handleIconColor then handleIconColor.Transparency else nil,
            BackgroundTransparency = 1
        })
    else
        element = nil
    end

    tbl7.Icon = element
    tbl5.Handle = createElement3(str3, tbl6, tbl7)
    tbl3.Track = createElement2(str2, tbl4, tbl5)
    return createElement(str1, tbl2, tbl3)
end

return ScrollBar
