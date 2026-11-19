-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:21:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local ExperienceStateCaptureService = game:GetService("ExperienceStateCaptureService")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local t = require(CorePackages.Packages.t)
local UIBlox = require(CorePackages.Packages.UIBlox)
local VerticalScrollView = UIBlox.App.Container.VerticalScrollView
local Signals = require(CorePackages.Packages.Signals)
local Display = require(CorePackages.Workspace.Packages.Display)
local ReactUtils = require(CorePackages.Packages.ReactUtils)

local scriptParentParent = script.Parent.Parent

local Constants = require(scriptParentParent.Resources.Constants)

local SendFeedbackThunk = require(scriptParentParent.Thunks.SendFeedbackThunk)
local GetSourceLanguageThunk = require(scriptParentParent.Thunks.GetSourceLanguageThunk)

local SetFeedbackFlowState = require(scriptParentParent.Actions.SetFeedbackFlowState)
local SetFeedbackReason = require(scriptParentParent.Actions.SetFeedbackReason)

local TextEntryField = require(scriptParentParent.Components.TextEntryField)
local ModalDialog = require(scriptParentParent.Components.ModalDialog)
local ThemedTextLabel = require(scriptParentParent.Components.PortedComponents.ThemedTextLabel)
local buildImageFeedbackFields = require(scriptParentParent.Components.buildImageFeedbackFields)

local withLocalization = require(CorePackages.Workspace.Packages.Localization).withLocalization

local RadioButtonList = UIBlox.App.InputButton.RadioButtonList
local ButtonStack = UIBlox.App.Button.ButtonStack
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local withStyle = UIBlox.Core.Style.withStyle

local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local GetFFlagEnableSendImageFeedbackToBackend = require(RobloxGui.Modules.Flags.GetFFlagEnableSendImageFeedbackToBackend)

local GetFFlagEnableFeedbackShowSourceTextAndOtherUXImprovements = require(RobloxGui.Modules.Flags.GetFFlagEnableFeedbackShowSourceTextAndOtherUXImprovements)
local bool1 = game:DefineFastFlag("EnableFeedbackSelectionUpdate", false)
local FFlagTopBarSignalizeScreenSize = require(CorePackages.Workspace.Packages.CoreGuiCommon).Flags.FFlagTopBarSignalizeScreenSize

local function getContentAssetUri(content) -- Luacid: Inlined by compiler; 2 call sites recovered
    return if content == nil or content.SourceType ~= Enum.ContentSourceType.Uri then "" else content.Uri
end

local var1 = Roact.PureComponent:extend("FeedbackReportDialog")

var1.validateProps = t.strictInterface({
    isReportDialogOpen = t.boolean,
    screenSize = if FFlagTopBarSignalizeScreenSize then nil else t.Vector2,
    closeDialog = t.optional(t.callback),
    reportCategory = t.optional(t.string)
})

function var1.init(arg1)
    if bool1 then
        arg1.state = {
            feedbackText = "",
            feedbackOriginalText = "",
            feedbackIdentifier = "",
            correctTranslationText = "",
            additionalCommentsText = "",
            numFeedbackSubmissionAttempts = 0,
            isGenericSelection = false,
            shouldDisplayFeedbackImage = false,
            feedbackImageUri = "",
            feedbackTranslatedImageUri = ""
        }
    else
        arg1.state = {
            feedbackText = "",
            feedbackOriginalText = "",
            feedbackIdentifier = "",
            correctTranslationText = "",
            additionalCommentsText = "",
            numFeedbackSubmissionAttempts = 0,
            shouldDisplayFeedbackImage = false,
            feedbackImageUri = "",
            feedbackTranslatedImageUri = ""
        }
    end

    function arg1.calculateFieldHeight(num1: number, num2: number, num3: number): number
        if num1 < 180 and num3 then
            return num2 * 5
        end

        return num2 * (num1 / 45 + 2)
    end

    function arg1.resetLocalState()
        if bool1 then
            arg1:setState({ isGenericSelection = false })
        end

        arg1:setState({
            shouldDisplayFeedbackImage = false,
            feedbackImageUri = "",
            feedbackTranslatedImageUri = "",
            correctTranslationText = "",
            additionalCommentsText = "",
            feedbackText = "",
            feedbackOriginalText = "",
            feedbackIdentifier = ""
        })

        arg1.props.setFeedbackReason(0)
        ExperienceStateCaptureService:ResetHighlight()
    end

    function arg1.setInstanceRelatedReportDialogState(arg2)
        if arg2:IsA("TextBox") then
            arg1:setState({
                feedbackText = if arg2.PlaceholderText == "" then arg2.Text else arg2.PlaceholderText,
                feedbackOriginalText = arg2.LocalizationMatchedSourceText,
                feedbackIdentifier = arg2.LocalizationMatchIdentifier
            })

            if bool1 then
                arg1:setState({ isGenericSelection = false })
            end

            return
        end

        if arg2:IsA("TextLabel") or arg2:IsA("TextButton") then
            arg1:setState({
                feedbackText = arg2.Text,
                feedbackOriginalText = arg2.LocalizationMatchedSourceText,
                feedbackIdentifier = arg2.LocalizationMatchIdentifier
            })

            if bool1 then
                arg1:setState({ isGenericSelection = false })
            end

            return
        end

        if arg2:IsA("ImageLabel") or arg2:IsA("ImageButton") then
            arg1:setState({
                shouldDisplayFeedbackImage = true,
                feedbackImageUri = arg2.Image,
                feedbackTranslatedImageUri = if GetFFlagEnableSendImageFeedbackToBackend() then getContentAssetUri(arg2.LocalizedImageContent) else ""
            })
            return
        end

        if arg2:IsA("Decal") then
            arg1:setState({
                shouldDisplayFeedbackImage = true,
                feedbackImageUri = arg2.Texture,
                feedbackTranslatedImageUri = if GetFFlagEnableSendImageFeedbackToBackend() then getContentAssetUri(arg2.LocalizedTextureContent) else ""
            })
            return
        end

        if not arg2:IsA("MeshPart") then
            if bool1 then
                arg1:setState({
                    feedbackText = arg2.ClassName,
                    feedbackOriginalText = arg2.ClassName,
                    feedbackIdentifier = "",
                    isGenericSelection = true
                })
            end

            return
        end

        if arg2.TextureContent.SourceType == Enum.ContentSourceType.Uri then
            arg1:setState({ shouldDisplayFeedbackImage = true, feedbackImageUri = arg2.TextureID })
            return
        end
        if arg2.MeshContent.SourceType == Enum.ContentSourceType.Uri then
            arg1:setState({ shouldDisplayFeedbackImage = true, feedbackImageUri = arg2.MeshId })
            return
        end

        local surfaceAppearance = arg2:FindFirstChildOfClass("SurfaceAppearance")
        if surfaceAppearance and surfaceAppearance.ColorMap then
            arg1:setState({ shouldDisplayFeedbackImage = true, feedbackImageUri = surfaceAppearance.ColorMap })
        end
    end

    ExperienceStateCaptureService.ItemSelectedInCaptureMode:Connect(function(instance: Instance)
        arg1.resetLocalState()
        arg1.setInstanceRelatedReportDialogState(instance)
        arg1.props.setFeedbackFlowState(Constants.State.CurrentlyLeavingFeedback)
    end)

    function arg1.onCorrectTranslationTextChanged(correctTranslationText)
        arg1:setState({ correctTranslationText = correctTranslationText })
    end

    function arg1.onAdditionalCommentsTextChanged(additionalCommentsText)
        arg1:setState({ additionalCommentsText = additionalCommentsText })
    end

    function arg1.onSubmitFeedback()
        arg1:setState({ numFeedbackSubmissionAttempts = arg1.state.numFeedbackSubmissionAttempts + 1 })

        local contentTypeText = Constants.ContentType.Text
        local feedbackOriginalText = arg1.state.feedbackOriginalText
        local feedbackText = arg1.state.feedbackText
        local feedbackIdentifier = arg1.state.feedbackIdentifier

        if GetFFlagEnableSendImageFeedbackToBackend() and arg1.state.shouldDisplayFeedbackImage then
            local imageFeedbackFields = buildImageFeedbackFields(game.GameId, arg1.state.feedbackImageUri, arg1.state.feedbackTranslatedImageUri)

            if not imageFeedbackFields then
                arg1.props.setFeedbackFlowState(Constants.State.Default)
                arg1.resetLocalState()
                return
            end

            feedbackOriginalText = imageFeedbackFields.source
            contentTypeText = Constants.ContentType.Image
            feedbackIdentifier = imageFeedbackFields.identifier
            feedbackText = imageFeedbackFields.translation
        end

        arg1.props.sendFeedback(
            contentTypeText,
            feedbackOriginalText,
            feedbackText,
            feedbackIdentifier,
            arg1.state.correctTranslationText,
            arg1.state.additionalCommentsText,
            arg1.props.feedbackReason,
            arg1.state.numFeedbackSubmissionAttempts
        )

        arg1.props.setFeedbackFlowState(Constants.State.Default)
        arg1.resetLocalState()
    end

    function arg1.onCancel()
        arg1.props.setFeedbackFlowState(Constants.State.Default)
        arg1.resetLocalState()
    end

    if not FFlagTopBarSignalizeScreenSize then
        return
    end

    local getViewportSize = Display.GetDisplayStore(false).getViewportSize

    arg1.disposeScreenSize = Signals.createEffect(function(arg2)
        arg1:setState({ screenSize = getViewportSize(arg2) })
    end)
end

function var1.renderContents(arg1, arg2)
    return withStyle(function(arg3)
        local theme = arg3.Theme
        local font = arg3.Font

        local bool2 = not (arg1.state.shouldDisplayFeedbackImage or arg1.state.isGenericSelection)

        if bool2 then
            if arg1.state.feedbackOriginalText == nil then
                bool2 = false
            else
                bool2 = arg1.state.feedbackOriginalText ~= ""
            end
        end

        local radioButtons = {
            arg2.untranslated,
            arg2.accuracyIssue,
            arg2.spellingOrGrammarIssue,
            arg2.inappropriateOrDerogatory
        }

        if GetFFlagEnableSendImageFeedbackToBackend() and arg1.state.shouldDisplayFeedbackImage then
            table.insert(radioButtons, arg2.imageQuality)
        end

        local tbl2

        if GetFFlagEnableFeedbackShowSourceTextAndOtherUXImprovements() then
            local nextOrder = ReactUtils.createNextOrder()
            tbl2 = {
                SelectedTextHeader = nextOrder(),
                SelectedTextLabel = nextOrder(),
                OriginalTextHeader = nextOrder(),
                OriginalTextLabel = nextOrder(),
                CorrectTranslationHeader = nextOrder(),
                CorrectTranslationTextEntryField = nextOrder(),
                TranslationProblemsHeader = nextOrder(),
                TranslationProblemsListFrame = nextOrder(),
                AdditionalCommentsHeader = nextOrder(),
                AdditionalCommentsTextEntryField = nextOrder()
            }
        else
            tbl2 = {
                SelectedTextHeader = 1,
                SelectedTextLabel = 2,
                TranslationProblemsHeader = 3,
                TranslationProblemsListFrame = 4,
                CorrectTranslationHeader = 5,
                CorrectTranslationTextEntryField = 6,
                AdditionalCommentsHeader = 7,
                AdditionalCommentsTextEntryField = 8
            }
        end

        local createFragment = Roact.createFragment
        local tbl3 = {
            Layout = Roact.createElement("UIListLayout", {
                HorizontalAlignment = Enum.HorizontalAlignment.Right,
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Top
            }),
            SelectedTextHeader = Roact.createElement(StyledTextLabel, {
                text = if arg1.state.shouldDisplayFeedbackImage then arg2.imageSelectionHeader else arg2.textSelectionHeader,
                size = UDim2.new(1, 0, 0, 72),
                textTruncate = Enum.TextTruncate.AtEnd,
                textXAlignment = Enum.TextXAlignment.Left,
                textYAlignment = Enum.TextYAlignment.Center,
                fontStyle = font.Header2,
                colorStyle = theme.TextEmphasis,
                richText = true,
                layoutOrder = tbl2.SelectedTextHeader,
                fluidSizing = true,
                automaticSize = Enum.AutomaticSize.X
            }),
            SelectedTextLabel = 0,
            OriginalTextHeader = 0,
            OriginalTextLabel = 0,
            CorrectTranslationHeader = 0,
            CorrectTranslationTextEntryField = 0,
            TranslationProblemsHeader = 0,
            TranslationProblemsListFrame = 0,
            AdditionalCommentsHeader = 0,
            AdditionalCommentsTextEntryField = 0
        }
        local element

        if arg1.state.shouldDisplayFeedbackImage then
            element = Roact.createElement("ImageLabel", {
                LayoutOrder = tbl2.SelectedTextLabel,
                Size = UDim2.new(1, 0, 0, 72),
                Image = if arg1.state.feedbackTranslatedImageUri ~= nil and arg1.state.feedbackTranslatedImageUri ~= "" then arg1.state.feedbackTranslatedImageUri else arg1.state.feedbackImageUri,
                ScaleType = Enum.ScaleType.Fit,
                BackgroundTransparency = 1,
                BorderSizePixel = 0
            })
        else
            local createElement = Roact.createElement
            local var2 = ThemedTextLabel
            local tbl4 = {
                LayoutOrder = tbl2.SelectedTextLabel,
                fontKey = "Body",
                themeKey = "TextDefault",
                Size = UDim2.new(1, 0, 0, arg1.calculateFieldHeight(string.len(arg1.state.feedbackText), 14, false)),
                Text = if bool1 then (if arg1.state.isGenericSelection then arg2.genericSelectionWrapper else arg1.state.feedbackText) or "" else arg1.state.feedbackText or "",
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Left
            }
            element = createElement(var2, tbl4)
        end

        tbl3.SelectedTextLabel = element
        local element2

        if GetFFlagEnableFeedbackShowSourceTextAndOtherUXImprovements() and bool2 then
            element2 = Roact.createElement(StyledTextLabel, {
                text = arg2.originalTextHeader,
                size = UDim2.new(1, 0, 0, 72),
                textTruncate = Enum.TextTruncate.AtEnd,
                textXAlignment = Enum.TextXAlignment.Left,
                textYAlignment = Enum.TextYAlignment.Center,
                fontStyle = font.Header2,
                colorStyle = theme.TextEmphasis,
                richText = true,
                layoutOrder = tbl2.OriginalTextHeader,
                fluidSizing = true,
                automaticSize = Enum.AutomaticSize.X
            })
        else
            element2 = nil
        end

        tbl3.OriginalTextHeader = element2
        local element3

        if GetFFlagEnableFeedbackShowSourceTextAndOtherUXImprovements() and bool2 then
            element3 = Roact.createElement(ThemedTextLabel, {
                LayoutOrder = tbl2.OriginalTextLabel,
                fontKey = "Body",
                themeKey = "TextDefault",
                Size = UDim2.new(1, 0, 0, arg1.calculateFieldHeight(string.len(arg1.state.feedbackOriginalText), 14, false)),
                Text = arg1.state.feedbackOriginalText or "",
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Left
            })
        else
            element3 = nil
        end

        tbl3.OriginalTextLabel = element3

        tbl3.CorrectTranslationHeader = Roact.createElement(StyledTextLabel, {
            text = arg2.correctTranslationHeader,
            size = UDim2.new(1, 0, 0, 72),
            textTruncate = Enum.TextTruncate.AtEnd,
            textXAlignment = Enum.TextXAlignment.Left,
            textYAlignment = Enum.TextYAlignment.Center,
            fontStyle = font.Header2,
            colorStyle = theme.TextEmphasis,
            richText = true,
            layoutOrder = tbl2.CorrectTranslationHeader,
            fluidSizing = true,
            automaticSize = Enum.AutomaticSize.X
        })
        tbl3.CorrectTranslationTextEntryField = Roact.createElement(TextEntryField, {
            LayoutOrder = tbl2.CorrectTranslationTextEntryField,
            enabled = true,
            text = arg1.state.correctTranslationText,
            textChanged = arg1.onCorrectTranslationTextChanged,
            maxTextLength = math.max(string.len(arg1.state.correctTranslationText), 180),
            autoFocusOnEnabled = false,
            PlaceholderText = arg2.correctTranslationPlaceholder,
            Size = UDim2.new(1, 0, 0, arg1.calculateFieldHeight(string.len(arg1.state.correctTranslationText), 14, true))
        })

        tbl3.TranslationProblemsHeader = Roact.createElement(StyledTextLabel, {
            text = arg2.problemDropdownSelectionHeader,
            size = UDim2.new(1, 0, 0, 72),
            textTruncate = Enum.TextTruncate.AtEnd,
            textXAlignment = Enum.TextXAlignment.Left,
            textYAlignment = Enum.TextYAlignment.Center,
            fontStyle = font.Header2,
            colorStyle = theme.TextEmphasis,
            richText = true,
            layoutOrder = tbl2.TranslationProblemsHeader,
            fluidSizing = true,
            automaticSize = Enum.AutomaticSize.X
        })
        tbl3.TranslationProblemsListFrame = Roact.createElement("Frame", {
            Size = UDim2.new(1, 0, 0, #radioButtons * 40),
            BackgroundTransparency = 1,
            LayoutOrder = tbl2.TranslationProblemsListFrame
        }, {
            RadioButtonList = Roact.createElement(RadioButtonList, {
                radioButtons = radioButtons,
                onActivated = function(arg4)
                    arg1.props.setFeedbackReason(arg4)
                end,
                currentValue = arg1.props.feedbackReason,
                elementSize = UDim2.new(1, 0, 0, 40)
            })
        })
        tbl3.AdditionalCommentsHeader = Roact.createElement(StyledTextLabel, {
            text = arg2.additionalCommentsHeader,
            size = UDim2.new(1, 0, 0, 72),
            textTruncate = Enum.TextTruncate.AtEnd,
            textXAlignment = Enum.TextXAlignment.Left,
            textYAlignment = Enum.TextYAlignment.Center,
            fontStyle = font.Header2,
            colorStyle = theme.TextEmphasis,
            richText = true,
            layoutOrder = tbl2.AdditionalCommentsHeader,
            fluidSizing = true,
            automaticSize = Enum.AutomaticSize.X
        })
        tbl3.AdditionalCommentsTextEntryField = Roact.createElement(TextEntryField, {
            LayoutOrder = tbl2.AdditionalCommentsTextEntryField,
            enabled = true,
            text = arg1.state.additionalCommentsText,
            textChanged = arg1.onAdditionalCommentsTextChanged,
            maxTextLength = 180,
            autoFocusOnEnabled = false,
            PlaceholderText = arg2.additionalCommentsPlaceholder,
            Size = UDim2.new(1, 0, 0, 90)
        })
        return createFragment(tbl3)
    end)
end

function var1.render(arg1)
    local tbl1 = {
        mainHeader = "CoreScripts.Feedback.FeedbackReportDialog.MainHeader",
        cancel = "CoreScripts.Feedback.FeedbackReportDialog.Cancel",
        submitFeedback = "CoreScripts.Feedback.FeedbackReportDialog.SubmitFeedback",
        untranslated = "CoreScripts.Feedback.FeedbackReportDialog.ProblemOption.Untranslated",
        accuracyIssue = "CoreScripts.Feedback.FeedbackReportDialog.ProblemOption.AccuracyIssue",
        spellingOrGrammarIssue = "CoreScripts.Feedback.FeedbackReportDialog.ProblemOption.SpellingOrGrammarIssue",
        inappropriateOrDerogatory = "CoreScripts.Feedback.FeedbackReportDialog.ProblemOption.InappropriateOrDerogatory",
        imageQuality = "CoreScripts.Feedback.FeedbackReportDialog.ProblemOption.ImageQuality",
        textSelectionHeader = "CoreScripts.Feedback.FeedbackReportDialog.TextSelectionHeader",
        correctTranslationHeader = "CoreScripts.Feedback.FeedbackReportDialog.CorrectTranslationHeader",
        correctTranslationPlaceholder = "CoreScripts.Feedback.FeedbackReportDialog.CorrectTranslationPlaceholder",
        additionalCommentsHeader = "CoreScripts.Feedback.FeedbackReportDialog.AdditionalCommentsHeader",
        additionalCommentsPlaceholder = "CoreScripts.Feedback.FeedbackReportDialog.AdditionalCommentsPlaceholder",
        problemDropdownSelectionHeader = "CoreScripts.Feedback.FeedbackReportDialog.ProblemDropdownSelectionHeader",
        genericSelectionWrapper = {
            "CoreScripts.Feedback.FeedbackReportDialog.CorrectTranslationObjectPlaceholder",
            ObjectType = arg1.state.feedbackText
        },
        imageSelectionHeader = "CoreScripts.Feedback.FeedbackReportDialog.ImageSelectionHeader"
    }

    if GetFFlagEnableFeedbackShowSourceTextAndOtherUXImprovements() then
        tbl1.originalTextHeader = {
            "CoreScripts.Feedback.FeedbackReportDialog.OriginalTextHeader",
            SourceLanguage = arg1.props.sourceLanguageName
        }
    end

    return withLocalization(tbl1)(function(arg2)
        local createElement = Roact.createElement
        local var2 = ModalDialog
        local tbl2 = {
            visible = arg1.props.feedbackFlowState == Constants.State.CurrentlyLeavingFeedback,
            screenSize = if FFlagTopBarSignalizeScreenSize then arg1.state.screenSize else arg1.props.screenSize,
            titleText = arg2.mainHeader,
            showCloseButton = true,
            contents = 0,
            actionButtons = 0,
            onDismiss = 0,
            onBackButtonActivated = 0
        }
        local createElement2 = Roact.createElement
        local var3 = VerticalScrollView
        local tbl3 = { useAutomaticCanvasSize = false, canvasSizeY = 0 }
        local var4

        if GetFFlagEnableFeedbackShowSourceTextAndOtherUXImprovements() then
            var4 = UDim.new(
                0,
                600
                    + arg1.calculateFieldHeight(string.len(arg1.state.feedbackText), 14, false) * 2
                    + 72
                    + arg1.calculateFieldHeight(string.len(arg1.state.feedbackOriginalText), 14, false)
                    + (if GetFFlagEnableSendImageFeedbackToBackend() and arg1.state.shouldDisplayFeedbackImage then 40 else 0)
            )
        else
            var4 = UDim.new(
                0,
                600 + arg1.calculateFieldHeight(string.len(arg1.state.feedbackText), 14, false) * 2 + (if GetFFlagEnableSendImageFeedbackToBackend() and arg1.state.shouldDisplayFeedbackImage then 40 else 0)
            )
        end

        tbl3.canvasSizeY = var4
        tbl2.contents = createElement2(
            var3,
            tbl3,
            Roact.createElement("Frame", {
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 1)
            }, {
                Padding = Roact.createElement("UIPadding", { PaddingLeft = UDim.new(0, 24), PaddingRight = UDim.new(0, 24) }),
                Contents = arg1:renderContents(arg2)
            })
        )
        local createElement3 = Roact.createElement
        local var5 = ButtonStack
        local tbl4 = {
            buttonHeight = 36,
            buttons = {
                {
                    buttonType = ButtonType.Secondary,
                    props = {
                        onActivated = arg1.onCancel,
                        text = arg2.cancel
                    }
                },
                {
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        isDisabled = if GetFFlagEnableFeedbackShowSourceTextAndOtherUXImprovements() then arg1.state.correctTranslationText:match("%S") == nil else false,
                        onActivated = arg1.onSubmitFeedback,
                        text = arg2.submitFeedback
                    }
                }
            }
        }
        tbl2.actionButtons = createElement3(var5, tbl4)

        tbl2.onDismiss = arg1.onCancel
        tbl2.onBackButtonActivated = if arg1.props.canNavigateBack then arg1.navigateBack else nil
        return createElement(var2, tbl2)
    end)
end

function var1.didMount(arg1)
    if GetFFlagEnableFeedbackShowSourceTextAndOtherUXImprovements() and arg1.props.sourceLanguageName == "" then
        arg1.props.getSourceLanguageName()
    end
end

function var1.willUnmount(arg1)
    if FFlagTopBarSignalizeScreenSize then
        arg1.disposeScreenSize()
    end
end

return RoactRodux.connect(function(arg1)
    return {
        screenSize = if FFlagTopBarSignalizeScreenSize then nil else arg1.displayOptions.screenSize,
        feedbackFlowState = arg1.feedbackFlowState.feedbackFlowState,
        feedbackReason = arg1.feedbackFlowState.feedbackReason,
        sourceLanguageName = if GetFFlagEnableFeedbackShowSourceTextAndOtherUXImprovements() then arg1.common.sourceLanguageName else nil
    }
end, function(callback)
    return {
        sendFeedback = function(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
            callback(SendFeedbackThunk(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8))
        end,
        setFeedbackFlowState = function(arg1)
            callback(function(arg2)
                arg2:dispatch(SetFeedbackFlowState(arg1))
            end)
        end,
        setFeedbackReason = function(arg1)
            callback(function(arg2)
                arg2:dispatch(SetFeedbackReason(arg1))
            end)
        end,
        getSourceLanguageName = function()
            if GetFFlagEnableFeedbackShowSourceTextAndOtherUXImprovements() then
                callback(GetSourceLanguageThunk())
            end
        end
    }
end)(var1)
