-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T16:01:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local dependencies = require(scriptParentParentParent.dependencies)
local TextKeys = require(scriptParentParentParent.Common.TextKeys)
local Analytics = require(scriptParentParentParent.Analytics)
local EventNames = Analytics.EventNames
local useAnalytics = Analytics.useAnalytics

local React = dependencies.React
local UIBlox = dependencies.UIBlox
local Foundation = dependencies.Foundation
local Radius = Foundation.Enums.Radius
local Skeleton = Foundation.Skeleton

local RoactFitComponents = dependencies.RoactFitComponents
local useLocalization = dependencies.Hooks.useLocalization
local SocialLibraries = dependencies.SocialLibraries
local RoactUtils = require(scriptParentParentParentParent.RoactUtils)

local FocusNavigationUtils = require(scriptParentParentParentParent.FocusNavigationUtils)
local FocusRoot = FocusNavigationUtils.FocusRoot
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local InputHandlers = require(scriptParentParentParentParent.InputHandlers)
local _ReactFocusNavigation = require(scriptParentParentParentParent.ReactFocusNavigation)

local FitFrameVertical = RoactFitComponents.FitFrameVertical
local FitTextLabel = RoactFitComponents.FitTextLabel
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local useStyle = UIBlox.Core.Style.useStyle
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local Images = UIBlox.App.ImageSet.Images
local IconSize = UIBlox.App.Constant.IconSize
local useEffectOnce = RoactUtils.Hooks.useEffectOnce

local CallbackInputBox = SocialLibraries.Components.CallbackInputBox

local FFlagSetAliasFixFocusNavigation = require(scriptParentParentParent.Flags.FFlagSetAliasFixFocusNavigation)

return function(tbl1)
    local inputBoxRef = React.useRef(nil)
    local var2, var3 = React.useState(Vector2.new(0, 0))
    local var4, var5 = React.useState(tbl1.alias)
    local num1 = tbl1.alias and utf8.len(tbl1.alias) or 0
    local var6, var7 = React.useState(num1)

    useEffectOnce(function()
        var5(tbl1.alias)
        var7(num1)
    end, tbl1.isLoading == false)

    local var8 = useStyle()
    local font = var8.Font
    local theme = var8.Theme
    local inputTextSize = font.BaseSize * font.Body.RelativeSize
    local var10 = useLocalization({
        titleText = TextKeys.CUSTOMIZE_NAME_MODAL_TITLE,
        cancelButtonText = TextKeys.CANCEL_BUTTON,
        saveButtonText = TextKeys.SAVE_BUTTON,
        descriptionText = tbl1.displayName and {
            TextKeys.SET_CUSTOM_NAME_DESCRIPTION,
            displayName = tbl1.displayName
        }
            or TextKeys.SET_CUSTOM_NAME_NO_DISPLAY_NAME_DESCRIPTION,
        recognizeFriendsByCustomNameText = TextKeys.RECOGNIZE_FRIENDS_BY_CUSTOM_NAME_DESCRIPTION,
        customNamePlaceholderText = TextKeys.CUSTOM_NAME_PLACEHOLDER,
        invalidAliasErrorText = TextKeys.INVALID_ALIAS_ERROR
    })
    local var11 = useAnalytics()
    local var12 = React.useRef(false)

    local bool1 = not tbl1.hasSaveAliasError

    local var13 = React.useCallback(function(arg1)
        if var2.X ~= arg1.AbsoluteSize.X then
            var3(arg1.AbsoluteSize)
        end
    end, { var2 })

    local function onActivated()
        tbl1.saveOnActivated(var4)
    end

    local function func1() -- Luacid: Inlined by compiler; 1 call site recovered
        if var11 then
            var11.fireAnalyticsEvent(EventNames.CustomizeNameModalClosed)
        end
        tbl1.cancelOnActivated()
    end

    local function textChangedCallback(str1: string)
        local num2 = utf8.len(str1)
        if num2 == nil then
            return
        end

        if num2 > 20 then
            if var6 == 20 then
                str1 = var4
            else
                str1 = string.sub(str1, 1, utf8.offset(str1, 21) - 1)
            end
            num2 = 20
            if inputBoxRef and inputBoxRef.current then
                inputBoxRef.current.Text = str1
            end
        end
        var7(num2)
        var5(str1)

        if tbl1.onTextChanged then
            tbl1.onTextChanged()
        end

        if num2 == 0 and var11 then
            var11.fireAnalyticsEvent(EventNames.CustomizeNameClearedInput)
        end

        if num2 == 20 and var11 and not var12.current then
            var12.current = true
            var11.fireAnalyticsEvent(EventNames.CustomizeNameMaximumCharLimitTyped, { alias = str1 })
        end
    end

    local eventHandlers = if FFlagSetAliasFixFocusNavigation then React.useMemo(function()
        local result = {}
        result[FocusNavigationEventNameEnum.NavigateBack] = {
            handler = InputHandlers.onRelease(function(arg1)
                func1()
                arg1:cancel()
            end)
        }
        return result
    end, { func1 }) else nil

    local alert = React.createElement(InteractiveAlert, {
        title = var10.titleText,
        screenSize = tbl1.screenSize,
        anchorPoint = Vector2.new(0.5, 0),
        position = UDim2.new(0.5, 0, 0, var2.Y),
        middleContent = function()
            local createElement = React.createElement
            local var15 = FitFrameVertical
            local tbl2 = {
                BackgroundTransparency = 1,
                width = UDim.new(1, 0),
                FillDirection = Enum.FillDirection.Vertical,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                contentPadding = UDim.new(0, 16),
                [React.Change.AbsoluteSize] = var13
            }
            local tbl3 = { InputGroup = 0, Counter = 0 }
            local createElement2 = React.createElement
            local str1 = "Frame"
            local tbl4 = {
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                LayoutOrder = 1
            }
            local tbl5 = {
                UIListLayout = React.createElement("UIListLayout", {
                    FillDirection = Enum.FillDirection.Vertical,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    SortOrder = Enum.SortOrder.LayoutOrder
                }),
                Description = React.createElement(FitTextLabel, {
                    LayoutOrder = 1,
                    BackgroundTransparency = 1,
                    TextWrapped = true,
                    width = FitTextLabel.Width.FitToText,
                    maximumWidth = var2.X,
                    Font = font.Body.Font,
                    Text = var10.descriptionText,
                    TextSize = font.BaseSize * font.Body.RelativeSize,
                    TextColor3 = theme.TextDefault.Color,
                    RichText = true
                }),
                RecognizeFriendsByCustomNameContainer = React.createElement(
                    "Frame",
                    {
                        BackgroundTransparency = 1,
                        Size = UDim2.fromScale(1, 0),
                        AutomaticSize = Enum.AutomaticSize.Y,
                        LayoutOrder = 2
                    },
                    {
                        UIPadding = React.createElement("UIPadding", { PaddingTop = UDim.new(0, 2), PaddingBottom = UDim.new(0, 24) }),
                        RecognizeFriendsByCustomName = React.createElement(FitTextLabel, {
                            LayoutOrder = 1,
                            BackgroundTransparency = 1,
                            TextWrapped = true,
                            width = FitTextLabel.Width.FitToText,
                            maximumWidth = var2.X,
                            Font = font.CaptionBody.Font,
                            Text = var10.recognizeFriendsByCustomNameText,
                            TextSize = font.BaseSize * font.CaptionBody.RelativeSize,
                            TextColor3 = theme.TextDefault.Color
                        })
                    }
                ),
                LoadingShimmer = if tbl1.isLoading then React.createElement(
                    Skeleton,
                    {
                        Size = UDim2.new(1, 0, 0, inputTextSize + 20),
                        LayoutOrder = 3,
                        radius = Radius.Medium
                    }
                ) else nil,
                InputBackground = 0
            }
            local var16

            if tbl1.isLoading then
                var16 = nil
            else
                local createElement3 = React.createElement
                local var17 = ImageSetLabel
                local tbl6 = {
                    Size = UDim2.new(1, 0, 0, inputTextSize + 20),
                    BackgroundTransparency = 1,
                    LayoutOrder = 3,
                    Image = Images["component_assets/circle_21"],
                    ImageColor3 = theme.UIMuted.Color,
                    ImageTransparency = theme.UIMuted.Transparency,
                    ScaleType = Enum.ScaleType.Slice,
                    SliceCenter = Rect.new(8, 8, 9, 9)
                }
                local tbl7 = {
                    InputBorder = React.createElement(ImageSetLabel, {
                        Size = UDim2.new(1, 0, 0, inputTextSize + 20),
                        BackgroundTransparency = 1,
                        LayoutOrder = 1,
                        Image = Images["component_assets/circle_21_stroke_1"],
                        ImageColor3 = if tbl1.hasSaveAliasError then theme.Alert.Color else theme.Divider.Color,
                        ScaleType = Enum.ScaleType.Slice,
                        SliceCenter = Rect.new(8, 8, 9, 9)
                    }, {
                        Padding = React.createElement("UIPadding", { PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12) }),
                        Textbox = React.createElement(CallbackInputBox, {
                            inputTextXAlignment = Enum.TextXAlignment.Left,
                            inputTextColor3 = theme.TextDefault.Color,
                            inputTextTransparency = theme.TextDefault.Transparency,
                            inputTextSize = inputTextSize,
                            initialInputText = tbl1.alias,
                            placeholderText = var10.customNamePlaceholderText,
                            placeholderTextColor3 = theme.TextDefault.Color,
                            captureFocusOnMount = true,
                            clearIcon = Images["icons/actions/edit/clear_small"],
                            clearIconColor3 = theme.IconEmphasis.Color,
                            clearIconTransparency = theme.IconEmphasis.Transparency,
                            clearButtonSize = IconSize.Small,
                            clearButtonDisabled = false,
                            textChangedCallback = textChangedCallback,
                            inputBoxRef = inputBoxRef
                        })
                    })
                }
                var16 = createElement3(var17, tbl6, tbl7)
            end

            tbl5.InputBackground = var16
            tbl3.InputGroup = createElement2(str1, tbl4, tbl5)

            tbl3.Counter = React.createElement(
                "Frame",
                {
                    BackgroundTransparency = 1,
                    Size = UDim2.fromScale(1, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    LayoutOrder = 2
                },
                {
                    React.createElement(FitTextLabel, {
                        BackgroundTransparency = 1,
                        width = FitTextLabel.Width.FitToText,
                        maximumWidth = var2.X,
                        Font = font.CaptionBody.Font,
                        Text = if tbl1.hasSaveAliasError then var10.invalidAliasErrorText else string.format("%d/%d", var6, 20),
                        TextSize = font.BaseSize * font.CaptionBody.RelativeSize,
                        TextColor3 = if var6 == 20 or tbl1.hasSaveAliasError then theme.Alert.Color else theme.TextMuted.Color,
                        TextTransparency = if var6 == 20 or tbl1.hasSaveAliasError then theme.Alert.Transparency else theme.TextMuted.Transparency,
                        AnchorPoint = if tbl1.hasSaveAliasError then Vector2.new(0, 0.5) else Vector2.new(1, 0.5),
                        Position = if tbl1.hasSaveAliasError then nil else UDim2.fromScale(1, 0)
                    }, {
                        UISizeConstraint = React.createElement(
                            "UISizeConstraint",
                            {
                                MaxSize = Vector2.new(math.huge, font.BaseSize * font.CaptionBody.RelativeSize * 2)
                            }
                        )
                    })
                }
            )
            return createElement(var15, tbl2, tbl3)
        end,
        buttonStackInfo = {
            buttons = {
                {
                    buttonType = ButtonType.Secondary,
                    props = {
                        onActivated = func1,
                        text = var10.cancelButtonText
                    }
                },
                {
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        onActivated = onActivated,
                        text = var10.saveButtonText,
                        isDisabled = not bool1
                    }
                }
            },
            buttonHeight = 48,
            marginBetween = 6,
            forcedFillDirection = Enum.FillDirection.Horizontal
        }
    })

    if not FFlagSetAliasFixFocusNavigation then
        return alert
    end

    return React.createElement(FocusRoot, {
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp,
        isAutoFocusRoot = true,
        isIsolated = true,
        eventHandlers = eventHandlers
    }, { Alert = alert })
end
