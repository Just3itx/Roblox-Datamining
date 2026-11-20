-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:41:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local RoactGamepad = require(scriptParentParentParentParent.RoactGamepad)
local Roact = require(scriptParentParentParentParent.Roact)
local React = require(scriptParentParentParentParent.React)
local Cryo = require(scriptParentParentParentParent.Cryo)
local t = require(scriptParentParentParentParent.t)
local withStyle = require(scriptParentParentParent.Core.Style.withStyle)
local useStyle = require(scriptParentParentParent.Core.Style.useStyle)
local validateColorInfo = require(scriptParentParentParent.Core.Style.Validator.validateColorInfo)
local ImageSetComponent = require(scriptParentParentParent.Core.ImageSet.ImageSetComponent)

local validateButtonProps = require(script.Parent.validateButtonProps)

local VerticalScrollView = require(scriptParentParent.Container.VerticalScrollView)
local Images = require(scriptParentParent.ImageSet.Images)
local withSelectionCursorProvider = require(scriptParentParent.SelectionImage.withSelectionCursorProvider)
local CursorKind = require(scriptParentParent.SelectionImage.CursorKind)
local setDefault = require(scriptParentParentParent.Utility.setDefault)

local Cell = require(script.Parent.Cell)
local RoundedFrame = require(script.Parent.RoundedFrame)
local StyleDefaults = require(script.Parent.StyleDefaults)

local component_assetsDropshadow_17_8 = Images["component_assets/dropshadow_17_8"]

local var1 = Roact.PureComponent:extend("BaseMenu")

var1.validateProps = t.strictInterface({
    buttonProps = validateButtonProps,
    width = t.optional(t.UDim),
    position = t.optional(t.union(t.UDim2, t.table)),
    anchorPoint = t.optional(t.Vector2),
    layoutOrder = t.optional(t.number),
    topElementRounded = t.optional(t.boolean),
    bottomElementRounded = t.optional(t.boolean),
    setFirstItemRef = t.optional(t.union(t.callback, t.table)),
    setFrameRef = t.optional(t.union(t.callback, t.table)),
    stayOnActivated = t.optional(t.boolean),
    maxHeight = t.optional(t.number),
    showDropShadow = t.optional(t.boolean),
    fixedListHeight = t.optional(t.number),
    isElementBackgroundVisible = t.optional(t.boolean),
    isElementDividerVisible = t.optional(t.boolean),
    elementHeight = t.optional(t.number),
    borderCornerRadius = t.optional(t.integer),
    background = t.optional(validateColorInfo),
    enableTokenOverride = t.optional(t.boolean),
    renderHeader = t.optional(t.callback),
    headerHeight = t.optional(t.number),
    selectionOrder = t.optional(t.number),
    isRoactGamepadEnabled = t.optional(t.boolean)
})

var1.defaultProps = {
    width = UDim.new(1, 0),
    position = UDim2.new(0, 0, 0, 0),
    topElementRounded = true,
    bottomElementRounded = true,
    showDropShadow = false,
    fixedListHeight = nil,
    isElementBackgroundVisible = true,
    isElementDividerVisible = true,
    elementHeight = 56,
    borderCornerRadius = 4,
    enableTokenOverride = true,
    headerHeight = 0,
    isRoactGamepadEnabled = true
}

function var1.init(arg1)
    arg1.gamepadRefs = arg1.props.isRoactGamepadEnabled and RoactGamepad.createRefCache() or {}
end

function var1.renderFixedHeightMenu(_, arg1, arg2, arg3)
    local fixedListHeight = arg1.fixedListHeight
    local offset = setDefault(arg1.borderCornerRadius, 8)
    local backgroundUiDefault = arg2.Theme.BackgroundUIDefault
    local var2 = setDefault(arg1.background, { Color = backgroundUiDefault.Color, Transparency = backgroundUiDefault.Transparency })

    return Roact.createElement("Frame", {
        AnchorPoint = arg1.anchorPoint,
        BackgroundTransparency = 1,
        LayoutOrder = arg1.layoutOrder,
        Size = UDim2.new(arg1.width.Scale, arg1.width.Offset, 0, fixedListHeight),
        Position = arg1.position
    }, {
        DropShadow = arg1.showDropShadow
            and Roact.createElement(ImageSetComponent.Label, {
                ZIndex = 2,
                Position = UDim2.new(0.5, 0, 0.5, 0),
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 16, 1, 16),
                Image = component_assetsDropshadow_17_8,
                ImageColor3 = arg2.Theme.DropShadow.Color,
                ImageTransparency = arg2.Theme.DropShadow.Transparency,
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(16, 16, 16, 16)
            })
            or nil,
        ContentFrame = Roact.createElement("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            BackgroundColor3 = var2.Color,
            BackgroundTransparency = var2.Transparency,
            ZIndex = 3
        }, {
            UICorner = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, offset) }),
            ClippingFrame = Roact.createElement("Frame", {
                ZIndex = 4,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, -offset * 2),
                Position = UDim2.new(0, 0, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                ClipsDescendants = true
            }, {
                ScrollingFrame = Roact.createElement(
                    VerticalScrollView,
                    {
                        canvasSizeY = UDim.new(0, #arg1.buttonProps * arg1.elementHeight),
                        selectable = false
                    },
                    arg3
                )
            })
        })
    })
end

function var1.render(arg1)
    local headerHeight = arg1.props.headerHeight
    local var2 = arg1.props.elementHeight * 7.5 + headerHeight
    local yOffset = #arg1.props.buttonProps * arg1.props.elementHeight + headerHeight
    local bool1 = false
    if var2 <= yOffset then
        yOffset = var2
        bool1 = true
    end

    local maxHeight = arg1.props.maxHeight
    if maxHeight and maxHeight > 0 and maxHeight < yOffset then
        yOffset = (math.max(math.floor((maxHeight - arg1.props.elementHeight * 0.5 - headerHeight) / arg1.props.elementHeight), 1) + 0.5) * arg1.props.elementHeight + headerHeight
        bool1 = true
    end

    local tbl1 = {}
    for i, buttonProp in ipairs(arg1.props.buttonProps) do
        local join = Cryo.Dictionary.join
        local tbl2 = {
            elementHeight = arg1.props.elementHeight,
            hasRoundTop = 0,
            hasRoundBottom = 0,
            hasDivider = 0,
            layoutOrder = 0,
            inputBindingKey = 0,
            setButtonRef = 0,
            isElementBackgroundVisible = 0,
            borderCornerRadius = 0,
            background = 0
        }
        local topElementRounded = arg1.props.topElementRounded

        if topElementRounded then
            if i == 1 then
                topElementRounded = not bool1
            else
                topElementRounded = false
            end
        end

        tbl2.hasRoundTop = topElementRounded
        local bottomElementRounded = arg1.props.bottomElementRounded

        if bottomElementRounded then
            if i == #arg1.props.buttonProps then
                bottomElementRounded = not bool1
            else
                bottomElementRounded = false
            end
        end

        tbl2.hasRoundBottom = bottomElementRounded

        tbl2.hasDivider = if arg1.props.isElementDividerVisible then i < #arg1.props.buttonProps else false
        tbl2.layoutOrder = i
        tbl2.inputBindingKey = Cryo.None
        tbl2.setButtonRef = if i == 1 then arg1.props.setFirstItemRef or nil else nil
        tbl2.isElementBackgroundVisible = arg1.props.isElementBackgroundVisible
        tbl2.borderCornerRadius = arg1.props.borderCornerRadius
        tbl2.background = arg1.props.background
        local var3 = join(buttonProp, tbl2)

        if not arg1.props.isRoactGamepadEnabled then
            arg1.gamepadRefs[i] = arg1.gamepadRefs[i] or Roact.createRef()
        end

        local cursorKind = if var3.hasRoundBottom and var3.hasRoundTop then CursorKind.RoundedRectNoInset elseif var3.hasRoundBottom then CursorKind.BulletDown elseif var3.hasRoundTop then CursorKind.BulletUp else CursorKind.Square
        local var5 = Cryo.Dictionary.join(var3, { cursorKind = cursorKind, selectionOrder = arg1.props.selectionOrder })

        tbl1["cell " .. i] = withSelectionCursorProvider(function(arg2)
            return Roact.createElement(
                if arg1.props.isRoactGamepadEnabled then RoactGamepad.Focusable.Frame else "Frame",
                {
                    Size = UDim2.new(arg1.props.width, UDim.new(0, arg1.props.elementHeight)),
                    BackgroundTransparency = 1,
                    LayoutOrder = i,
                    [Roact.Ref] = arg1.gamepadRefs[i],
                    NextSelectionUp = i > 1 and arg1.gamepadRefs[i - 1] or nil,
                    NextSelectionDown = i < #arg1.props.buttonProps and arg1.gamepadRefs[i + 1] or nil,
                    inputBindings = arg1.props.isRoactGamepadEnabled
                        and {
                            Activated = RoactGamepad.Input.onBegin(Enum.KeyCode.ButtonA, buttonProp.onActivated, { key = buttonProp.inputBindingKey })
                        }
                        or nil,
                    SelectionImageObject = arg2(cursorKind)
                },
                {
                    Cell = Roact.createElement(Cell, var5)
                }
            )
        end)
    end

    tbl1.layout = Roact.createElement("UIListLayout", {
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        FillDirection = Enum.FillDirection.Vertical,
        SortOrder = Enum.SortOrder.LayoutOrder
    })

    return withStyle(function(arg2)
        local theme = arg2.Theme
        local backgroundUiDefault = theme.BackgroundUIDefault
        local background = setDefault(
            arg1.props.background,
            {
                Color = backgroundUiDefault.Color,
                Transparency = backgroundUiDefault.Transparency
            }
        )
        local isElementBackgroundVisible = arg1.props.isElementBackgroundVisible
        local var4 = bool1 and arg1.props.topElementRounded and isElementBackgroundVisible
        local var5 = bool1 and arg1.props.bottomElementRounded and isElementBackgroundVisible
        local num1 = (if var4 then 1 else 0) + (if var5 then 1 else 0)

        local renderHeader = arg1.props.renderHeader
        local clipsDescendants = not not (not var4 and renderHeader)

        if arg1.props.fixedListHeight then
            return arg1:renderFixedHeightMenu(arg1.props, arg2, tbl1)
        end

        local createElement = Roact.createElement
        local str1 = "Frame"
        local tbl2 = {
            AnchorPoint = arg1.props.anchorPoint,
            BackgroundTransparency = 1,
            LayoutOrder = arg1.props.layoutOrder,
            Size = UDim2.new(arg1.props.width.Scale, arg1.props.width.Offset, 0, yOffset),
            Position = arg1.props.position
        }
        local tbl3 = {
            DropShadow = arg1.props.showDropShadow
                and Roact.createElement(ImageSetComponent.Label, {
                    ZIndex = 2,
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 16, 1, 16),
                    Image = component_assetsDropshadow_17_8,
                    ImageColor3 = arg2.Theme.DropShadow.Color,
                    ImageTransparency = arg2.Theme.DropShadow.Transparency,
                    ScaleType = Enum.ScaleType.Slice,
                    SliceCenter = Rect.new(16, 16, 16, 16)
                })
                or nil,
            Background = if var4 or var5 then Roact.createElement(RoundedFrame, {
                zIndex = -1,
                background = background,
                topCornerRadius = if var4 then UDim.new(0, arg1.props.borderCornerRadius) else nil,
                bottomCornerRadius = if var5 then UDim.new(0, arg1.props.borderCornerRadius) else nil
            }) else nil,
            ClippingFrame = 0
        }

        local createElement2 = Roact.createElement
        local str2 = "Frame"
        local tbl4 = {
            ZIndex = 3,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, -(arg1.props.borderCornerRadius * num1)),
            Position = UDim2.fromScale(0, if var4 then 0.5 else 0),
            AnchorPoint = Vector2.new(0, if var4 then 0.5 else 0),
            ClipsDescendants = true
        }
        local tbl5 = {
            HeaderFrame = if clipsDescendants then Roact.createElement("Frame", {
                Selectable = false,
                Size = UDim2.new(1, 0, 0, headerHeight),
                Position = UDim2.fromOffset(0, 0),
                AnchorPoint = Vector2.new(0, 0),
                BackgroundTransparency = 1,
                BorderSizePixel = 0
            }, {
                Header = renderHeader()
            }) else nil,
            ScrollingFrame = Roact.createElement("ScrollingFrame", {
                [Roact.Ref] = arg1.props.setFrameRef,
                Selectable = false,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, if var4 then -4 else 0, 1, if clipsDescendants then -headerHeight else 0),
                Position = if clipsDescendants then UDim2.fromOffset(0, headerHeight) else nil,
                BorderSizePixel = 0,
                ScrollBarThickness = if bool1 then 4 else 0,
                ScrollBarImageColor3 = theme.UIEmphasis.Color,
                ScrollBarImageTransparency = theme.UIEmphasis.Transparency,
                ScrollingDirection = Enum.ScrollingDirection.Y,
                CanvasSize = UDim2.new(1, 0, 0, #arg1.props.buttonProps * arg1.props.elementHeight),
                ClipsDescendants = clipsDescendants
            }, tbl1)
        }
        tbl3.ClippingFrame = createElement2(str2, tbl4, tbl5)
        return createElement(str1, tbl2, tbl3)
    end)
end

local function BaseMenuFn(arg1)
    if arg1.enableTokenOverride then
        local var2 = useStyle()
        local buttonProps = ({})
        for i, buttonProp in ipairs(arg1.buttonProps) do
            buttonProps[i] = Cryo.Dictionary.join(buttonProp, StyleDefaults.getCellDefaultTokens(var2))
        end
        arg1 = Cryo.Dictionary.join(arg1, StyleDefaults.getBaseMenuDefaultTokens(var2), { buttonProps = buttonProps })
    end

    return React.createElement(var1, arg1)
end

return BaseMenuFn
