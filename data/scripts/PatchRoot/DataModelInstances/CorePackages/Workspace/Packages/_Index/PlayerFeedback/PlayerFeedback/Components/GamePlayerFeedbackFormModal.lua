-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T10:00:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PlayerFeedback = script:FindFirstAncestor("PlayerFeedback")
local PlayerFeedbackParent = PlayerFeedback.Parent
local React = require(PlayerFeedbackParent.React)
local UIBlox = require(PlayerFeedbackParent.UIBlox)
local Foundation = require(PlayerFeedbackParent.Foundation)
local Checkbox = Foundation.Checkbox
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local useStyle = UIBlox.Core.Style.useStyle
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local PartialPageModal = UIBlox.App.Dialog.Modal.PartialPageModal
local VerticalScrollView = UIBlox.App.Container.VerticalScrollView

local ButtonStack = UIBlox.App.Button.ButtonStack
local Cryo = require(PlayerFeedbackParent.Cryo)
local ArgCheck = require(PlayerFeedbackParent.ArgCheck)
local t = require(PlayerFeedbackParent.t)
local CloseCentralOverlay = require(PlayerFeedbackParent.CentralOverlay).Thunks.CloseCentralOverlay
local useSelector = require(PlayerFeedbackParent.RoactUtils).Hooks.RoactRodux.useSelector
local useDispatch = require(PlayerFeedbackParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useLocalization = require(PlayerFeedbackParent.Localization).Hooks.useLocalization
local useRoactService = require(PlayerFeedbackParent.RobloxAppHooks).useRoactService
local RoactServiceTags = require(PlayerFeedbackParent.RoactServiceTags)
local AppEventIngestService = RoactServiceTags.AppEventIngestService
local RoactNetworking = RoactServiceTags.RoactNetworking
local ToastRodux = require(PlayerFeedbackParent.ToastRodux)
local SetNetworkingErrorToast = require(PlayerFeedbackParent.RobloxAppToastsRodux).Thunks.SetNetworkingErrorToast
local SetCurrentToastMessage = ToastRodux.Actions.SetCurrentToastMessage
local NavigateDown = require(PlayerFeedbackParent.NavigationRodux).Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = require(PlayerFeedbackParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(PlayerFeedbackParent.RobloxAppNavigation).NavigationCommands else nil
local AppPage = require(PlayerFeedbackParent.RobloxAppEnums).AppPage
local UrlBuilder = require(PlayerFeedbackParent.UrlBuilder).UrlBuilder
local GetFFlagEdpPlayerFeedbackCommentsOnly = require(PlayerFeedbackParent.SharedFlags).GetFFlagEdpPlayerFeedbackCommentsOnly
local UserInputService = game:GetService("UserInputService")
local SubmitGamePlayerFeedback = require(PlayerFeedback.Thunks.SubmitGamePlayerFeedback)
local _Types = require(PlayerFeedback.Types)
local PlayerFeedbackEvents = require(PlayerFeedback.Analytics.Events.PlayerFeedbackEvents)

local AbuseVector = require(PlayerFeedbackParent.GenericAbuseReporting.AbuseVector)
local OpenDynamicAbuseReport = require(PlayerFeedbackParent.GenericAbuseReporting.OpenDynamicAbuseReport)

local FFlagEnableAbuseReportRevampFlow = require(PlayerFeedbackParent.SharedFlags).FFlagEnableAbuseReportRevampFlow
local bool1 = game:DefineFastFlag("EnableAbuseReportRevampFeedback", false)
local FFlagAddThumbnailSelectorReport = require(PlayerFeedbackParent.SharedFlags).FFlagAddThumbnailSelectorReport
local bool2 = game:DefineFastFlag("AddThumbnailReportToPlayerFeedback", false)

local useState = React.useState
local useEffect = React.useEffect

local function CategoryCheckboxes(tbl1)
    local category = tbl1.category
    local selectedCategoryIds = tbl1.selectedCategoryIds
    local onOptionSelected = tbl1.onOptionSelected

    local tbl2 = {
        layout = React.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }),
        padding = React.createElement("UIPadding", { PaddingLeft = UDim.new(0, -8) })
    }

    local var1 = React.useCallback(function(arg1)
        return function(arg2)
            local var1 = if arg2 then Cryo.List.join(selectedCategoryIds, { arg1 }) else Cryo.List.filter(selectedCategoryIds, function(arg3): boolean
                return arg3 ~= arg1
            end)

            onOptionSelected(var1)
        end
    end, { selectedCategoryIds })

    for layoutOrder, option in ipairs(category.options) do
        local var2 = "Checkbox" .. layoutOrder
        tbl2[var2] = React.createElement(Checkbox, {
            label = option.label,
            isChecked = Cryo.List.find(selectedCategoryIds, option.id) ~= nil,
            onActivated = var1(option.id),
            LayoutOrder = layoutOrder
        })
    end
    return React.createElement("Frame", {
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = tbl1.layoutOrder,
        Size = UDim2.new(1, 0, 0, 0)
    }, tbl2)
end

local function getTextLength(str1: string) -- Luacid: Inlined by compiler; 6 call sites recovered
    if utf8.len(str1) then
        return (utf8.len(utf8.nfcnormalize(str1)))
    end

    return string.len(str1)
end

local var1 = ArgCheck.wrap(
    t.interface({
        closeCentralOverlayThunk = t.callback,
        universeId = t.string,
        playerFeedbackMetadata = t.strictInterface({
            rootPlaceId = t.string,
            canSubmitReview = t.boolean,
            canSubmitComment = t.boolean,
            categoryType = t.string,
            category = t.interface({
                type = t.string,
                label = t.string,
                allows_multiple_selections = t.boolean,
                options = t.array(t.interface({ id = t.string, label = t.string }))
            }),
            comment = t.interface({ label = t.string, placeholder_text = t.string, minimum_length = t.number, maximum_length = t.number }),
            metadata = t.interface({ disclaimer_label = t.string, submit_button_label = t.string, form_title_label = t.string })
        }),
        onSubmitted = t.optional(t.callback)
    })
)
local function GamePlayerFeedbackFormModal(tbl1)
    assert(var1(tbl1))

    local var2 = useStyle()
    local var3 = useDispatch()
    local var4 = useRoactService(RoactNetworking)
    local var5 = useRoactService(AppEventIngestService)
    local tokens = var2.Tokens

    local screenSize = useSelector(function(arg1)
        return arg1.ScreenSize
    end)
    local var7 = useSelector(function(arg1)
        local globalGuiInset = arg1.GlobalGuiInset
        return globalGuiInset and globalGuiInset.bottom or 0
    end)
    local var8, var9 = useState(false)
    local var10, var11 = useState(0)
    local yOffset = var8 and -var10 + var7 or 0

    local var12, var13 = useState(0)
    local var14 = React.useRef(nil)
    local ref = React.useRef(nil)
    local var16 = screenSize.Y - var10 - 48 - 48 - 48 - (if var8 then 0 else 48)

    local playerFeedbackMetadata = tbl1.playerFeedbackMetadata
    local categoryType = playerFeedbackMetadata.categoryType
    local category = playerFeedbackMetadata.category
    local metadata = playerFeedbackMetadata.metadata
    local comment = playerFeedbackMetadata.comment
    local rootPlaceId = playerFeedbackMetadata.rootPlaceId

    local var17, var18 = useState("")
    local var19 = GetFFlagEdpPlayerFeedbackCommentsOnly() and { "Other" } or {}
    local selectedCategoryIds, var21 = useState(var19)
    local var22 = playerFeedbackMetadata.canSubmitComment and #selectedCategoryIds > 0
    local var23, var24 = useState(nil)

    local var25 = useLocalization({
        commentTooLongMessage = {
            "PlayerFeedbacks.VoteForm.Message.MaxLengthCharacters",
            count = comment.maximum_length
        },
        commentTooShortMessage = {
            "PlayerFeedbacks.VoteForm.Message.MinLengthCharacters",
            count = comment.minimum_length
        },
        abuseReportPromptText = "PlayerFeedbacks.VoteForm.Message.ReportAbuseInsteadLong",
        reportFlowPageTitle = "PlayerFeedbacks.VoteForm.Message.Action.Report"
    })
    local bool3 = #selectedCategoryIds > 0 and var23 == nil

    if GetFFlagEdpPlayerFeedbackCommentsOnly() then
        if #selectedCategoryIds > 0 and getTextLength(var17) > 0 then
            bool3 = var23 == nil
        else
            bool3 = false
        end

        local var26, var27 = useState(false)
        useEffect(function()
            task.defer(function()
                if not var26 and ref.current then
                    var27(true)
                    ref.current:CaptureFocus()
                end
            end)
        end, { ref, var26 })
    end

    local var26 = React.useCallback(function()
        var3(tbl1.closeCentralOverlayThunk())
    end, { tbl1.closeCentralOverlayThunk })

    local onCloseClicked = React.useCallback(function()
        PlayerFeedbackEvents.DismissPlayerFeedbackFormModal(var5, rootPlaceId, { categoryType = categoryType })
        var26()
    end, {
        var26,
        categoryType,
        rootPlaceId,
        var5
    })
    local onOptionSelected = React.useCallback(function(arg1)
        PlayerFeedbackEvents.TogglePlayerFeedbackFormModalReason(var5, rootPlaceId, { categoryType = categoryType })

        var21(arg1)
    end, {})

    local onActivated = React.useCallback(function()
        PlayerFeedbackEvents.ClickPlayerFeedbackFormModalSubmit(var5, rootPlaceId, { categoryType = categoryType })

        if #selectedCategoryIds == 0 then
            return
        end

        if GetFFlagEdpPlayerFeedbackCommentsOnly() and getTextLength(var17) == 0
            or getTextLength(var17) > 0 and getTextLength(var17) < comment.minimum_length
        then
            PlayerFeedbackEvents.SubmitPlayerFeedbackFailCommentValidation(
                var5,
                rootPlaceId,
                { categoryType = categoryType, value = "CommentTooShort" }
            )

            var24(var25.commentTooShortMessage)
            return
        end

        if getTextLength(var17) > comment.maximum_length then
            PlayerFeedbackEvents.SubmitPlayerFeedbackFailCommentValidation(
                var5,
                rootPlaceId,
                { categoryType = categoryType, value = "CommentTooLong" }
            )

            var24(var25.commentTooLongMessage)
            return
        end

        var3(SubmitGamePlayerFeedback.Post(var4, rootPlaceId, categoryType, selectedCategoryIds, var17)):andThen(function(_)
            var3(SetCurrentToastMessage({ toastMessage = "PlayerFeedbacks.VoteForm.Message.SubmitSuccess" }))

            if tbl1.onSubmitted then
                tbl1.onSubmitted()
            end
            var26()
        end, function(arg1)
            var3(SetNetworkingErrorToast(arg1))
        end)
    end, {
        var4,
        var5,
        comment.maximum_length,
        comment.minimum_length,
        var25.commentTooShortMessage,
        var25.commentTooLongMessage,
        rootPlaceId,
        categoryType,
        selectedCategoryIds,
        var17,
        tbl1.onSubmitted,
        var26
    })

    useEffect(function()
        PlayerFeedbackEvents.PlayerFeedbackFormModalMounted(var5, rootPlaceId, { categoryType = categoryType })
    end, { var5, rootPlaceId, categoryType })

    local var30 = React.useCallback(function()
        PlayerFeedbackEvents.FocusPlayerFeedbackFormModalComment(var5, rootPlaceId, { categoryType = categoryType })
    end, { var5, rootPlaceId, categoryType })

    local var31 = React.useCallback(function()
        PlayerFeedbackEvents.ClickPlayerFeedbackFormAbuseReportPrompt(var5, rootPlaceId, { categoryType = categoryType })

        var3(
            OpenDynamicAbuseReport({
                abuseVector = AbuseVector.Place,
                targetId = rootPlaceId,
                custom = FFlagAddThumbnailSelectorReport and bool2 and {
                    universeId = tbl1.universeId
                } or nil,
                onClose = function()
                    var3(CloseCentralOverlay())
                end
            })
        )
    end, {
        var5,
        rootPlaceId,
        categoryType,
        rootPlaceId
    })
    local var32 = React.useCallback(function()
        PlayerFeedbackEvents.ClickPlayerFeedbackFormAbuseReportPrompt(var5, rootPlaceId, { categoryType = categoryType })

        local tbl2 = {
            name = AppPage.GenericWebPage,
            detail = UrlBuilder.game.report({ placeId = rootPlaceId }),
            extraProps = {
                title = var25.reportFlowPageTitle
            }
        }
        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl2))
        else
            var3(NavigateDown(tbl2))
        end
        var26()
    end, {
        var5,
        rootPlaceId,
        categoryType,
        var26
    })

    local var33 = React.useCallback(function()
        PlayerFeedbackEvents.ClickPlayerFeedbackFormModalDisclaimer(var5, rootPlaceId, { categoryType = categoryType })

        local tbl2 = {
            name = AppPage.GenericWebPage,
            detail = UrlBuilder.static.about.terms()
        }
        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl2))
        else
            var3(NavigateDown(tbl2))
        end
        var26()
    end, {
        var5,
        rootPlaceId,
        categoryType,
        var26
    })
    local var34 = React.useCallback(function(arg1)
        local text = arg1.Text
        var18(text)
        local textLength = getTextLength(text)
        local bool4 = textLength == 0 or comment.minimum_length <= textLength and textLength <= comment.maximum_length

        if var23 and bool4 then
            var24(nil)
        end
    end, { var23, comment.minimum_length, comment.maximum_length })

    useEffect(function()
        if not var14 or not var14.current or var10 == 0 then
            return
        end

        var14.current.CanvasPosition = Vector2.new(0, var14.current.AbsoluteCanvasSize.Y)
    end, { var14, var10 })

    useEffect(function()
        local connection = UserInputService:GetPropertyChangedSignal("OnScreenKeyboardVisible"):Connect(function()
            var9(UserInputService.OnScreenKeyboardVisible)
            var11(UserInputService.OnScreenKeyboardVisible and UserInputService.OnScreenKeyboardSize.Y or 0)
        end)

        return function()
            if connection then
                connection:Disconnect()
            end
            connection = nil
        end
    end, {})

    local createElement = React.createElement
    local var35 = PartialPageModal
    local tbl2 = {
        title = metadata.form_title_label,
        screenSize = screenSize,
        onCloseClicked = onCloseClicked,
        position = if var8 then UDim2.new(0.5, 0, 1, yOffset) or nil else nil,
        anchorPoint = if var8 then Vector2.new(0.5, 1) or nil else nil,
        marginSize = 0
    }
    local tbl3 = { Content = 0 }
    local createElement2 = React.createElement
    local var36 = VerticalScrollView
    local tbl4 = {
        size = UDim2.new(1, 0, 0, math.min(var12 + 25, var16)),
        useAutomaticCanvasSize = true,
        canvasSizeY = UDim.new(),
        elasticBehavior = Enum.ElasticBehavior.Never,
        scrollingFrameRef = var14,
        ref = var14
    }
    local tbl5 = {
        UIListLayout = 0,
        ContentPadding = 0,
        CheckboxesLabel = 0,
        CategoryCheckboxes = 0,
        CommmentLabel = 0,
        Commment = 0,
        HelperText = 0,
        Buttons = 0,
        DisclaimerText = 0,
        AbuseReportPromptText = 0
    }
    local createElement3 = React.createElement
    local tbl6 = {
        FillDirection = Enum.FillDirection.Vertical,
        SortOrder = Enum.SortOrder.LayoutOrder,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        Padding = UDim.new(0, 16)
    }

    tbl6[React.Change.AbsoluteContentSize] = function(arg1)
        var13(arg1.AbsoluteContentSize.Y)
    end

    tbl5.UIListLayout = createElement3("UIListLayout", tbl6)

    tbl5.ContentPadding = React.createElement(
        "UIPadding",
        {
            PaddingTop = UDim.new(0, 24),
            PaddingLeft = UDim.new(0, 24),
            PaddingRight = UDim.new(0, 24)
        }
    )
    tbl5.CheckboxesLabel = React.createElement("TextLabel", {
        BackgroundTransparency = 1,
        Text = category.label,
        TextSize = var2.Font.BaseSize,
        TextColor3 = tokens.Color.Content.Emphasis.Color3,
        TextTransparency = tokens.Color.Content.Emphasis.Transparency,
        FontFace = normalizeFontFace(tokens.Typography.TitleLarge.Font),
        TextXAlignment = Enum.TextXAlignment.Left,
        AutomaticSize = Enum.AutomaticSize.Y,
        TextWrapped = true,
        Size = UDim2.new(1, 0, 0, 0),
        LayoutOrder = 0
    })

    tbl5.CategoryCheckboxes = if GetFFlagEdpPlayerFeedbackCommentsOnly() then nil else React.createElement(
        CategoryCheckboxes,
        {
            category = category,
            selectedCategoryIds = selectedCategoryIds,
            onOptionSelected = onOptionSelected,
            layoutOrder = 1
        }
    )
    local element

    if GetFFlagEdpPlayerFeedbackCommentsOnly() then
        element = nil
    else
        element = var22
            and React.createElement("TextLabel", {
                BackgroundTransparency = 1,
                Text = comment.label,
                TextSize = var2.Font.BaseSize,
                TextColor3 = tokens.Color.Content.Emphasis.Color3,
                TextTransparency = tokens.Color.Content.Emphasis.Transparency,
                FontFace = normalizeFontFace(tokens.Typography.TitleLarge.Font),
                TextXAlignment = Enum.TextXAlignment.Left,
                AutomaticSize = Enum.AutomaticSize.Y,
                TextWrapped = true,
                Size = UDim2.new(1, 0, 0, 0),
                LayoutOrder = 2
            })
    end

    tbl5.CommmentLabel = element
    local var37

    if var22 then
        local createElement4 = React.createElement
        local tbl7 = {
            BorderSizePixel = 1,
            BackgroundColor3 = tokens.Color.Surface.Surface_200.Color3,
            BackgroundTransparency = tokens.Color.Surface.Surface_200.Transparency,
            AutomaticSize = Enum.AutomaticSize.Y,
            LayoutOrder = 3,
            Size = UDim2.new(1, 0, 0, 0)
        }
        local tbl8 = {
            UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, tokens.Radius.Small) }),
            UIPadding = React.createElement("UIPadding", {
                PaddingTop = UDim.new(0, 8),
                PaddingBottom = UDim.new(0, 8),
                PaddingLeft = UDim.new(0, 8),
                PaddingRight = UDim.new(0, 8)
            }),
            TextBox = React.createElement("TextBox", {
                Text = var17,
                PlaceholderText = comment.placeholder_text,
                PlaceholderColor3 = var2.Theme.TextMuted.Color,
                Size = UDim2.new(1, 0, 0, 100),
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
                ClearTextOnFocus = false,
                MultiLine = true,
                TextWrapped = true,
                ClipsDescendants = true,
                OverlayNativeInput = true,
                TextColor3 = tokens.Color.Content.Emphasis.Color3,
                TextTransparency = tokens.Color.Content.Emphasis.Transparency,
                BackgroundColor3 = tokens.Color.Surface.Surface_200.Color3,
                BackgroundTransparency = tokens.Color.Surface.Surface_200.Transparency,
                FontFace = normalizeFontFace(tokens.Typography.BodyLarge.Font),
                TextSize = tokens.Typography.BodyLarge.FontSize,
                AutomaticSize = Enum.AutomaticSize.Y,
                BorderSizePixel = 0,
                ref = ref,
                [React.Change.Text] = var34,
                [React.Event.Focused] = var30
            })
        }
        var37 = createElement4("Frame", tbl7, tbl8)
    else
        var37 = var22
    end

    tbl5.Commment = var37
    local element2

    if var22 and var23 ~= nil then
        element2 = React.createElement("TextLabel", {
            Text = var23,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            TextWrapped = true,
            BackgroundTransparency = 1,
            TextColor3 = var2.Theme.Alert.Color,
            FontFace = normalizeFontFace(tokens.Typography.CaptionSmall.Font),
            TextSize = tokens.Typography.CaptionLarge.FontSize,
            LineHeight = tokens.Typography.CaptionSmall.LineHeight,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            LayoutOrder = 4
        })
    else
        element2 = nil
    end

    tbl5.HelperText = element2

    tbl5.Buttons = React.createElement(
        "Frame",
        {
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.Y,
            LayoutOrder = 5,
            Size = UDim2.new(1, 0, 0, 0)
        },
        {
            ButtonStack = React.createElement(ButtonStack, {
                buttons = {{
                    buttonType = ButtonType.PrimaryContextual,
                    props = {
                        onActivated = onActivated,
                        isDisabled = bool3 == false,
                        text = metadata.submit_button_label
                    }
                }}
            })
        }
    )

    tbl5.DisclaimerText = React.createElement("TextButton", {
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(1, 0, 0, 0),
        FontFace = normalizeFontFace(tokens.Typography.CaptionLarge.Font),
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        Text = metadata.disclaimer_label,
        [React.Event.Activated] = var33,
        RichText = true,
        TextSize = tokens.Typography.CaptionLarge.FontSize,
        TextColor3 = var2.Theme.TextMuted.Color,
        TextTransparency = var2.Theme.TextMuted.Transparency,
        LineHeight = tokens.LineHeight.LineHeight_140,
        LayoutOrder = 6
    })
    local var38

    if categoryType == "Downvote" then
        local createElement4 = React.createElement
        local str1 = "TextButton"
        local tbl7 = {
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.XY,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true,
            Text = var25.abuseReportPromptText
        }
        local activated = React.Event.Activated

        if FFlagEnableAbuseReportRevampFlow and bool1 then
            var32 = var31
        end

        tbl7[activated] = var32

        tbl7.RichText = true
        tbl7.TextSize = tokens.Typography.CaptionLarge.FontSize
        tbl7.TextColor3 = var2.Theme.TextMuted.Color
        tbl7.TextTransparency = var2.Theme.TextMuted.Transparency
        tbl7.FontFace = normalizeFontFace(tokens.Typography.BodyLarge.Font)
        tbl7.LineHeight = tokens.LineHeight.LineHeight_140
        tbl7.LayoutOrder = 7
        var38 = createElement4(str1, tbl7)
    else
        var38 = false
    end

    tbl5.AbuseReportPromptText = var38
    tbl3.Content = createElement2(var36, tbl4, tbl5)
    return createElement(var35, tbl2, tbl3)
end

return GamePlayerFeedbackFormModal
