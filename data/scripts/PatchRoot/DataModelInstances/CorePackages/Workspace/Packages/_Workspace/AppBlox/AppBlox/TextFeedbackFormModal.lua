-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent

local CentralOverlay = require(AppBloxParent.CentralOverlay)
local Foundation = require(AppBloxParent.Foundation)
local normalizeFontFace = Foundation.Utility.normalizeFontFace
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
local Dialog = Foundation.Dialog
local useTokens = Foundation.Hooks.useTokens
local useLocalization = Localization.Hooks.useLocalization
local NavigateDown = NavigationRodux.Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = SharedFlags.FFlagSignalsNavP3Dispatch

local bool1 = game:DefineFastFlag("LuaAppTextFeedbackFormModalStandardInput", false)
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(AppBloxParent.RobloxAppNavigation).NavigationCommands else nil
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local AppPage = RobloxAppEnums.AppPage
local useAppPolicy = UniversalAppPolicy.useAppPolicy
local UrlBuilder2 = UrlBuilder.UrlBuilder

return React.memo(function(tbl1) -- name: TextFeedbackFormModal
    local var1 = useDispatch()
    local var2 = useTokens()
    local var3 = useLocalization({
        submitText = "CommonUI.Controls.Action.Submit",
        defaultPlaceholderText = "Feature.GameDetails.Label.TellUsMorePlaceholder",
        termsOfUseText = {
            "Feature.GameDetails.Message.AnonymousFeedbackTermsOfUse",
            underlineStart = "<u>",
            underlineEnd = "</u>"
        }
    })

    local var4 = React.useRef("")
    local var5, var6 = React.useState(false)

    local var7 = React.useCallback(function(bool2: boolean?)
        var1(CloseCentralOverlay())

        if tbl1.onClose then
            tbl1.onClose(bool2)
        end
    end, { var1, tbl1.onClose })

    local var8 = React.useCallback(function(arg1)
        if not arg1 then
            return
        end

        if arg1.Text:len() > 500 then
            arg1.Text = arg1.Text:sub(1, 500)
        end

        var4.current = arg1.Text
        var6(arg1.Text:len() >= 10)
    end, {})

    local onActivated = React.useCallback(function()
        if not var5 then
            return
        end

        var7(true)
        tbl1.onSubmit(var4.current)
    end, { var5, tbl1.onSubmit, var7 })

    local var10 = useAppPolicy(function(arg1)
        return arg1.getWebViewSupport()
    end)

    local var11 = React.useCallback(function()
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

        var7(false)
    end, { var1, var7 })

    local onClose = React.useCallback(function()
        var7(false)
    end, { var7 })

    local createElement = React.createElement
    local root = Dialog.Root
    local tbl2 = { onClose = onClose, hasBackdrop = true }

    local tbl3 = {
        DialogTitle = React.createElement(Dialog.Title, { text = tbl1.dialogTitle }),
        DialogText = if tbl1.dialogText then React.createElement(Dialog.Text, { Text = tbl1.dialogText, LayoutOrder = 2 }) else nil,
        DialogContent = 0,
        DialogActions = 0,
        DisclaimerText = 0
    }

    local createElement2 = React.createElement
    local content = Dialog.Content
    local tbl4 = { LayoutOrder = 3 }

    local tbl5 = { TextBoxContainer = 0 }
    local createElement3 = React.createElement
    local str1 = "Frame"
    local tbl6 = {
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = if bool1 then nil else var2.Color.Shift.Shift_200.Color3,
        BackgroundTransparency = if bool1 then 1 else var2.Color.Shift.Shift_200.Transparency,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 0)
    }
    local tbl7 = {
        InputBox = React.createElement("TextBox", {
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            ClearTextOnFocus = false,
            FontFace = normalizeFontFace(if bool1 then var2.Typography.BodyMedium.Font else var2.Typography.CaptionMedium.Font),
            LineHeight = if bool1 then var2.Typography.BodyMedium.LineHeight else var2.LineHeight.LineHeight_140,
            MultiLine = true,
            PlaceholderColor3 = var2.Color.Content.Muted.Color3,
            PlaceholderText = tbl1.placeholderText or var3.defaultPlaceholderText,
            Size = UDim2.new(1, 0, 0, var2.Size.Size_1000),
            Text = var4.current,
            TextColor3 = if bool1 then var2.Color.Content.Emphasis.Color3 else var2.Color.Content.Default.Color3,
            TextSize = if bool1 then var2.Typography.BodyMedium.FontSize else var2.Typography.CaptionMedium.FontSize,
            TextTransparency = if bool1 then var2.Color.Content.Emphasis.Transparency else var2.Color.Content.Default.Transparency,
            TextTruncate = Enum.TextTruncate.SplitWord,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            [React.Change.Text] = var8
        }, {
            UISizeConstraint = React.createElement("UISizeConstraint", { MaxSize = Vector2.new(math.huge, var2.Size.Size_3000) })
        }),
        UIPadding = React.createElement("UIPadding", {
            PaddingBottom = UDim.new(0, var2.Padding.Small),
            PaddingLeft = UDim.new(0, var2.Padding.Small),
            PaddingRight = UDim.new(0, var2.Padding.Small),
            PaddingTop = UDim.new(0, var2.Padding.Small)
        }),
        UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, var2.Radius.Medium) }),
        UIStroke = if bool1 then React.createElement("UIStroke", {
            Color = var2.Color.Stroke.Emphasis.Color3,
            Transparency = var2.Color.Stroke.Emphasis.Transparency,
            Thickness = var2.Stroke.Standard,
            BorderStrokePosition = Enum.BorderStrokePosition.Inner
        }) else nil
    }
    tbl5.TextBoxContainer = createElement3(str1, tbl6, tbl7)
    tbl3.DialogContent = createElement2(content, tbl4, tbl5)

    tbl3.DialogActions = React.createElement(Dialog.Actions, {
        actions = {{
            isDisabled = not var5,
            onActivated = onActivated,
            text = var3.submitText,
            variant = tbl1.buttonVariant or ButtonVariant.Standard
        }},
        LayoutOrder = 4
    })
    local element

    if tbl1.showTermsOfUseDisclaimer and var10 then
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
            [React.Event.Activated] = var11
        })
    else
        element = nil
    end

    tbl3.DisclaimerText = element
    return createElement(root, tbl2, tbl3)
end)
