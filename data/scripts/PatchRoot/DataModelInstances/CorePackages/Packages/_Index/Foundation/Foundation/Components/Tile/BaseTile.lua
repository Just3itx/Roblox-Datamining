-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local BaseTileContent = require(script.Parent.BaseTileContent)
local BaseTileMedia = require(script.Parent.BaseTileMedia)
local BaseTileMediaClipping = require(Foundation.Enums.BaseTileMediaClipping)
local TileAspectRatio = require(Foundation.Enums.TileAspectRatio)
local _Types = require(Foundation.Components.Types)
local getTestIdTag = require(Foundation.Utility.getTestIdTag)
local joinBindables = require(Foundation.Utility.joinBindables)
local mapBindable = require(Foundation.Utility.mapBindable)
local useCursor = require(Foundation.Providers.Cursor.useCursor)
local useGuiControlState = require(Foundation.Utility.Control.useGuiControlState)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withDefaults = require(Foundation.Utility.withDefaults)

local function isHeightBounded(uDim2: UDim2): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
    return uDim2.Y.Scale ~= 0 or uDim2.Y.Offset ~= 0
end

local tbl1 = {
    mediaAspectRatio = TileAspectRatio.Ratio16x9,
    mediaClippingStyle = BaseTileMediaClipping.Default,
    isContained = false,
    testId = "--foundation-base-tile"
}

return React.memo(React.forwardRef(function(arg1, arg2) -- name: BaseTile
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useTokens()
    local var3 = React.useMemo(function()
        return {
            radius = UDim.new(0, var2.Radius.Medium),
            offset = var2.Size.Size_200,
            borderWidth = var2.Stroke.Thicker
        }
    end, { var2 })
    local selectionImageObject = useCursor(var3)
    local var5 = var1.Size or UDim2.fromOffset(250 * var2.Config.UI.Scale, 0)
    local automaticSize = mapBindable(var5, function(uDim2: UDim2): Enum.AutomaticSize
        return if isHeightBounded(uDim2) then Enum.AutomaticSize.None else Enum.AutomaticSize.Y
    end)

    local bool1 = typeof(var5) ~= "UDim2" or isHeightBounded(var5)

    local var7 = React.useRef(nil)
    if bool1 and var7.current == nil then
        local tileHeight, setTileHeight = React.createBinding(0)
        local contentHeight, setContentHeight = React.createBinding(0)
        var7.current = {
            tileHeight = tileHeight,
            setTileHeight = setTileHeight,
            contentHeight = contentHeight,
            setContentHeight = setContentHeight
        }
    end

    local onAbsoluteSizeChanged = var1.onAbsoluteSizeChanged
    local var8 = React.useMemo(function()
        local current = var7.current

        if not bool1 or current == nil then
            return nil
        end

        return {
            mediaMaxHeight = joinBindables({
                size = var5,
                tileHeight = current.tileHeight,
                contentHeight = current.contentHeight
            }, function(arg3)
                if not isHeightBounded(arg3.size) then
                    return nil
                end

                return math.max(arg3.tileHeight - arg3.contentHeight, 0)
            end),
            onTileAbsoluteSizeChanged = function(arg3)
                current.setTileHeight(arg3.AbsoluteSize.Y)
                if onAbsoluteSizeChanged ~= nil then
                    onAbsoluteSizeChanged(arg3)
                end
            end,
            onContentAbsoluteSizeChanged = function(arg3)
                current.setContentHeight(arg3.AbsoluteSize.Y)
            end
        }
    end, { var5, bool1, onAbsoluteSizeChanged })

    local onActivated = var1.onActivated
    local onSecondaryActivated = var1.onSecondaryActivated
    local onStateChanged = var1.onStateChanged
    local bool2 = onActivated ~= nil or onSecondaryActivated ~= nil
    local isSizeConstrained = var1.minSize ~= nil or var1.maxSize ~= nil

    local bool4 = onStateChanged ~= nil
    local var9 = if var1.isContained then var1.containedBackgroundStyle or var2.Color.Shift.Shift_200 else nil
    local var10 = useGuiControlState(if bool4 then arg2 else nil, onStateChanged)

    local bool5 = bool2 or bool4
    local tbl2 = {
        AnchorPoint = var1.AnchorPoint,
        AutomaticSize = automaticSize,
        BackgroundColor3 = if var9 == nil then nil else mapBindable(var9, function(arg3)
            return arg3.Color3
        end),
        BackgroundTransparency = if var9 == nil then 1 else mapBindable(var9, function(arg3)
            return arg3.Transparency
        end),
        BorderSizePixel = 0,
        LayoutOrder = var1.LayoutOrder,
        Position = var1.Position,
        Size = var5,
        Visible = var1.Visible,
        ZIndex = var1.ZIndex
    }

    if not bool4 then
        var10 = arg2
    end

    tbl2.ref = var10
    local absoluteSize = React.Change.AbsoluteSize
    tbl2[absoluteSize] = if var8 == nil then onAbsoluteSizeChanged else var8.onTileAbsoluteSizeChanged

    tbl2[React.Change.AbsolutePosition] = var1.onAbsolutePositionChanged
    tbl2[React.Tag] = getTestIdTag(var1.testId)

    if bool5 then
        tbl2.Active = bool2
        tbl2.AutoButtonColor = false
        tbl2.Selectable = bool2
        tbl2.SelectionImageObject = selectionImageObject
        tbl2.Text = ""
        tbl2[React.Event.Activated] = onActivated
        tbl2[React.Event.SecondaryActivated] = onSecondaryActivated
    end

    local createElement = React.createElement
    local str1 = if bool5 then "TextButton" else "Frame"
    local tbl3 = {
        Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0, var2.Radius.Medium) }),
        SizeConstraint = if isSizeConstrained then React.createElement("UISizeConstraint", { MinSize = var1.minSize, MaxSize = var1.maxSize }) else nil,
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder
        }),
        Media = React.createElement(BaseTileMedia, {
            content = var1.mediaContent,
            clippingStyle = var1.mediaClippingStyle,
            aspectRatio = var1.mediaAspectRatio,
            backgroundStyle = var1.mediaBackgroundStyle or var2.Color.Shift.Shift_200,
            isSizeConstrained = isSizeConstrained,
            isContained = var1.isContained,
            tileSize = var5,
            maxHeight = if var8 == nil then nil else var8.mediaMaxHeight,
            LayoutOrder = 1,
            testId = `{var1.testId}--media`
        }),
        Content = React.createElement(BaseTileContent, {
            title = var1.title,
            metadata = var1.metadata,
            contentAction = var1.contentAction,
            footer = var1.footer,
            isContained = var1.isContained,
            onAbsoluteSizeChanged = if var8 == nil then nil else var8.onContentAbsoluteSizeChanged,
            LayoutOrder = 2,
            testId = var1.testId
        })
    }
    return createElement(str1, tbl2, tbl3)
end))
