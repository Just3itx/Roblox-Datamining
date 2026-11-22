-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:50:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local Cryo = require(MomentsCreationParent.Cryo)
local Foundation = require(MomentsCreationParent.Foundation)
local MomentsCommon = require(MomentsCreationParent.MomentsCommon)
local React = require(MomentsCreationParent.React)
local SignalsReact = require(MomentsCreationParent.SignalsReact)
local SharedFlags = require(MomentsCreationParent.SharedFlags)
local FFlagMomentsComments = require(MomentsCreationParent.SharedFlags).FFlagMomentsComments

local Button = Foundation.Button
local ButtonVariant = Foundation.Enums.ButtonVariant
local InputPlacement = Foundation.Enums.InputPlacement
local InputSize = Foundation.Enums.InputSize
local FoundationText = Foundation.Text
local Toggle = Foundation.Toggle
local View = Foundation.View

local useCallback = React.useCallback
local useDeviceInsets = MomentsCommon.Hooks.useDeviceInsets
local useSignalState = SignalsReact.useSignalState
local useTokens = Foundation.Hooks.useTokens

local GetCreationFlowStore = require(MomentsCreation.Stores.GetCreationFlowStore)
local fireAnalyticsEvent = require(MomentsCreation.Analytics.fireAnalyticsEvent)
local makeCreationEventFields = require(MomentsCreation.Analytics.makeCreationEventFields)
local GeneratedTextFeedbackContainer = require(MomentsCreation.Components.GeneratedTextFeedback.GeneratedTextFeedbackContainer)

local Constants = require(MomentsCreation.Constants)
local useCreationFlowStrings = require(MomentsCreation.Hooks.useCreationFlowStrings)
local EventNames = MomentsCommon.Analytics.EventNames
local SessionManager = MomentsCommon.Analytics.SessionManager
local FunnelEventNames = MomentsCommon.Analytics.FunnelEventNames
local FFlagMomentTextGenerationFilteredSignal = MomentsCommon.Flags.FFlagMomentTextGenerationFilteredSignal
local GetFFlagMomentsUseUploadPostAsync = MomentsCommon.Flags.GetFFlagMomentsUseUploadPostAsync
local FFlagMomentsRenderCreatePostStatus = SharedFlags.FFlagMomentsRenderCreatePostStatus
local FFlagMomentsCommentsCreatorControl = require(MomentsCreation.Flags.FFlagMomentsCommentsCreatorControl)

local function AllowCommentsToggle(tbl1)
    local var1 = useCreationFlowStrings()
    local creationFlowStore = GetCreationFlowStore(false)
    local isChecked = useSignalState(creationFlowStore.getCommentsEnabled)

    local onActivated = useCallback(function(bool1: boolean)
        creationFlowStore.updateCommentsEnabled(bool1)
        if FFlagMomentsComments then
            local sessionId = SessionManager.getSessionId(FunnelEventNames.FunnelTypes.CreationFlow)
            fireAnalyticsEvent(
                EventNames.MomentCommentsSettingToggled,
                Cryo.Dictionary.join(makeCreationEventFields.makeCreationBaseFields(sessionId), { commentsEnabled = tostring(bool1) })
            )
        end
    end, { creationFlowStore.updateCommentsEnabled })

    return React.createElement(Toggle, {
        isChecked = isChecked,
        label = var1.PublishingAllowComments,
        LayoutOrder = tbl1.layoutOrder,
        onActivated = onActivated,
        placement = InputPlacement.End,
        size = InputSize.Medium,
        testId = "moments-allow-comments-toggle"
    })
end

return function(tbl1)
    local var1 = useDeviceInsets()
    local var2 = useTokens()
    local var3 = useCreationFlowStrings()
    local creationFlowStore = GetCreationFlowStore(false)
    local ref = React.useRef(nil)

    local publishingCtaSecondary = var3.PublishingCtaSecondary

    local currentText = useSignalState(creationFlowStore.getDescription)

    React.useEffect(function()
        local current = ref.current
        if current ~= nil then
            current.Text = currentText
        end
    end, { currentText })

    local fFlagMomentsUseUploadPostAsync = FFlagMomentsCommentsCreatorControl and GetFFlagMomentsUseUploadPostAsync()

    local var6 = useCallback(function()
        local current = ref.current
        creationFlowStore.updateDescription(if current == nil then "" else current.Text)

        local sessionId = SessionManager.getSessionId(FunnelEventNames.FunnelTypes.CreationFlow)
        fireAnalyticsEvent(
            EventNames.EditingFlowDescriptionEdited,
            Cryo.Dictionary.join(
                makeCreationEventFields.makeToolFieldFromKind("description"),
                makeCreationEventFields.makeCreationBaseFields(sessionId)
            )
        )
    end, { creationFlowStore.updateDescription })

    local var7 = useCallback(function(arg1)
        local var7 = arg1.Text:gsub("[\r\n]+", " ")
        local var8 = utf8.len(var7)
        if var8 ~= nil and var8 >= 140 then
            var7 = string.sub(var7, 1, utf8.offset(var7, 141) - 1)
        end
        if var7 ~= arg1.Text then
            arg1.Text = var7
        end
    end, {})

    local createElement = React.createElement
    local var8 = View
    local tbl2 = {
        LayoutOrder = tbl1.layoutOrder,
        tag = "align-x-center size-full-0 auto-y",
        padding = {
            top = UDim.new(0, var2.Padding.Large),
            bottom = UDim.new(0, math.max(var1.bottom, var2.Padding.Large)),
            left = UDim.new(0, math.max(var1.left, var2.Padding.XLarge)),
            right = UDim.new(0, math.max(var1.right, var2.Padding.XLarge))
        }
    }
    local tbl3 = { SizeConstraint = 0 }
    local createElement2 = React.createElement
    local var9 = View
    local tbl4 = {
        sizeConstraint = {
            MaxSize = Constants.BottomBarSizeConstraint
        },
        tag = "col align-x-center gap-large size-full-0 auto-y"
    }

    local tbl5 = {
        TextBoxContainer = 0,
        AllowComments = 0,
        GeneratedTextFeedback = 0,
        CTAs = 0,
        Disclaimer = 0
    }
    local createElement3 = React.createElement
    local var10 = View

    local tbl6 = {
        TextBox = React.createElement("TextBox", {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            ClearTextOnFocus = false,
            ClipsDescendants = true,
            Font = Enum.Font.BuilderSans,
            MaxVisibleGraphemes = 140,
            MultiLine = false,
            PlaceholderColor3 = var2.Color.Content.Muted.Color3,
            PlaceholderText = var3.PublishingDescription,
            ref = ref,
            ShowNativeInput = true,
            TextColor3 = var2.Color.ActionStandard.Foreground.Color3,
            TextSize = var2.FontSize.FontSize_400,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            [React.Change.Text] = var7,
            [React.Event.FocusLost] = var6
        })
    }
    tbl5.TextBoxContainer = createElement3(var10, { tag = "size-full-2100 padding-medium radius-medium bg-surface-100" }, tbl6)

    tbl5.AllowComments = if fFlagMomentsUseUploadPostAsync then React.createElement(AllowCommentsToggle, { layoutOrder = 1 }) else nil

    tbl5.GeneratedTextFeedback = if FFlagMomentTextGenerationFilteredSignal then React.createElement(GeneratedTextFeedbackContainer, { layoutOrder = if fFlagMomentsUseUploadPostAsync then 2 else 1 }) else nil

    local createElement4 = React.createElement
    local var11 = View
    local tbl7 = {
        LayoutOrder = if fFlagMomentsUseUploadPostAsync then 3 else 2,
        tag = "row align-x-center align-y-bottom gap-small position-bottom-center anchor-bottom-center size-full-0 auto-y"
    }
    local tbl8 = {
        PostButton = React.createElement(Button, {
            fillBehavior = Foundation.Enums.FillBehavior.Fill,
            isDisabled = if FFlagMomentsRenderCreatePostStatus then tbl1.isPublishing else nil,
            isLoading = if FFlagMomentsRenderCreatePostStatus then tbl1.isPublishing else nil,
            LayoutOrder = 1,
            onActivated = tbl1.onPublish,
            size = InputSize.Medium,
            text = var3.PublishingCtaPrimary,
            testId = "moments-publish-button",
            variant = ButtonVariant.Emphasis,
            width = UDim.new(0.5, 0)
        }),
        ReturnToEditingButton = React.createElement(Button, {
            fillBehavior = Foundation.Enums.FillBehavior.Fill,
            LayoutOrder = 2,
            text = publishingCtaSecondary,
            variant = ButtonVariant.Standard,
            width = UDim.new(0.5, 0),
            onActivated = tbl1.onReturnToEditing,
            size = InputSize.Medium
        })
    }
    tbl5.CTAs = createElement4(var11, tbl7, tbl8)

    tbl5.Disclaimer = React.createElement(FoundationText, {
        LayoutOrder = if fFlagMomentsUseUploadPostAsync then 4 else 3,
        tag = "auto-xy text-body-small text-align-x-center text-align-y-top content-neutral",
        Text = var3.CreationTooltip
    })
    tbl3.SizeConstraint = createElement2(var9, tbl4, tbl5)
    return createElement(var8, tbl2, tbl3)
end
