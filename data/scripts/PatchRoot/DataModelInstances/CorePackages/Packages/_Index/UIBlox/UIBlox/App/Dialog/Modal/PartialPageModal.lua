-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:38:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParent.Parent.Parent

local Roact = require(scriptParentParentParentParentParent.Roact)
local t = require(scriptParentParentParentParentParent.t)

local ButtonStack = require(scriptParentParentParent.Button.ButtonStack)
local CloseButtonIcon = require(script.Parent.Enum.CloseButtonIcon)

local FitFrameVertical = require(scriptParentParentParentParentParent.FitFrame).FitFrameVertical

local ModalTitle = require(scriptParent.ModalTitle)
local ModalWindow = require(scriptParent.ModalWindow)

local var1 = Roact.PureComponent:extend("PartialPageModal")

var1.validateProps = t.strictInterface({
    screenSize = t.Vector2,
    [Roact.Children] = t.table,
    position = t.optional(t.UDim2),
    anchorPoint = t.optional(t.Vector2),
    title = t.optional(t.string),
    titleBackgroundImageProps = t.optional(t.strictInterface({ image = t.string, imageHeight = t.number, text = t.optional(t.string) })),
    bottomPadding = t.optional(t.number),
    marginSize = t.optional(t.number),
    buttonStackProps = t.optional(ButtonStack.validateProps),
    footerContent = t.optional(t.callback),
    closeButtonIcon = t.optional(CloseButtonIcon.isEnumValue),
    onCloseClicked = t.optional(t.callback),
    contentPadding = t.optional(t.UDim)
})

var1.defaultProps = {
    marginSize = 24,
    closeButtonIcon = CloseButtonIcon.Close
}

function var1.render(arg1)
    local screenSize = arg1.props.screenSize
    local bottomPadding = arg1.props.bottomPadding or 24

    local bottom = if ModalWindow:isFullWidth(screenSize.X) then bottomPadding else 24

    local createElement = Roact.createElement
    local var3 = ModalWindow
    local tbl1 = {
        isFullHeight = false,
        screenSize = screenSize,
        position = arg1.props.position,
        anchorPoint = arg1.props.anchorPoint
    }
    local tbl2 = {
        TitleContainer = Roact.createElement(ModalTitle, {
            title = arg1.props.title,
            titleBackgroundImageProps = arg1.props.titleBackgroundImageProps,
            closeButtonIcon = arg1.props.closeButtonIcon,
            onCloseClicked = arg1.props.onCloseClicked
        }),
        Content = Roact.createElement(FitFrameVertical, {
            Position = UDim2.new(0, 0, 0, ModalTitle.TITLE_HEIGHT),
            width = UDim.new(1, 0),
            margin = { top = 0, bottom = bottom, left = 0, right = 0 },
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            BackgroundTransparency = 1,
            contentPadding = arg1.props.contentPadding,
            LayoutOrder = 1
        }, {
            MiddlContent = Roact.createElement(
                FitFrameVertical,
                {
                    width = UDim.new(1, -2 * arg1.props.marginSize),
                    BackgroundTransparency = 1
                },
                arg1.props[Roact.Children]
            ),
            Buttons = arg1.props.buttonStackProps
                and Roact.createElement(FitFrameVertical, {
                    BackgroundTransparency = 1,
                    width = UDim.new(1, 0),
                    LayoutOrder = 2
                }, {
                    Padding = Roact.createElement("UIPadding", { PaddingLeft = UDim.new(0, 24), PaddingRight = UDim.new(0, 24) }),
                    Roact.createElement(ButtonStack, arg1.props.buttonStackProps)
                }),
            BottomFrame = if arg1.props.footerContent then Roact.createElement(
                "Frame",
                {
                    Size = UDim2.new(1, 0, 0, 0),
                    LayoutOrder = 3,
                    BackgroundTransparency = 1,
                    AutomaticSize = Enum.AutomaticSize.Y
                },
                {
                    FooterContent = arg1.props.footerContent()
                }
            ) else nil
        })
    }
    return createElement(var3, tbl1, tbl2)
end

return var1
