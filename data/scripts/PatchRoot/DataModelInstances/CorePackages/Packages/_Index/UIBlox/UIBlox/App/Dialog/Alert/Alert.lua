-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:31:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local Roact = require(scriptParentParentParentParentParent.Roact)
local t = require(scriptParentParentParentParentParent.t)
local RoactGamepad = require(scriptParentParentParentParentParent.RoactGamepad)
local Cryo = require(scriptParentParentParentParentParent.Cryo)

local Images = require(scriptParentParentParent.ImageSet.Images)
local ImageSetComponent = require(scriptParentParentParentParent.Core.ImageSet.ImageSetComponent)
local withStyle = require(scriptParentParentParentParent.Core.Style.withStyle)

local ButtonStack = require(scriptParentParentParent.Button.ButtonStack)

local FitFrameOnAxis = require(scriptParentParentParentParentParent.FitFrame).FitFrameOnAxis

local AlertType = require(scriptParent.Enum.AlertType)
local AlertTitle = require(scriptParent.AlertTitle)

local var1 = Roact.PureComponent:extend("Alert")

var1.validateProps = t.strictInterface({
    alertType = AlertType.isEnumValue,
    maxWidth = t.optional(t.number),
    minWidth = t.optional(t.number),
    margin = t.optional(t.table),
    anchorPoint = t.optional(t.Vector2),
    onMounted = t.optional(t.callback),
    onAbsoluteSizeChanged = t.optional(t.callback),
    position = t.optional(t.UDim2),
    screenSize = t.Vector2,
    title = t.string,
    titleContent = t.optional(t.callback),
    middleContent = t.optional(t.callback),
    buttonStackInfo = t.optional(ButtonStack.validateProps),
    footerContent = t.optional(t.callback),
    onCloseClicked = t.optional(t.callback),
    defaultChildRef = t.optional(t.union(t.table, t.callback)),
    isMiddleContentFocusable = t.optional(t.boolean),
    isFooterContentFocusable = t.optional(t.boolean),
    isRoactGamepadEnabled = t.optional(t.boolean)
})

var1.defaultProps = {
    anchorPoint = Vector2.new(0.5, 0.5),
    margin = { top = 0, bottom = 24, left = 24, right = 24 },
    maxWidth = 400,
    minWidth = 272,
    position = UDim2.new(0.5, 0, 0.5, 0),
    isRoactGamepadEnabled = true
}

function var1.init(arg1)
    local contentSize, changeContentSize = Roact.createBinding(Vector2.new(0, 0))
    arg1.contentSize = contentSize
    arg1.changeContentSize = changeContentSize

    arg1.middleContentRef = Roact.createRef()
    arg1.footerContentRef = Roact.createRef()
    arg1.buttonStackRef = Roact.createRef()
end

function var1.didMount(arg1)
    if arg1.props.onMounted then
        arg1.props.onMounted()
    end
end

function var1.render(arg1)
    local isMiddleContentFocusable = arg1.props.isMiddleContentFocusable
    local isFooterContentFocusable = arg1.props.isFooterContentFocusable
    local isRoactGamepadEnabled = arg1.props.isRoactGamepadEnabled

    local xOffset = math.clamp(
        arg1.props.screenSize.X - arg1.props.margin.left - arg1.props.margin.right,
        arg1.props.minWidth,
        arg1.props.maxWidth
    )

    return withStyle(function(arg2)
        local theme = arg2.Theme

        local backgroundUiDefaultColor = nil
        local backgroundUiDefaultTransparency, backgroundUiContrastTransparency

        if arg1.props.alertType == AlertType.Interactive then
            backgroundUiDefaultColor = theme.BackgroundUIDefault.Color
            backgroundUiDefaultTransparency = theme.BackgroundUIDefault.Transparency
            backgroundUiContrastTransparency = 1
        else
            backgroundUiContrastTransparency = theme.BackgroundUIContrast.Transparency
            backgroundUiDefaultTransparency = 1
        end

        local buttonStackInfo = arg1.props.buttonStackInfo

        buttonStackInfo = buttonStackInfo
            and Cryo.Dictionary.join(buttonStackInfo, {
                [Roact.Ref] = if isRoactGamepadEnabled then arg1.buttonStackRef else nil,
                NextSelectionUp = if isRoactGamepadEnabled then isMiddleContentFocusable and arg1.middleContentRef or nil else nil,
                NextSelectionDown = if isRoactGamepadEnabled then isFooterContentFocusable and arg1.footerContentRef or nil else nil,
                isRoactGamepadEnabled = isRoactGamepadEnabled
            })

        local createElement = Roact.createElement
        local var2 = if isRoactGamepadEnabled then RoactGamepad.Focusable[ImageSetComponent.Button] else ImageSetComponent.Button

        local tbl1 = {
            Position = arg1.props.position,
            AnchorPoint = arg1.props.anchorPoint,
            Size = arg1.contentSize:map(function(arg3): UDim2
                return UDim2.new(0, arg3.X, 0, arg3.Y)
            end),
            BackgroundColor3 = theme.BackgroundUIDefault.Color,
            BackgroundTransparency = backgroundUiContrastTransparency,
            BorderSizePixel = 0,
            Image = Images["component_assets/circle_17"],
            ImageColor3 = backgroundUiDefaultColor,
            ImageTransparency = backgroundUiDefaultTransparency,
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(8, 8, 9, 9),
            AutoButtonColor = false,
            ClipsDescendants = true,
            Selectable = false,
            [Roact.Ref] = if isRoactGamepadEnabled then arg1.props.defaultChildRef else nil,
            [Roact.Change.AbsoluteSize] = arg1.props.onAbsoluteSizeChanged,
            defaultChild = if isRoactGamepadEnabled then arg1.buttonStackRef else nil
        }
        local tbl2 = { AlertContents = 0 }
        local createElement2 = Roact.createElement
        local var3 = FitFrameOnAxis
        local tbl3 = {
            contentPadding = UDim.new(0, 24),
            margin = arg1.props.margin,
            minimumSize = UDim2.new(0, xOffset, 0, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0
        }

        tbl3[Roact.Change.AbsoluteSize] = function(arg3)
            arg1.changeContentSize(arg3.AbsoluteSize)
        end
        local tbl4 = {
            TitleContainer = Roact.createElement(AlertTitle, {
                layoutOrder = 1,
                margin = arg1.props.margin,
                maxWidth = arg1.props.maxWidth,
                minWidth = arg1.props.minWidth,
                screenSize = arg1.props.screenSize,
                title = arg1.props.title,
                titleContent = arg1.props.titleContent,
                onCloseClicked = arg1.props.onCloseClicked
            }),
            MiddleContent = 0,
            Footer = 0
        }
        local middleContent = arg1.props.middleContent

        if middleContent then
            middleContent = Roact.createElement(
                if isRoactGamepadEnabled then RoactGamepad.Focusable[FitFrameOnAxis] else FitFrameOnAxis,
                {
                    BackgroundTransparency = 1,
                    LayoutOrder = 2,
                    minimumSize = UDim2.new(1, 0, 0, 0),
                    [Roact.Ref] = if isRoactGamepadEnabled then arg1.middleContentRef else nil,
                    NextSelectionDown = if isRoactGamepadEnabled then isMiddleContentFocusable and arg1.buttonStackRef or nil else nil
                },
                {
                    Content = arg1.props.middleContent()
                }
            )
        end

        tbl4.MiddleContent = middleContent

        local createElement3 = Roact.createElement
        local var4 = FitFrameOnAxis
        local tbl5 = {
            BackgroundTransparency = 1,
            contentPadding = UDim.new(0, 12),
            LayoutOrder = 3,
            minimumSize = UDim2.new(1, 0, 0, 0)
        }
        local tbl6 = {
            Buttons = buttonStackInfo and Roact.createElement(ButtonStack, buttonStackInfo),
            FooterContent = 0
        }
        local footerContent = arg1.props.footerContent

        if footerContent then
            footerContent = Roact.createElement(
                if isRoactGamepadEnabled then RoactGamepad.Focusable[FitFrameOnAxis] else FitFrameOnAxis,
                {
                    BackgroundTransparency = 1,
                    LayoutOrder = 5,
                    minimumSize = UDim2.new(1, 0, 0, 0),
                    [Roact.Ref] = if isRoactGamepadEnabled then arg1.footerContentRef else nil,
                    NextSelectionUp = if isRoactGamepadEnabled then isFooterContentFocusable and arg1.buttonStackRef or nil else nil
                },
                {
                    Content = arg1.props.footerContent()
                }
            )
        end

        tbl6.FooterContent = footerContent
        tbl4.Footer = createElement3(var4, tbl5, tbl6)
        tbl2.AlertContents = createElement2(var3, tbl3, tbl4) or nil
        return createElement(var2, tbl1, tbl2)
    end)
end

return var1
