-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:11:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent

local CentralOverlay = require(AppBloxParent.CentralOverlay)
local Cryo = require(AppBloxParent.Cryo)
local Foundation = require(AppBloxParent.Foundation)
local Localization = require(AppBloxParent.Localization)
local NavigationRodux = require(AppBloxParent.NavigationRodux)
local React = require(AppBloxParent.React)
local RoactUtils = require(AppBloxParent.RoactUtils)
local RobloxAppEnums = require(AppBloxParent.RobloxAppEnums)
local SharedFlags = require(AppBloxParent.SharedFlags)
local UniversalAppPolicy = require(AppBloxParent.UniversalAppPolicy)
local UrlBuilder = require(AppBloxParent.UrlBuilder)

local CloseCentralOverlay = CentralOverlay.Thunks.CloseCentralOverlay
local ButtonVariant = Foundation.Enums.ButtonVariant
local Checkbox = Foundation.Checkbox
local Dialog = Foundation.Dialog
local FoundationText = Foundation.Text
local useTokens = Foundation.Hooks.useTokens
local normalizeFontFace = Foundation.Utility.normalizeFontFace
local useLocalization = Localization.Hooks.useLocalization
local NavigateDown = NavigationRodux.Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = SharedFlags.FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(AppBloxParent.RobloxAppNavigation).NavigationCommands else nil
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local AppPage = RobloxAppEnums.AppPage
local useAppPolicy = UniversalAppPolicy.useAppPolicy
local UrlBuilder2 = UrlBuilder.UrlBuilder

local FFlagLuaAppMakeDisclaimerOptInForFeedbackForm = SharedFlags.FFlagLuaAppMakeDisclaimerOptInForFeedbackForm
local FFlagLuaAppNotInterestedFeedbackFormTelemetry = SharedFlags.FFlagLuaAppNotInterestedFeedbackFormTelemetry

local bool1 = game:DefineFastFlag("LuaAppCheckboxFeedbackFormTitleTextWrapping", false)

return React.memo(function(tbl1) -- name: CheckboxFeedbackFormModal
    local var1 = useDispatch()
    local var2 = useTokens()
    local var3 = useLocalization({
        submitText = "CommonUI.Controls.Action.Submit",
        otherPlaceholderText = "Feature.GameDetails.Label.TellUsMorePlaceholder",
        termsOfUseText = {
            "Feature.GameDetails.Message.AnonymousFeedbackTermsOfUse",
            underlineStart = "<u>",
            underlineEnd = "</u>"
        }
    })

    local var4 = React.useCallback(function(bool2: boolean?)
        var1(CloseCentralOverlay())
        if FFlagLuaAppNotInterestedFeedbackFormTelemetry and tbl1.onClose then
            tbl1.onClose(bool2)
        end
    end, { var1, tbl1.onClose })

    local var5, var6 = React.useState({})

    local var7 = React.useMemo(function()
        return Cryo.List.map(tbl1.checkboxItems, function(tbl2, layoutOrder: number)
            local id = tbl2.id
            return React.createElement(Checkbox, {
                label = tbl2.text,
                isChecked = not not var5[id],
                LayoutOrder = layoutOrder,
                onActivated = function()
                    local var7 = table.clone(var5)
                    if var7[id] then
                        var7[id] = false
                        var6(var7)
                        return
                    end
                    var7[id] = true
                    var6(var7)
                end
            })
        end)
    end, { tbl1.checkboxItems, var5 })

    local var8, var9 = React.useMemo(function(): (boolean, boolean)
        local bool2 = false
        local bool3 = false
        for _, checkboxItem in tbl1.checkboxItems do
            if not var5[checkboxItem.id] then
                continue
            end

            if checkboxItem.triggersOtherTextbox then
                bool3 = true
            else
                bool2 = true
            end
        end

        return bool2, bool3
    end, { tbl1.checkboxItems, var5 })

    local var10 = React.useRef("")
    local var11, var12 = React.useState(false)
    local bool2 = not (var9 and not var11) and (if var8 then true elseif var9 then not not var11 else false)

    local var13 = React.useCallback(function(arg1)
        if not arg1 then
            return
        end
        if arg1.Text:len() > 500 then
            arg1.Text = arg1.Text:sub(1, 500)
        end
        var10.current = arg1.Text
        var12(arg1.Text:len() >= 10)
    end, {})

    local onActivated = React.useCallback(function()
        if not bool2 then
            return
        end
        var4(if FFlagLuaAppNotInterestedFeedbackFormTelemetry then true else nil)
        tbl1.onSubmit(var5, var10.current)
    end, {
        bool2,
        tbl1.onSubmit,
        var5,
        var4
    })
    local var15 = useAppPolicy(function(arg1)
        return arg1.getWebViewSupport()
    end)

    local var16 = React.useCallback(function()
        local tbl2 = {
            name = AppPage.GenericWebPage,
            detail = UrlBuilder2.static.about.terms(),
            extraProps = { title = "" }
        }

        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl2), nil)
        else
            var1(NavigateDown(tbl2, nil))
        end
        var4(not FFlagLuaAppNotInterestedFeedbackFormTelemetry and nil)
    end, { var1, var4 })

    local var17 = if FFlagLuaAppNotInterestedFeedbackFormTelemetry then React.useCallback(function()
        var4(false)
    end, { var4 }) else nil

    local createElement = React.createElement
    local root = Dialog.Root
    local tbl2 = { onClose = 0, hasBackdrop = true }
    if not FFlagLuaAppNotInterestedFeedbackFormTelemetry then
        var17 = var4
    end

    tbl2.onClose = var17

    local tbl3 = {
        DialogTitle = if tbl1.dialogTitle then React.createElement(Dialog.Title, { text = tbl1.dialogTitle }) else nil,
        DialogText = React.createElement(Dialog.Text, { Text = tbl1.dialogText, LayoutOrder = 2 }),
        DialogContent = 0,
        DialogActions = 0,
        DisclaimerText = 0
    }

    local createElement2 = React.createElement
    local content = Dialog.Content
    local tbl4 = { LayoutOrder = 3 }

    local tbl5 = {
        CheckboxListWrapper = React.createElement(
            "Frame",
            {
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                LayoutOrder = 1,
                Size = UDim2.fromScale(1, 0)
            },
            Cryo.Dictionary.union(var7, {
                Title = React.createElement(FoundationText, {
                    AutomaticSize = Enum.AutomaticSize.Y,
                    fontStyle = var2.Typography.TitleLarge,
                    LayoutOrder = 0,
                    Size = UDim2.fromScale(1, 0),
                    Text = tbl1.checkboxListTitle,
                    TextWrapped = if bool1 then true else nil,
                    TextXAlignment = Enum.TextXAlignment.Left
                }),
                UIListLayout = React.createElement("UIListLayout", {
                    FillDirection = Enum.FillDirection.Vertical,
                    HorizontalAlignment = Enum.HorizontalAlignment.Left,
                    Padding = UDim.new(0, var2.Padding.Medium),
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    VerticalAlignment = Enum.VerticalAlignment.Top
                })
            })
        ),
        OtherTextBoxContainer = 0,
        UIListLayout = 0
    }
    local var18

    if var9 then
        local createElement3 = React.createElement
        local tbl6 = {
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundColor3 = var2.Color.Shift.Shift_200.Color3,
            BackgroundTransparency = var2.Color.Shift.Shift_200.Transparency,
            BorderSizePixel = 0,
            LayoutOrder = 2,
            Size = UDim2.fromScale(1, 0)
        }
        local tbl7 = {
            InputBox = React.createElement("TextBox", {
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                ClearTextOnFocus = false,
                FontFace = normalizeFontFace(var2.Typography.CaptionMedium.Font),
                LineHeight = var2.LineHeight.LineHeight_140,
                MultiLine = true,
                PlaceholderColor3 = var2.Color.Content.Muted.Color3,
                PlaceholderText = var3.otherPlaceholderText,
                Size = UDim2.new(1, 0, 0, var2.Size.Size_1000),
                Text = var10.current,
                TextColor3 = var2.Color.Content.Default.Color3,
                TextSize = var2.Typography.CaptionMedium.FontSize,
                TextTransparency = var2.Color.Content.Default.Transparency,
                TextTruncate = Enum.TextTruncate.SplitWord,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
                [React.Change.Text] = var13
            }, {
                UISizeConstraint = React.createElement("UISizeConstraint", { MaxSize = Vector2.new(math.huge, var2.Size.Size_3000) })
            }),
            UIPadding = React.createElement("UIPadding", {
                PaddingBottom = UDim.new(0, var2.Padding.Small),
                PaddingLeft = UDim.new(0, var2.Padding.Small),
                PaddingRight = UDim.new(0, var2.Padding.Small),
                PaddingTop = UDim.new(0, var2.Padding.Small)
            }),
            UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, var2.Radius.Medium) })
        }
        var18 = createElement3("Frame", tbl6, tbl7)
    else
        var18 = nil
    end

    tbl5.OtherTextBoxContainer = var18

    tbl5.UIListLayout = React.createElement("UIListLayout", {
        FillDirection = Enum.FillDirection.Vertical,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        Padding = UDim.new(0, var2.Padding.XLarge),
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Top
    })
    tbl3.DialogContent = createElement2(content, tbl4, tbl5)

    tbl3.DialogActions = React.createElement(Dialog.Actions, {
        actions = {{
            isDisabled = not bool2,
            onActivated = onActivated,
            text = var3.submitText,
            variant = ButtonVariant.Standard
        }},
        LayoutOrder = 4
    })
    local element

    if FFlagLuaAppMakeDisclaimerOptInForFeedbackForm and not tbl1.showTermsOfUseDisclaimer or not var15 then
        element = nil
    else
        element = React.createElement("TextButton", {
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Font = Enum.Font.BuilderSansMedium,
            LayoutOrder = 5,
            LineHeight = var2.LineHeight.LineHeight_140,
            RichText = true,
            Size = UDim2.fromScale(1, 0),
            Text = var3.termsOfUseText,
            TextColor3 = var2.Color.Content.Muted.Color3,
            TextSize = var2.FontSize.FontSize_300,
            TextTransparency = var2.Color.Content.Muted.Transparency,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            [React.Event.Activated] = var16
        })
    end

    tbl3.DisclaimerText = element
    return createElement(root, tbl2, tbl3)
end)
