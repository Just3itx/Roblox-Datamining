-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:20:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthSignup = script:FindFirstAncestor("AuthSignup")
local AuthSignupParent = AuthSignup.Parent

local React = require(AuthSignupParent.React)
local useDispatch = require(AuthSignupParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useRoactService = require(AuthSignupParent.RobloxAppHooks).useRoactService

local RoactNetworking = require(AuthSignupParent.RoactServiceTags).RoactNetworking

local UIBlox = require(AuthSignupParent.UIBlox)
local useDesignTokens = require(AuthSignupParent.Style).useDesignTokens
local useStyle = UIBlox.Core.Style.useStyle
local StyledTextLabel = UIBlox.App.Text.StyledTextLabel

local Foundation = require(AuthSignupParent.Foundation)
local TextInput = Foundation.TextInput
local FoundationText = Foundation.Text
local useTokens = Foundation.Hooks.useTokens

local useLocalization = require(AuthSignupParent.Localization).Hooks.useLocalization

local AuthCommon = require(AuthSignupParent.AuthCommon)
local InputValidity = AuthCommon.Enums.InputValidity
local IssueCondition = AuthCommon.Enums.IssueCondition
local UIConstants = AuthCommon.Common.UIConstants

local debounce = require(AuthSignup.Util.debounce)

local SharedFlags = require(AuthSignupParent.SharedFlags)

local GetFFlagEnableMultiPageSignupV2Updates = SharedFlags.GetFFlagEnableMultiPageSignupV2Updates
local GetFFlagEnableLuafiedRecoveryFlow = SharedFlags.GetFFlagEnableLuafiedRecoveryFlow

local function AuthTextInputValidator(tbl1)
    local var1 = useDesignTokens()
    local var2 = useTokens()
    local var3 = useDispatch()
    local var4 = useRoactService(RoactNetworking)
    local var5 = useStyle()

    local var6, var7 = React.useState("")
    local var8, var9 = React.useState("")
    local var10, var11 = React.useState(tbl1.validator.getDefaultIssues())

    local var12, var13 = React.useState(true)
    local var14, var15 = React.useState(InputValidity.Unvalidated)
    local errorText, var17 = React.useState(nil)
    local var18, var19 = React.useState(false)

    local var20 = React.useCallback(debounce(function(str1: string)
        var9(str1)
    end, tbl1.debounceTime or 0.5), { var9 })

    React.useEffect(function()
        if var8 ~= var6 then
            var20(var6)
        end
    end, { var6 })

    local tbl2 = { var8 }
    if GetFFlagEnableLuafiedRecoveryFlow() then
        local validationDependencies = tbl1.validationDependencies
        if validationDependencies then
            for i = 1, #validationDependencies do
                tbl2[#tbl2 + 1] = validationDependencies[i]
            end
        end
    end

    React.useEffect(function()
        if #var8 == 0 then
            var15(InputValidity.Unvalidated)
            var11(tbl1.validator.getDefaultIssues())
            return
        end

        var3(tbl1.validator.validateFunction(var4, var8, var10, tbl1.validatorAdditionalProps)):andThen(function(arg1)
            local var21 = if arg1.InputValid then InputValidity.Valid else InputValidity.Invalid

            if var6 == arg1.Input and tbl1.onTextChanged then
                tbl1.onTextChanged(arg1.Input, var21)
            end

            var11(arg1.IssueCondition)
            var15(var21)
            var7(arg1.Input)
        end)
    end, tbl2)

    React.useEffect(function()
        if var14 ~= InputValidity.Invalid then
            var17(nil)
            return
        end

        local var21 = nil
        if tbl1.validatorIssuePriorityList then
            for _, value in ipairs(tbl1.validatorIssuePriorityList) do
                if var10[value] == IssueCondition.Problematic then
                    var21 = value
                    break
                end
            end
        else
            for k, value in pairs(var10) do
                if value == IssueCondition.Problematic then
                    var21 = k
                    break
                end
            end
        end

        if var21 == nil then
            var17(nil)
            return
        end

        if tbl1.onErrorShown then
            tbl1.onErrorShown(var21)
        end
        if tbl1.validatorIssueMessageList then
            var17(tbl1.validatorIssueMessageList[var21])
            return
        end
        var17(tbl1.validator.getIssueMessageList()[var21])
    end, { var14 })

    React.useEffect(function()
        if not GetFFlagEnableMultiPageSignupV2Updates() or not var18 then
            return
        end

        local textBoxRef = tbl1.textBoxRef
        if textBoxRef.current and textBoxRef.current.focus then
            textBoxRef.current.focus()
        end
        var19(false)
    end, { var18 })

    local function onChanged(str1: string)
        tbl1.onTextChanged(str1, InputValidity.Unvalidated)
        var15(InputValidity.Unvalidated)
        var7(str1)
    end

    local function getTextInputType() -- Luacid: Inlined by compiler; 1 call site recovered
        if tbl1.textInputType == Enum.TextInputType.Password then
            if var12 then
                return Enum.TextInputType.Password
            end

            return Enum.TextInputType.PasswordShown
        end

        return tbl1.textInputType
    end

    local function getShowPasswordIconButton()
        if tbl1.textInputType ~= Enum.TextInputType.Password then
            return nil, nil
        end

        if var12 then
            return UIConstants.HIDE_PASSWORD_ICON, function()
                var13(false)
                if GetFFlagEnableMultiPageSignupV2Updates() then
                    var19(true)
                end
            end
        end
        return UIConstants.SHOW_PASSWORD_ICON, function()
            var13(true)
            if GetFFlagEnableMultiPageSignupV2Updates() then
                var19(true)
            end
        end
    end
    local var21 = useLocalization({ errorText = errorText })

    local name, onActivated = getShowPasswordIconButton()
    local element

    if var14 == InputValidity.Invalid and GetFFlagEnableLuafiedRecoveryFlow() and tbl1.useFoundationTextForIssue then
        element = React.createElement("Frame", {
            Size = UDim2.new(1, 0, 0, var2.Size.Size_200),
            BackgroundTransparency = 1
        }, {
            IssuePadding = React.createElement("UIPadding", { PaddingTop = UDim.new(0, tbl1.foundationIssueTextPadding or 0) }),
            IssueText = React.createElement(FoundationText, {
                Text = var21.errorText or "",
                fontStyle = var2.Typography.CaptionSmall,
                textStyle = var2.Color.System.Alert,
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center
            })
        })
    elseif var14 == InputValidity.Invalid then
        element = React.createElement(StyledTextLabel, {
            text = var21.errorText or "",
            fontStyle = var5.Font.BodySmall,
            colorStyle = var5.Theme.Alert,
            automaticSize = Enum.AutomaticSize.XY,
            textWrapped = true
        })
    else
        element = nil
    end

    local size100 = var1.Size.Size_100
    if GetFFlagEnableLuafiedRecoveryFlow() then
        size100 = tbl1.customPadding or var1.Size.Size_100
    end

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl3 = {
        LayoutOrder = tbl1.layoutOrder,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1
    }
    local tbl4 = {
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, size100),
            HorizontalFlex = Enum.UIFlexAlignment.Fill
        }),
        TextInputBox = React.createElement(TextInput, {
            LayoutOrder = 1,
            textInputType = getTextInputType(),
            width = UDim.new(1, 0),
            text = tbl1.initialText or "",
            placeholder = tbl1.placeholder,
            onChanged = onChanged,
            iconTrailing = if GetFFlagEnableLuafiedRecoveryFlow() and tbl1.hideIconButton then nil else name and {
                name = name,
                onActivated = onActivated
            } or nil,
            label = "",
            hasError = var14 == InputValidity.Invalid and #var6 > 0,
            textBoxRef = tbl1.textBoxRef,
            size = tbl1.size
        }),
        IssueWrapper = React.createElement("Frame", {
            LayoutOrder = 3,
            Size = UDim2.new(1, 0, 0, GetFFlagEnableLuafiedRecoveryFlow() and tbl1.issueHeight or var1.Size.Size_400),
            BackgroundTransparency = 1
        }, { Issue = element })
    }
    return createElement(str1, tbl3, tbl4)
end

return AuthTextInputValidator
