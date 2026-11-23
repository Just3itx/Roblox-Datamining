-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:11:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local SocialLibraries = require(AppChat.SocialLibraries)

local Roact = require(AppChatParent.Roact)
local React = require(AppChatParent.React)
local Cryo = require(AppChatParent.Cryo)
local UIBlox = require(AppChatParent.UIBlox)
local Foundation = require(AppChatParent.Foundation)
local AppCommonLibText = require(AppChatParent.AppCommonLib).Text
local memoize = require(AppChatParent.AppCommonLib).memoize

local TextButton = UIBlox.App.Button.TextButton
local Images = UIBlox.App.ImageSet.Images
local IconSize = UIBlox.App.Constant.IconSize
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

local ReactFocusNavigation = require(AppChatParent.ReactFocusNavigation)
local FocusNavigationUtils = require(AppChatParent.FocusNavigationUtils)
local FocusNavigationService = ReactFocusNavigation.FocusNavigationService
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local CoreGui = ReactFocusNavigation.EngineInterface.CoreGui

local withSelectionCursorProvider = UIBlox.App.SelectionImage.withSelectionCursorProvider
local CursorKind = UIBlox.App.SelectionImage.CursorKind

local CallbackInputBox = SocialLibraries.Components.CallbackInputBox

local iconsCommonSearch = Images["icons/common/search"]
local iconsActionsEditClear_small = Images["icons/actions/edit/clear_small"]

local tbl1 = {
    Image = Images["squircles/fill"],
    SliceCenter = Rect.new(8, 8, 9, 9)
}

local var1 = Roact.PureComponent:extend("SearchTopBar")
var1.defaultProps = {
    cancelText = "CancelPlaceholder",
    searchPlaceholderText = "PlaceholderText",
    initialInputText = nil,
    filterBoxPaddingTop = 6,
    filterBoxPaddingBottom = 6,
    filterBoxPaddingLeft = 0,
    filterBoxPaddingRight = 0,
    captureFocusOnMount = false,
    resetOnMount = function() end,
    cancelCallback = nil,
    shouldShowCancel = true,
    textChangedCallback = nil,
    LayoutOrder = 1,
    onSelectCallback = function() end,
    containerRef = nil,
    inputBoxRef = nil,
    focusNavigationEventHandlerRef = nil
}

function var1.init(arg1)
    arg1.focusNavigationService = arg1.props.focusNavigationService
    arg1.inputBoxRef = arg1.props.inputBoxRef or Roact.createRef()
    arg1.containerRef = arg1.props.containerRef or Roact.createRef()
    arg1.props.onSelectCallback()

    function arg1.focusInputBox()
        if arg1.inputBoxRef and arg1.inputBoxRef.current then
            arg1.inputBoxRef.current:CaptureFocus()
        end
    end

    arg1.getTextWidth = memoize(function(arg2, arg3, arg4)
        return AppCommonLibText.GetTextWidth(arg2, arg3, arg4)
    end)
end

function var1.didMount(arg1)
    if arg1.props.captureFocusOnMount
        and arg1.containerRef.current
        and arg1.focusNavigationService
        and arg1.focusNavigationService.focusedGuiObject:getValue() ~= nil
    then
        arg1.focusNavigationService:focusGuiObject(arg1.containerRef.current)
    end

    if arg1.inputBoxRef.current then
        arg1.inputBoxRef.current.Selectable = false
    end
    arg1.props.resetOnMount()
end

function var1.willUnmount(arg1)
    if arg1.focusNavigationService then
        arg1.focusNavigationService:teardown()
    end
end

function var1.render(arg1)
    local function textChangedCallback(arg2)
        if not (arg2 and #arg2 > 0) and arg1.focusNavigationService and arg1.inputBoxRef.current then
            if arg1.focusNavigationService.focusedGuiObject:getValue() ~= nil then
                arg1.focusNavigationService:focusGuiObject(arg1.containerRef.current)
                arg1.focusInputBox()
            else
                arg1.focusNavigationService:focusGuiObject(arg1.inputBoxRef.current)
            end
        end

        if arg1.props.textChangedCallback then
            arg1.props.textChangedCallback(arg2)
        end
    end

    return UIBlox.Style.withStyle(function(arg2)
        local cancelText = arg1.props.cancelText

        local header2 = arg2.Font.Header2
        local var2 = arg2.Font.BaseSize * header2.RelativeSize
        local textWidth = arg1.getTextWidth(cancelText, header2.Font, var2)

        local left = Enum.HorizontalAlignment.Left

        local uDim = UDim.new(0, 4)

        local uDim2 = UDim2.new(1, 0, 1, 0)

        if arg1.props.shouldShowCancel then
            uDim2 = UDim2.new(1, -textWidth - 12, 1, 0)
        end

        local body = arg2.Font.Body
        local inputTextSize = arg2.Font.BaseSize * body.RelativeSize

        return Roact.createElement("Frame", {
            BackgroundTransparency = arg2.Tokens.Color.None.Transparency,
            BackgroundColor3 = arg2.Theme.BackgroundDefault.Color,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 1, 0),
            LayoutOrder = arg1.props.LayoutOrder,
            [Roact.Ref] = arg1.props.focusNavigationEventHandlerRef
        }, {
            layout = Roact.createElement("UIListLayout", {
                VerticalAlignment = Enum.VerticalAlignment.Center,
                HorizontalAlignment = left,
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = uDim
            }),
            padding = Roact.createElement("UIPadding", {
                PaddingTop = UDim.new(0, arg1.props.filterBoxPaddingTop),
                PaddingBottom = UDim.new(0, arg1.props.filterBoxPaddingBottom),
                PaddingLeft = UDim.new(0, arg1.props.filterBoxPaddingLeft),
                PaddingRight = UDim.new(0, arg1.props.filterBoxPaddingRight)
            }),
            cancel = if arg1.props.shouldShowCancel then Roact.createElement(TextButton, { text = cancelText, layoutOrder = 2, onActivated = arg1.props.cancelCallback }) else nil,
            filterBoxContainer = withSelectionCursorProvider(function(arg3)
                return Roact.createElement(Foundation.View, {
                    Size = uDim2,
                    LayoutOrder = 1,
                    selection = {
                        Selectable = true,
                        SelectionImageObject = arg3(CursorKind.RoundedRect)
                    },
                    onActivated = arg1.focusInputBox,
                    ref = arg1.containerRef
                }, {
                    filterBoxBackground = Roact.createElement(ImageSetLabel, {
                        Size = UDim2.fromScale(1, 1),
                        Image = tbl1.Image,
                        ImageColor3 = arg2.Theme.UIDefault.Color,
                        ImageTransparency = arg2.Theme.UIDefault.Transparency,
                        ScaleType = Enum.ScaleType.Slice,
                        SliceCenter = tbl1.SliceCenter,
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Selectable = false
                    }, {
                        layout = Roact.createElement("UIListLayout", {
                            VerticalAlignment = Enum.VerticalAlignment.Center,
                            HorizontalAlignment = Enum.HorizontalAlignment.Left,
                            FillDirection = Enum.FillDirection.Horizontal,
                            SortOrder = Enum.SortOrder.LayoutOrder,
                            Padding = UDim.new(0, 4)
                        }),
                        padding = Roact.createElement("UIPadding", { PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12) }),
                        filterBoxIcon = Roact.createElement(ImageSetLabel, {
                            BackgroundTransparency = 1,
                            Size = UDim2.new(0, IconSize.Small, 0, IconSize.Small),
                            Image = iconsCommonSearch,
                            ImageColor3 = arg2.Theme.IconEmphasis.Color,
                            ImageTransparency = arg2.Theme.IconEmphasis.Transparency,
                            LayoutOrder = 1
                        }),
                        filterBoxContainer = Roact.createElement(
                            "Frame",
                            {
                                BackgroundTransparency = 1,
                                Size = UDim2.new(1, -(IconSize.Small + 4), 1, 0),
                                LayoutOrder = 2
                            },
                            {
                                filterBox = Roact.createElement(CallbackInputBox, {
                                    initialInputText = arg1.props.initialInputText,
                                    inputTextColor3 = arg2.Theme.TextEmphasis.Color,
                                    inputTextFont = arg2.Tokens.Typography.BodyLarge.Font,
                                    inputTextSize = inputTextSize,
                                    inputTextTransparency = arg2.Theme.TextEmphasis.Transparency,
                                    inputTextXAlignment = Enum.TextXAlignment.Left,
                                    placeholderText = arg1.props.searchPlaceholderText,
                                    placeholderTextColor3 = arg2.Theme.TextDefault.Color,
                                    placeholderTextTransparency = arg2.Theme.TextDefault.Transparency,
                                    captureFocusOnMount = arg1.props.captureFocusOnMount,
                                    clearIcon = iconsActionsEditClear_small,
                                    clearIconColor3 = arg2.Theme.IconEmphasis.Color,
                                    clearIconTransparency = arg2.Theme.IconEmphasis.Transparency,
                                    clearButtonSize = IconSize.Small,
                                    clearButtonDisabled = false,
                                    textChangedCallback = textChangedCallback,
                                    onSelectCallback = arg1.props.onSelectCallback,
                                    inputBoxRef = arg1.inputBoxRef,
                                    clearButtonSelectionImageObject = arg3(CursorKind.RoundedRect)
                                })
                            }
                        )
                    })
                })
            end)
        })
    end)
end

function FocusableSearchTopBar(arg1)
    local containerRef = React.useRef(nil)
    local inputBoxRef = React.useRef(nil)
    local focusNavigationService = FocusNavigationService.new(CoreGui)
    local cancelCallback = arg1.cancelCallback

    local focusNavigationEventHandlerRef = ReactFocusNavigation.useEventHandler(FocusNavigationEventNameEnum.NavigateBack, function(arg2)
        if not arg2.eventData
            or focusNavigationService.focusedGuiObject:getValue() ~= containerRef.current
            or arg2.eventData.KeyCode == Enum.KeyCode.None
        then
            return
        end
        arg2:cancel()
        if cancelCallback then
            cancelCallback()
        end
    end, "Bubble", nil)

    return Roact.createElement(
        var1,
        Cryo.Dictionary.join({
            inputBoxRef = inputBoxRef,
            containerRef = containerRef,
            focusNavigationEventHandlerRef = focusNavigationEventHandlerRef,
            focusNavigationService = focusNavigationService
        }, arg1)
    )
end

return FocusableSearchTopBar
