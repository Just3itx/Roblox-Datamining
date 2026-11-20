-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:20:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationFlow = script:FindFirstAncestor("MomentsCreationFlow")
local MomentsCreationFlowParent = MomentsCreationFlow.Parent

local Foundation = require(MomentsCreationFlowParent.Foundation)
local MomentsCommon = require(MomentsCreationFlowParent.MomentsCommon)
local React = require(MomentsCreationFlowParent.React)

local Button = Foundation.Button
local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize
local FoundationText = Foundation.Text
local View = Foundation.View

local DescriptionUpdated = require(MomentsCreationFlow.Actions.DescriptionUpdated)

local useCallback = React.useCallback
local useDeviceInsets = MomentsCommon.Hooks.useDeviceInsets
local useDispatch = MomentsCommon.Hooks.useDispatch
local useSelector = MomentsCommon.Hooks.useSelector
local useState = React.useState
local useTokens = Foundation.Hooks.useTokens

local CreationFlowContext = require(MomentsCreationFlow.Context.CreationFlowContext)

local Constants = require(MomentsCreationFlow.Constants)
local CreationFlowLocalization = require(MomentsCreationFlow.Enums.CreationFlowLocalization)
local EventNames = require(MomentsCreationFlow.Analytics.EventNames)

return function(tbl1)
    local var1 = useDispatch()
    local var2 = useDeviceInsets()
    local var3 = useTokens()
    local var4 = React.useContext(CreationFlowContext)

    local var5 = useSelector(function(arg1)
        return arg1[Constants.RoduxKey].CreationFlow.description
    end)

    local var6, var7 = useState(var5)

    local var8 = useCallback(function()
        var1(DescriptionUpdated(var6))
        var4.fireEvent(EventNames.EditingFlowDescriptionEdited)
    end, { var6 })

    local var9 = useCallback(function(arg1)
        local var9 = arg1.Text:gsub("[\r\n]+", " ")
        local var10 = utf8.len(var9)
        if var10 ~= nil and var10 >= 140 then
            local str1 = string.sub(var9, 1, utf8.offset(var9, 141) - 1)
            var7(str1)
            arg1.Text = str1
            return
        end
        var7(var9)
        arg1.Text = var9
    end, {})

    local createElement = React.createElement
    local var10 = View
    local tbl2 = {
        LayoutOrder = tbl1.layoutOrder,
        tag = "align-x-center auto-y size-full-0"
    }
    local tbl3 = {
        Padding = React.createElement("UIPadding", {
            PaddingTop = UDim.new(0, var3.Padding.Large),
            PaddingBottom = UDim.new(0, math.max(var2.bottom, var3.Padding.Large)),
            PaddingLeft = UDim.new(0, math.max(var2.left, var3.Padding.XLarge)),
            PaddingRight = UDim.new(0, math.max(var2.right, var3.Padding.XLarge))
        }),
        SizeConstraint = 0
    }

    local createElement2 = React.createElement
    local var11 = View
    local tbl4 = {
        sizeConstraint = {
            MaxSize = Constants.BottomBarSizeConstraint
        },
        tag = "align-x-center auto-y col gap-large size-full-0"
    }

    local tbl5 = { TextBoxContainer = 0, CTAs = 0, Disclaimer = 0 }
    local createElement3 = React.createElement
    local var12 = View

    local tbl6 = {
        TextBox = React.createElement("TextBox", {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            ClearTextOnFocus = false,
            ClipsDescendants = true,
            Font = Enum.Font.BuilderSans,
            MaxVisibleGraphemes = 140,
            MultiLine = false,
            PlaceholderColor3 = var3.Color.Content.Muted.Color3,
            PlaceholderText = var4.getLocalization(CreationFlowLocalization.PublishingDescription),
            ShowNativeInput = true,
            Text = var6,
            TextColor3 = var3.Color.ActionStandard.Foreground.Color3,
            TextSize = var3.FontSize.FontSize_400,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            [React.Change.Text] = var9,
            [React.Event.FocusLost] = var8
        })
    }
    tbl5.TextBoxContainer = createElement3(var12, { tag = "size-full-2100 bg-surface-100 padding-medium radius-medium" }, tbl6)

    tbl5.CTAs = React.createElement(View, {
        LayoutOrder = 2,
        tag = "align-x-center auto-y align-y-bottom anchor-bottom-center gap-small position-bottom-center row size-full-0"
    }, {
        PostButton = React.createElement(Button, {
            fillBehavior = Foundation.Enums.FillBehavior.Fill,
            LayoutOrder = 1,
            onActivated = tbl1.onPublish,
            size = InputSize.Medium,
            text = var4.getLocalization(CreationFlowLocalization.PublishingCtaPrimary),
            variant = ButtonVariant.Emphasis,
            width = UDim.new(0.5, 0)
        }),
        ReturnToEditingButton = React.createElement(Button, {
            fillBehavior = Foundation.Enums.FillBehavior.Fill,
            LayoutOrder = 2,
            text = var4.getLocalization(CreationFlowLocalization.PublishingCtaSecondary),
            variant = ButtonVariant.Standard,
            width = UDim.new(0.5, 0),
            onActivated = tbl1.onReturnToEditing,
            size = InputSize.Medium
        })
    })

    tbl5.Disclaimer = React.createElement(FoundationText, {
        LayoutOrder = 3,
        tag = "auto-xy text-body-small content-neutral text-align-x-center text-align-y-top",
        Text = var4.getLocalization(CreationFlowLocalization.CreationTooltip)
    })
    tbl3.SizeConstraint = createElement2(var11, tbl4, tbl5)
    return createElement(var10, tbl2, tbl3)
end
