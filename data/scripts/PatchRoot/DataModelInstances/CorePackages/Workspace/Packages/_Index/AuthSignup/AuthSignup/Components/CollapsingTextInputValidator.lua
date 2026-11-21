-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:20:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthSignupParent = script:FindFirstAncestor("AuthSignup").Parent

local Roact = require(AuthSignupParent.Roact)

local Otter = require(AuthSignupParent.Otter)
local UIBlox = require(AuthSignupParent.UIBlox)
local Foundation = require(AuthSignupParent.Foundation)
local IconSize = Foundation.Enums.IconSize
local Loading = Foundation.Loading

local OpenTypeSupport = UIBlox.Utility.OpenTypeSupport
local withStyle = UIBlox.Style.withStyle
local withLocalization = require(AuthSignupParent.Localization).withLocalization

local AuthCommon = require(AuthSignupParent.AuthCommon)
local formatBoldRichText = AuthCommon.Utils.formatBoldRichText
local FitChildren = AuthCommon.Components.FitChildren
local FitTextLabel = AuthCommon.Components.FitTextLabel
local AuthStatefulRoundCornerBorder = AuthCommon.Components.AuthStatefulRoundCornerBorder
local PasswordBox = AuthCommon.Components.PasswordBox
local GenericTextBox = AuthCommon.Components.GenericTextBox
local IssueTracker = AuthCommon.Components.IssueTracker

local InputValidity = AuthCommon.Enums.InputValidity
local RegisterAuditContent = AuthCommon.Components.RegisterAuditContent

local TextInput = Foundation.TextInput
local InputLabel = Foundation.InputLabel

local var1 = Roact.PureComponent:extend("CollapsingTextInputValidator")

local SharedFlags = require(AuthSignupParent.SharedFlags)
local GetFFlagLuaAppEnable10ftSignUpView = SharedFlags.GetFFlagLuaAppEnable10ftSignUpView
local GetFFlagEnableAuthStatefulTextInputUpdates = SharedFlags.GetFFlagEnableAuthStatefulTextInputUpdates
local FFlagSignUpTrackFailedRequest = SharedFlags.FFlagSignUpTrackFailedRequest
local GetFFlagLuaAppEnableOpenTypeSupport = SharedFlags.GetFFlagLuaAppEnableOpenTypeSupport
local GetFFlagLuaAppEnableOpenTypeSignUpPageFix = SharedFlags.GetFFlagLuaAppEnableOpenTypeSignUpPageFix
local engineFeature = game:GetEngineFeature("EnableAndroidPasswordSuggestion")
local GetFFlagEnableAuditForSinglePageSignUp = SharedFlags.GetFFlagEnableAuditForSinglePageSignUp
local GetFFlagAuthCollapsingValidatorFoundationInput = SharedFlags.GetFFlagAuthCollapsingValidatorFoundationInput
local FFlagAuthValidatorStyleOverrides = SharedFlags.FFlagAuthValidatorStyleOverrides
local FFlagAuthValidatorRebindTextBoxRef = SharedFlags.FFlagAuthValidatorRebindTextBoxRef

local function computeIsInErrorState(arg1, arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
    return if FFlagSignUpTrackFailedRequest and arg1.hasFieldFailed then true elseif arg1.prerequisiteMet then not (arg2.inputTextToValidate == "") and arg2.isInputTextValid == InputValidity.Invalid and arg2.interactionBegan else arg2.textBoxFocused or arg2.interactionBegan and arg2.inputTextToValidate ~= ""
end

var1.defaultProps = { prerequisiteMet = true, captureFocusOnTapStart = true }

function var1.init(arg1)
    arg1.state = {
        inputTextToValidate = "",
        validatedInputText = "",
        isInputTextValid = InputValidity.Unvalidated,
        interactionBegan = false,
        textBoxFocused = false,
        textBoxHover = false,
        issueSummaryHeight = 0,
        issueFullListHeight = 0
    }

    arg1.isMounted = false
    arg1.frameRef = Roact.createRef()

    if arg1:isUsingFoundationTextInput() then
        arg1.foundationTextBoxRef = Roact.createRef()
        arg1.foundationProxyText = arg1.props.prefilledText or ""
        arg1.foundationTextBoxProxy = nil
    end

    if FFlagAuthValidatorRebindTextBoxRef and arg1.foundationTextBoxRef == nil then
        arg1.foundationTextBoxRef = Roact.createRef()
    end

    function arg1.getFrameRef()
        return arg1.props.frameRef or arg1.frameRef
    end

    local issueSummaryTextTransparency, updateIssueSummaryTextTransparency = Roact.createBinding(1)
    arg1.issueSummaryTextTransparency = issueSummaryTextTransparency
    arg1.updateIssueSummaryTextTransparency = updateIssueSummaryTextTransparency
    local issueFullListTextTransparency, updateIssueFullListTextTransparency = Roact.createBinding(1)
    arg1.issueFullListTextTransparency = issueFullListTextTransparency
    arg1.updateIssueFullListTextTransparency = updateIssueFullListTextTransparency
    local issueCheckmarkTransparency, updateIssueCheckmarkTransparency = Roact.createBinding(1)
    arg1.issueCheckmarkTransparency = issueCheckmarkTransparency
    arg1.updateIssueCheckmarkTransparency = updateIssueCheckmarkTransparency
    local issueTrackerHeight, updateIssueTrackerHeight = Roact.createBinding(UDim2.new(1, 0, 0, 0))
    arg1.issueTrackerHeight = issueTrackerHeight
    arg1.updateIssueTrackerHeight = updateIssueTrackerHeight

    function arg1.getContentGap()
        if FFlagAuthValidatorStyleOverrides and arg1.props.contentGapOverride then
            return arg1.props.contentGapOverride
        end

        if GetFFlagLuaAppEnable10ftSignUpView() and arg1.props.tokens then
            return arg1.props.tokens.boxPadding
        end

        return 5
    end

    arg1.issueTrailingPadding = arg1.issueTrackerHeight:map(function(uDim2: UDim2)
        return UDim.new(0, -math.max(0, arg1.getContentGap() - uDim2.Y.Offset))
    end)

    arg1.springOptions = { frequency = 3 }

    function arg1.onSizeChange(arg2, arg3)
        local absoluteSize = arg3.AbsoluteSize

        if not (absoluteSize.X > 0) or not (absoluteSize.Y > 0) then
            return
        end

        spawn(function()
            if arg1.isMounted then
                arg1:setState({ [arg2] = absoluteSize.Y })
            end
        end)
    end

    function arg1.onIssueSummarySizeChange(arg2)
        arg1.onSizeChange("issueSummaryHeight", arg2)
    end

    function arg1.onIssueFullListSizeChange(arg2)
        arg1.onSizeChange("issueFullListHeight", arg2)
    end

    function arg1.textInputChangedCallback(arg2)
        spawn(function()
            if not arg1.isMounted then
                return
            end

            local text = arg2.Text
            local onInputTextChanged = arg1.props.onInputTextChanged

            if onInputTextChanged then
                onInputTextChanged(text, InputValidity.Unvalidated)
            end

            arg1:setState({ inputTextToValidate = text, isInputTextValid = InputValidity.Unvalidated, interactionBegan = true })
        end)
    end

    function arg1.foundationTextInputChangedCallback(foundationProxyText)
        arg1.foundationProxyText = foundationProxyText
        arg1.textInputChangedCallback({ Text = foundationProxyText })
    end

    function arg1.bindFoundationTextBoxProxy()
        local textBoxRef = arg1.props.textBoxRef
        if textBoxRef == nil or arg1.foundationTextBoxProxy ~= nil then
            return
        end

        local tbl1 = {
            CaptureFocus = function()
                local current = arg1.foundationTextBoxRef.current
                if current and current.focus then
                    current.focus()
                end
            end,
            ReleaseFocus = function()
                local current = arg1.foundationTextBoxRef.current
                if current and current.releaseFocus then
                    current.releaseFocus()
                end
            end,
            IsFocused = function(): boolean
                local current = arg1.foundationTextBoxRef.current
                return if current and current.getIsFocused then current.getIsFocused() == true else false
            end
        }

        setmetatable(tbl1, {
            __index = function(_, arg2)
                return if arg2 == "Text" then arg1.foundationProxyText or "" else nil
            end,
            __newindex = function(_, arg2, arg3)
                if arg2 == "Text" then
                    local foundationProxyText = if typeof(arg3) ~= "string" then "" else arg3
                    arg1.foundationProxyText = foundationProxyText
                    arg1.foundationTextInputChangedCallback(foundationProxyText)
                    return
                end
                rawset(tbl1, arg2, arg3)
            end
        })

        arg1.foundationTextBoxProxy = tbl1
        textBoxRef.current = tbl1
    end

    function arg1.onTextValidated(validatedInputText, isInputTextValid, arg2)
        spawn(function()
            if not arg1.isMounted or arg1.state.inputTextToValidate ~= validatedInputText then
                return
            end

            local onInputTextValidated = arg1.props.onInputTextValidated

            if onInputTextValidated then
                if FFlagSignUpTrackFailedRequest then
                    onInputTextValidated(validatedInputText, isInputTextValid, arg2)
                else
                    onInputTextValidated(validatedInputText, isInputTextValid)
                end
            end

            arg1:setState({ validatedInputText = validatedInputText, isInputTextValid = isInputTextValid })
        end)
    end

    function arg1.onTextInputBoxFocused()
        spawn(function()
            if not arg1.isMounted then
                return
            end

            local frameRef = arg1.getFrameRef()
            if arg1.props.textBoxFocusedCallback and frameRef.current then
                arg1.props.textBoxFocusedCallback(frameRef.current.AbsolutePosition)
            end

            arg1:setState({ textBoxFocused = true })
        end)
    end

    function arg1.onMouseEnter()
        if arg1.isMounted then
            arg1:setState({ textBoxHover = true })
        end
    end

    function arg1.onMouseLeave()
        if arg1.isMounted then
            arg1:setState({ textBoxHover = false })
        end
    end

    function arg1.onTextInputBoxFocusLost()
        spawn(function()
            if not arg1.isMounted then
                return
            end

            if arg1.props.textBoxFocusLostCallback then
                arg1.props.textBoxFocusLostCallback()
            end

            arg1:setState({ textBoxFocused = false })
        end)
    end

    function arg1.onPositionChanged()
        spawn(function()
            if not arg1.isMounted or not arg1.state.textBoxFocused then
                return
            end

            local frameRef = arg1.getFrameRef()
            if arg1.props.focusedTextBoxPositionChangedCallback and frameRef.current then
                arg1.props.focusedTextBoxPositionChangedCallback(frameRef.current.AbsolutePosition)
            end
        end)
    end

    function arg1.isInErrorState()
        local props = arg1.props
        local state = arg1.state

        if FFlagSignUpTrackFailedRequest and props.hasFieldFailed then
            return true
        end

        local var10

        if not props.prerequisiteMet then
            var10 = state.textBoxFocused

            if not var10 then
                var10 = state.interactionBegan

                if var10 then
                    return state.inputTextToValidate ~= ""
                end
            end
        else
            if state.inputTextToValidate == "" then
                return false
            end

            if state.isInputTextValid == InputValidity.Invalid then
                return state.interactionBegan
            end

            var10 = false
        end
        return var10
    end

    function arg1.textInputBoxWithBorder()
        return withStyle(function(arg2)
            local tokens = arg1.props.tokens
            local font = arg2.Font.Body.Font
            local var10 = arg2.Font.BaseSize * arg2.Font.Body.RelativeSize
            if GetFFlagLuaAppEnable10ftSignUpView() and tokens then
                var10 = tokens.textBodySize
            end
            local textDefaultColor = arg2.Theme.TextDefault.Color
            local textDefaultTransparency = arg2.Theme.TextDefault.Transparency
            local backgroundUiContrastColor = arg2.Theme.BackgroundUIContrast.Color
            local backgroundUiContrastTransparency = arg2.Theme.BackgroundUIContrast.Transparency
            local textDefaultColor2 = arg2.Theme.TextDefault.Color

            local placeholderText = arg1.props.placeholderText
            local textInputType = arg1.props.textInputType
            local returnKeyType = arg1.props.returnKeyType

            local prefilledText = arg1.props.prefilledText or ""

            if textInputType == Enum.TextInputType.Password or engineFeature and textInputType == Enum.TextInputType.NewPassword then
                return Roact.createElement(PasswordBox, {
                    Size = UDim2.new(1, 0, 1, 0),
                    Color = backgroundUiContrastColor,
                    Transparency = backgroundUiContrastTransparency,
                    TextSize = var10,
                    TextColor = textDefaultColor,
                    TextTransparency = textDefaultTransparency,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Text = "",
                    PlaceholderText = placeholderText,
                    PlaceholderColor3 = nil,
                    PlaceholderColor = textDefaultColor2,
                    ReturnKeyType = returnKeyType,
                    ManualFocusRelease = false,
                    CaptureFocusOnTapStart = arg1.props.captureFocusOnTapStart,
                    Disabled = arg1.props.disabled,
                    onChangeText = arg1.textInputChangedCallback,
                    onFocused = arg1.onTextInputBoxFocused,
                    onFocusLost = arg1.onTextInputBoxFocusLost,
                    onMouseEnter = arg1.onMouseEnter,
                    onMouseLeave = arg1.onMouseLeave,
                    onReturnPressedFromOnScreenKeyboard = arg1.props.onReturnPressedFromOnScreenKeyboard,
                    IsKeyboardOverlayUsed = arg1.props.IsKeyboardOverlayUsed,
                    TextBoxRef = arg1.props.textBoxRef,
                    CentralOverlayBlocksInput = arg1.props.centralOverlayBlocksInput,
                    hidePassword = arg1.props.hidePassword,
                    onToggleCallback = arg1.props.onToggleCallback,
                    IsNewPassword = engineFeature
                        and (textInputType == Enum.TextInputType.NewPassword or textInputType == Enum.TextInputType.NewPasswordShown)
                })
            end

            return Roact.createElement(GenericTextBox, {
                Size = UDim2.new(1, 0, 1, 0),
                Text = prefilledText,
                Font = font,
                TextSize = var10,
                TextColor = textDefaultColor,
                TextTransparency = textDefaultTransparency,
                TextXAlignment = Enum.TextXAlignment.Left,
                ClearTextOnFocus = false,
                Color = backgroundUiContrastColor,
                Transparency = backgroundUiContrastTransparency,
                TextInputType = textInputType,
                openTypeFeatures = if GetFFlagLuaAppEnableOpenTypeSupport() and GetFFlagLuaAppEnableOpenTypeSignUpPageFix() then OpenTypeSupport:getUserNameStylisticAlternative() else nil,
                ReturnKeyType = returnKeyType,
                PaddingX = 12,
                PaddingY = 7,
                PlaceholderText = placeholderText,
                PlaceholderColor = textDefaultColor2,
                onChangeText = arg1.textInputChangedCallback,
                onFocused = arg1.onTextInputBoxFocused,
                onFocusLost = arg1.onTextInputBoxFocusLost,
                onMouseEnter = arg1.onMouseEnter,
                onMouseLeave = arg1.onMouseLeave,
                onReturnPressedFromOnScreenKeyboard = arg1.props.onReturnPressedFromOnScreenKeyboard,
                NextSelectionDown = arg1.props.NextSelectionDown,
                TextBoxRef = arg1.props.textBoxRef
            })
        end)
    end

    function arg1.textInputBoxFoundation()
        local foundationInputSize, foundationIconTrailing

        if FFlagAuthValidatorStyleOverrides then
            foundationInputSize = arg1.props.foundationInputSize
            foundationIconTrailing = arg1.props.foundationIconTrailing
        else
            foundationInputSize = nil
            foundationIconTrailing = nil
        end

        return Roact.createElement(TextInput, {
            LayoutOrder = 1,
            width = UDim.new(1, 0),
            size = foundationInputSize,
            iconTrailing = foundationIconTrailing,
            label = "",
            text = arg1.foundationProxyText or "",
            placeholder = arg1.props.placeholderText,
            textInputType = arg1.props.textInputType,
            hasError = arg1.isInErrorState(),
            isDisabled = arg1.props.disabled,
            onChanged = arg1.foundationTextInputChangedCallback,
            onFocusGained = arg1.onTextInputBoxFocused,
            onFocusLost = arg1.onTextInputBoxFocusLost,
            onReturnPressed = arg1.props.onReturnPressedFromOnScreenKeyboard,
            textBoxRef = arg1.foundationTextBoxRef,
            inputRef = arg1.props.foundationInputRef,
            NextSelectionDown = arg1.props.NextSelectionDown
        })
    end
end

function var1.isUsingFoundationTextInput(arg1)
    if FFlagAuthValidatorStyleOverrides then
        return arg1.props.useFoundationTextInput
    end

    return arg1.props.useFoundationTextInput and GetFFlagAuthCollapsingValidatorFoundationInput()
end

function var1.didMount(arg1)
    arg1.isMounted = true

    if arg1:isUsingFoundationTextInput() then
        arg1.bindFoundationTextBoxProxy()
    end

    arg1.motor = Otter.createGroupMotor({
        issueSummaryTextTransparency = 1,
        issueFullListTextTransparency = 1,
        issueCheckmarkTransparency = 1,
        issueTrackerHeight = 0
    })

    arg1.motor:onStep(function(arg2)
        arg1.updateIssueSummaryTextTransparency(arg2.issueSummaryTextTransparency)
        arg1.updateIssueFullListTextTransparency(arg2.issueFullListTextTransparency)
        arg1.updateIssueCheckmarkTransparency(arg2.issueCheckmarkTransparency)
        arg1.updateIssueTrackerHeight(UDim2.new(1, 0, 0, arg2.issueTrackerHeight))
    end)

    arg1.motor:onComplete(function()
        if arg1.props.onAnimationStateChangeCallback then
            arg1.props.onAnimationStateChangeCallback(arg1.props.textInputType, false)
        end
    end)

    arg1.motor:start()

    local prefilledText = arg1.props.prefilledText
    if not prefilledText or prefilledText == "" then
        return
    end

    arg1:setState(
        {
            inputTextToValidate = prefilledText,
            isInputTextValid = InputValidity.Unvalidated,
            interactionBegan = false
        }
    )
end

function var1.didUpdate(arg1, arg2, arg3)
    if arg1:isUsingFoundationTextInput() and arg2.prefilledText ~= arg1.props.prefilledText then
        arg1.foundationTextInputChangedCallback(arg1.props.prefilledText or "")
    end

    if FFlagAuthValidatorRebindTextBoxRef and arg2.useFoundationTextInput ~= arg1.props.useFoundationTextInput then
        if arg1:isUsingFoundationTextInput() then
            arg1.bindFoundationTextBoxProxy()
        else
            arg1.foundationTextBoxProxy = nil
            arg1.foundationProxyText = nil
        end
    end

    local textBoxFocused = arg1.state.textBoxFocused
    local issueSummaryHeight = arg1.state.issueSummaryHeight
    local issueFullListHeight = arg1.state.issueFullListHeight
    local showDetailedError = arg1.props.showDetailedError

    local bool1 = arg3.validatedInputText ~= ""

    local bool2 = not (textBoxFocused and arg1.props.prerequisiteMet)
    local bool3 = arg1.state.validatedInputText ~= ""

    local var2 = computeIsInErrorState(arg1.props, arg1.state)
    local var3 = computeIsInErrorState(arg2, arg3)

    if showDetailedError and var2 then
        bool3 = true
        bool2 = false
    end

    local var4 = if textBoxFocused or showDetailedError and var2 then if arg1.props.prerequisiteMet then issueFullListHeight else issueSummaryHeight elseif var2 then issueSummaryHeight else 0
    local bool4

    if arg1.props.pillClicked then
        arg1.props.resetPillClicked()
        var4 = 0
        issueSummaryHeight = 0
        bool4 = true
    else
        bool4 = false
    end

    if textBoxFocused ~= arg3.textBoxFocused or bool1 ~= bool3 or showDetailedError and var2 or var2 ~= var3 then
        arg1.motor:setGoal({
            issueSummaryTextTransparency = Otter.spring(if bool2 then 0 else 1, arg1.springOptions),
            issueFullListTextTransparency = Otter.spring(if bool2 then 1 else 0, arg1.springOptions),
            issueCheckmarkTransparency = Otter.spring(if bool3 then 0 else 1, arg1.springOptions),
            issueTrackerHeight = Otter.spring(var4, arg1.springOptions)
        })
        if arg1.props.onAnimationStateChangeCallback then
            arg1.props.onAnimationStateChangeCallback(arg1.props.textInputType, true)
        end

        return
    end

    if issueSummaryHeight == arg3.issueSummaryHeight and issueFullListHeight == arg3.issueFullListHeight then
        return
    end
    if bool4 then
        arg1.motor:setGoal({ issueTrackerHeight = Otter.spring(var4, arg1.springOptions) })
    else
        arg1.motor:setGoal({ issueTrackerHeight = Otter.instant(var4) })
    end

    if arg1.props.onAnimationStateChangeCallback then
        arg1.props.onAnimationStateChangeCallback(arg1.props.textInputType, true)
    end
end

function var1.willUnmount(arg1)
    arg1.isMounted = false
    arg1.motor:destroy()

    if arg1.foundationTextBoxProxy ~= nil
        and arg1.props.textBoxRef ~= nil
        and arg1.props.textBoxRef.current == arg1.foundationTextBoxProxy
    then
        arg1.props.textBoxRef.current = nil
        arg1.foundationTextBoxProxy = nil
    end
end

function var1.render(arg1)
    local layoutOrder = arg1.props.layoutOrder
    local titleTextKey = arg1.props.titleTextKey
    local summaryErrorTextKey = arg1.props.summaryErrorTextKey
    local validator = arg1.props.validator
    local validatorAdditionalProps = arg1.props.validatorAdditionalProps
    local inputTextToValidate = arg1.state.inputTextToValidate
    local tokens = arg1.props.tokens

    inputTextToValidate = if arg1.props.prerequisiteMet then inputTextToValidate else ""

    local default = AuthStatefulRoundCornerBorder.BorderState.Default

    if arg1.isInErrorState() then
        default = AuthStatefulRoundCornerBorder.BorderState.Error
    elseif arg1.state.textBoxFocused then
        default = AuthStatefulRoundCornerBorder.BorderState.Focused
    elseif arg1.state.textBoxHover then
        default = AuthStatefulRoundCornerBorder.BorderState.Hover
    end

    local var2 = arg1:isUsingFoundationTextInput()

    if FFlagAuthValidatorRebindTextBoxRef and var2 and arg1.foundationProxyText == nil then
        arg1.foundationProxyText = arg1.state.inputTextToValidate
    end

    local paddingTopOverride = nil
    local useTrailingPadding = nil
    local colorContentOverride = nil
    local useFoundationTitle = nil
    local foundationTitleSize = nil
    local foundationTitleIsRequired = nil
    local var3 = nil
    if FFlagAuthValidatorStyleOverrides then
        paddingTopOverride = arg1.props.paddingTopOverride
        useTrailingPadding = arg1.props.useTrailingPadding
        colorContentOverride = arg1.props.colorContentOverride
        useFoundationTitle = arg1.props.useFoundationTitle
        foundationTitleSize = arg1.props.foundationTitleSize
        foundationTitleIsRequired = arg1.props.foundationTitleIsRequired
        if arg1.props.foundationTitleIsBold ~= true then
            var3 = false
        else
            var3 = true
        end
    end
    return withStyle(function(arg2)
        local var4 = arg2.Font.BaseSize * arg2.Font.CaptionHeader.RelativeSize
        local contentGap = arg1.getContentGap()

        if GetFFlagLuaAppEnable10ftSignUpView() and tokens then
            var4 = tokens.textCaptionHeaderSize
        end

        return withLocalization({ titleText = titleTextKey, summaryErrorText = summaryErrorTextKey })(function(arg3)
            local createElement = Roact.createElement
            local fitFrame = FitChildren.FitFrame
            local tbl1 = {
                LayoutOrder = layoutOrder,
                Size = UDim2.new(1, 0, 0, 0),
                fitAxis = FitChildren.FitAxis.Height,
                BackgroundTransparency = 1,
                [Roact.Ref] = arg1.getFrameRef(),
                [Roact.Change.AbsolutePosition] = arg1.onPositionChanged
            }
            local tbl2 = {
                UIListLayout = Roact.createElement("UIListLayout", {
                    FillDirection = Enum.FillDirection.Vertical,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, contentGap)
                }),
                Padding = Roact.createElement("UIPadding", {
                    PaddingTop = UDim.new(0, paddingTopOverride or 5),
                    PaddingBottom = if useTrailingPadding then arg1.issueTrailingPadding else UDim.new(0, if arg1.props.paddingBottomOverride then arg1.props.paddingBottomOverride else 5)
                }),
                Title = 0,
                TextInputBox = 0,
                RegisterTitleAuditContent = 0,
                AnimatedWrapper = 0
            }
            local element

            if useFoundationTitle then
                element = Roact.createElement(InputLabel, {
                    LayoutOrder = 0,
                    Text = if var3 then formatBoldRichText(arg3.titleText or "") else arg3.titleText or "",
                    RichText = var3,
                    isRequired = foundationTitleIsRequired,
                    size = foundationTitleSize
                })
            else
                element = Roact.createElement(FitTextLabel, {
                    LayoutOrder = 0,
                    Size = UDim2.new(1, 0, 0, 0),
                    fitAxis = FitChildren.FitAxis.Height,
                    BackgroundTransparency = 1,
                    Text = arg3.titleText or "",
                    TextWrapped = true,
                    Font = arg2.Font.CaptionHeader.Font,
                    TextSize = var4,
                    TextColor3 = arg2.Theme.TextEmphasis.Color,
                    TextTransparency = arg2.Theme.TextEmphasis.Transparency,
                    TextXAlignment = Enum.TextXAlignment.Left
                })
            end

            tbl2.Title = element
            local element2

            if var2 then
                element2 = Roact.createElement(arg1.textInputBoxFoundation)
            else
                element2 = Roact.createElement(AuthStatefulRoundCornerBorder, {
                    size = UDim2.new(1, 0, 0, if GetFFlagLuaAppEnable10ftSignUpView() and tokens then tokens.textboxHeight else 36),
                    layoutOrder = 1,
                    borderState = default
                }, {
                    textbox = Roact.createElement(arg1.textInputBoxWithBorder),
                    loadingSpinner = if arg1.props.shouldShowLoadingIcon then Roact.createElement(
                        Loading,
                        {
                            size = IconSize.Small,
                            Position = UDim2.new(1, -22, 0.5, 0),
                            AnchorPoint = Vector2.new(0.5, 0.5)
                        }
                    ) else nil
                })
            end

            tbl2.TextInputBox = element2

            tbl2.RegisterTitleAuditContent = if GetFFlagEnableAuditForSinglePageSignUp() and arg1.props.enableAuditContentCapture and RegisterAuditContent then Roact.createElement(RegisterAuditContent, { translationKey = titleTextKey, translatedSourceString = arg3.titleText }) else nil

            local createElement2 = Roact.createElement
            local str1 = "Frame"
            local tbl3 = {
                LayoutOrder = 2,
                BackgroundTransparency = 1,
                ClipsDescendants = true,
                Size = arg1.issueTrackerHeight
            }
            local tbl4 = {
                Padding = Roact.createElement("UIPadding", {
                    PaddingRight = UDim.new(0, 12),
                    PaddingLeft = if GetFFlagEnableAuthStatefulTextInputUpdates() then UDim.new(0, 0) else UDim.new(0, 12)
                }),
                IssueSummaryWrapper = Roact.createElement(FitChildren.FitFrame, {
                    LayoutOrder = 2,
                    Size = UDim2.new(1, 0, 0, 0),
                    fitAxis = FitChildren.FitAxis.Height,
                    BackgroundTransparency = 1,
                    [Roact.Change.AbsoluteSize] = arg1.onIssueSummarySizeChange
                }, {
                    IssueSummaryText = arg1.isInErrorState()
                        and Roact.createElement(FitTextLabel, {
                            Size = UDim2.new(1, 0, 0, 0),
                            fitAxis = FitChildren.FitAxis.Height,
                            BackgroundTransparency = 1,
                            Text = arg3.summaryErrorText or "",
                            TextWrapped = true,
                            Font = arg2.Font.CaptionBody.Font,
                            TextSize = arg2.Font.BaseSize * arg2.Font.CaptionBody.RelativeSize,
                            TextColor3 = arg2.Theme.Alert.Color,
                            TextTransparency = arg1.issueSummaryTextTransparency,
                            TextXAlignment = Enum.TextXAlignment.Left
                        })
                }),
                IssueTrackerWrapper = 0
            }

            local createElement3 = Roact.createElement
            local fitFrame2 = FitChildren.FitFrame
            local tbl5 = {
                LayoutOrder = 2,
                Size = UDim2.new(1, 0, 0, 0),
                fitAxis = FitChildren.FitAxis.Height,
                BackgroundTransparency = 1,
                [Roact.Change.AbsoluteSize] = arg1.onIssueFullListSizeChange
            }
            local tbl6 = {
                IssueTracker = Roact.createElement(IssueTracker, {
                    validator = validator,
                    validatorAdditionalProps = validatorAdditionalProps,
                    textToValidate = inputTextToValidate,
                    onTextValidated = arg1.onTextValidated,
                    contentTransparency = arg1.issueFullListTextTransparency,
                    checkmarkTransparency = arg1.issueCheckmarkTransparency,
                    updateIssueCondition = arg1.props.updateIssueCondition,
                    debounceTime = if FFlagSignUpTrackFailedRequest then arg1.props.debounceTime else nil,
                    colorContentOverride = colorContentOverride
                })
            }
            tbl4.IssueTrackerWrapper = createElement3(fitFrame2, tbl5, tbl6)
            tbl2.AnimatedWrapper = createElement2(str1, tbl3, tbl4)
            return createElement(fitFrame, tbl1, tbl2)
        end)
    end)
end

return var1
