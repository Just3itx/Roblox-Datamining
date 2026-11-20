-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:38:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local UIBloxConfig = require(scriptParentParentParentParent.UIBloxConfig)

local Roact = require(scriptParentParentParentParentParent.Roact)
local t = require(scriptParentParentParentParentParent.t)

local FitFrameVertical = require(scriptParentParentParentParentParent.FitFrame).FitFrameVertical

local ButtonStack = require(scriptParentParentParent.Button.ButtonStack)

local ModalTitle = require(scriptParent.ModalTitle)
local ModalWindow = require(scriptParent.ModalWindow)

local var1 = Roact.PureComponent:extend("FullPageModal")

var1.validateProps = t.strictInterface({
    screenSize = t.Vector2,
    [Roact.Children] = t.table,
    position = t.optional(t.UDim2),
    title = t.optional(t.string),
    marginSize = t.optional(t.number),
    buttonStackProps = t.optional(t.table),
    footerContent = t.optional(t.callback),
    onCloseClicked = t.optional(t.callback),
    distanceFromTop = t.optional(t.number)
})

var1.defaultProps = { marginSize = 24, distanceFromTop = 0 }

function var1.init(arg1)
    arg1.state = {
        buttonFrameSize = Vector2.new(0, 0),
        footerContentSize = Vector2.new(0, 0),
        titleContainerSize = Vector2.new(0, ModalTitle:GetHeight())
    }

    arg1.buttonFrameRef = if UIBloxConfig.didMountUpdateFullPageModal then Roact.createRef() else nil
    function arg1.changeButtonFrameSize(arg2)
        if arg1.state.buttonFrameSize ~= arg2.AbsoluteSize then
            arg1:setState({ buttonFrameSize = arg2.AbsoluteSize })
        end
    end

    arg1.footerContentRef = if UIBloxConfig.didMountUpdateFullPageModal then Roact.createRef() else nil
    function arg1.changeFooterContentSize(arg2)
        if arg1.state.footerContentSize ~= arg2.AbsoluteSize then
            arg1:setState({ footerContentSize = arg2.AbsoluteSize })
        end
    end

    function arg1.changeTitleContainerSize(arg2)
        if arg1.state.titleContainerSize ~= arg2.AbsoluteSize then
            arg1:setState({ titleContainerSize = arg2.AbsoluteSize })
        end
    end
end

if UIBloxConfig.didMountUpdateFullPageModal then
    function var1.didMount(arg1)
        if arg1.buttonFrameRef.current then
            arg1:setState({ buttonFrameSize = arg1.buttonFrameRef.current.AbsoluteSize })
        end

        if arg1.footerContentRef.current then
            arg1:setState({ footerContentSize = arg1.footerContentRef.current.AbsoluteSize })
        end
    end
end

function var1.render(arg1)
    local createElement = Roact.createElement
    local var2 = ModalWindow
    local tbl1 = {
        isFullHeight = true,
        screenSize = arg1.props.screenSize,
        position = arg1.props.position,
        distanceFromTop = arg1.props.distanceFromTop
    }
    local tbl2 = {
        TitleContainer = Roact.createElement(ModalTitle, {
            title = arg1.props.title,
            onCloseClicked = arg1.props.onCloseClicked,
            onTitleSizeChanged = arg1.changeTitleContainerSize
        }),
        Content = 0
    }
    local createElement2 = Roact.createElement
    local str1 = "Frame"
    local tbl3 = {
        Size = UDim2.new(1, 0, 1, -arg1.state.titleContainerSize.Y),
        Position = UDim2.new(0, 0, 0, arg1.state.titleContainerSize.Y),
        BackgroundTransparency = 1
    }
    local tbl4 = {
        [1] = nil,
        [1] = nil,
        Roact.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Center
        }),
        Roact.createElement(
            "UIPadding",
            {
                PaddingLeft = UDim.new(0, 0),
                PaddingRight = UDim.new(0, 0),
                PaddingBottom = UDim.new(0, 24)
            }
        ),
        MiddleContent = Roact.createElement("Frame", {
            Size = UDim2.new(1, -2 * arg1.props.marginSize, 1, -(arg1.state.buttonFrameSize.Y + arg1.state.footerContentSize.Y)),
            BackgroundTransparency = 1,
            LayoutOrder = 1,
            ZIndex = 2
        }, arg1.props[Roact.Children])
    }
    local buttonStackProps = arg1.props.buttonStackProps

    if buttonStackProps then
        buttonStackProps = Roact.createElement(FitFrameVertical, {
            BackgroundTransparency = 1,
            width = UDim.new(1, 0),
            LayoutOrder = 2,
            [Roact.Change.AbsoluteSize] = arg1.changeButtonFrameSize,
            [Roact.Ref] = if UIBloxConfig.didMountUpdateFullPageModal then arg1.buttonFrameRef else nil
        }, {
            Padding = Roact.createElement("UIPadding", { PaddingLeft = UDim.new(0, 24), PaddingRight = UDim.new(0, 24) }),
            Roact.createElement(ButtonStack, arg1.props.buttonStackProps)
        })
    end

    tbl4.Buttons = buttonStackProps
    local element

    if arg1.props.footerContent then
        element = Roact.createElement("Frame", {
            Size = UDim2.new(1, -2 * arg1.props.marginSize, 0, 0),
            LayoutOrder = 3,
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.Y,
            [Roact.Change.AbsoluteSize] = arg1.changeFooterContentSize,
            [Roact.Ref] = if UIBloxConfig.didMountUpdateFullPageModal then arg1.footerContentRef else nil
        }, {
            ContentPadding = Roact.createElement("UIPadding", { PaddingTop = UDim.new(0, 24) }),
            ListLayout = Roact.createElement(
                "UIListLayout",
                {
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    SortOrder = Enum.SortOrder.LayoutOrder
                }
            ),
            FooterContent = arg1.props.footerContent()
        })
    else
        element = nil
    end

    tbl4.BottomFrame = element
    tbl2.Content = createElement2(str1, tbl3, tbl4)
    return createElement(var2, tbl1, tbl2)
end

return var1
