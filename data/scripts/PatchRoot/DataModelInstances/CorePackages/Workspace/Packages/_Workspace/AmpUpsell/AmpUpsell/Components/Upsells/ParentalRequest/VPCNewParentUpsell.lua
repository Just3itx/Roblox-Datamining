-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:50:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpUpsell = script:FindFirstAncestor("AmpUpsell")
local AmpUpsellParent = AmpUpsell.Parent
local React = require(AmpUpsellParent.React)
local useLocalization = require(AmpUpsellParent.Localization).Hooks.useLocalization
local useSelector = require(AmpUpsellParent.RoactUtils).Hooks.RoactRodux.useSelector
local UIBlox = require(AmpUpsellParent.UIBlox)
local useStyle = UIBlox.Core.Style.useStyle
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local LinkButton = UIBlox.App.Button.LinkButton
local TextField = UIBlox.App.Input.TextField
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local Cryo = require(AmpUpsellParent.Cryo)
local useOnScreenKeyboardHeight = require(AmpUpsell.Common.useOnScreenKeyboardHeight)

local GetFFlagEnableVPCUpsellFoundationDialogHardening = require(AmpUpsell.Flags.GetFFlagEnableVPCUpsellFoundationDialogHardening)
local GetShouldUseFoundationUIVPCUpsell = require(AmpUpsell.Flags.GetShouldUseFoundationUIVPCUpsell)

local Foundation = require(AmpUpsellParent.Foundation)
local Dialog = Foundation.Dialog
local DialogSize = Foundation.Enums.DialogSize
local ButtonVariant = Foundation.Enums.ButtonVariant
local FoundationText = Foundation.Text

local uDim2 = UDim2.new(1, 0, 0, 0)

local function selectScreenSize(arg1)
    return arg1.ScreenSize
end

local function VPCNewParentUpsell(tbl1)
    local onCollectEmailAndSendRequest = tbl1.onCollectEmailAndSendRequest
    local onCancel = tbl1.onCancel
    local screenSize = useSelector(selectScreenSize)
    local onTextChange = tbl1.onTextChange
    local canSendRequest = tbl1.canSendRequest
    local textInput = tbl1.textInput
    local errorText = tbl1.errorText
    local openPrivacyPolicyLink = tbl1.openPrivacyPolicyLink
    local isChildSubjectToParentalControls = tbl1.isChildSubjectToParentalControls
    local var2 = useOnScreenKeyboardHeight()
    local disablePortal = if tbl1.disablePortal then tbl1.disablePortal else false
    local isInExperienceEntry = if tbl1.isInExperienceEntry then tbl1.isInExperienceEntry else false
    local shouldUseFoundationUivpcUpsell = GetShouldUseFoundationUIVPCUpsell(isInExperienceEntry)

    local var3 = useStyle()
    local var4 = useLocalization(
        Cryo.Dictionary.join(tbl1.messageStrings, {
            directionsTextSubjectToParentalControls = {
                "Feature.Parents.Description.EnterParentEmailV4",
                lineBreak = "\n\n"
            },
            directionsTextNotSubjectToParentalControls = {
                "Feature.Parents.Description.EnterParentEmailWithoutParentalControl",
                lineBreak = "\n\n"
            },
            privacyPolicyFooter = {
                "Feature.Parents.Description.ParentalEmailFooter",
                linkStart = "",
                linkEnd = ""
            }
        })
    )
    local titleText = var4.titleText
    local buttonText = var4.buttonText
    local var5

    if isChildSubjectToParentalControls then
        if shouldUseFoundationUivpcUpsell then
            var5 = string.format("%s\n\n%s\n", var4.childInstructions, var4.parentInstructionsPC)
        else
            var5 = string.format("%s\n", var4.directionsTextSubjectToParentalControls)
        end
    elseif shouldUseFoundationUivpcUpsell then
        var5 = string.format("%s\n\n%s\n", var4.childInstructions, var4.parentInstructionsNoPC)
    else
        var5 = string.format("%s\n", var4.directionsTextNotSubjectToParentalControls)
    end

    local textFieldHeaderText = var4.textFieldHeaderText
    if shouldUseFoundationUivpcUpsell then
        if GetFFlagEnableVPCUpsellFoundationDialogHardening() then
            return React.createElement(
                Dialog.Root,
                {
                    size = DialogSize.Large,
                    onClose = onCancel,
                    disablePortal = disablePortal,
                    hasBackdrop = true
                },
                {
                    DialogTitle = React.createElement(Dialog.Title, { text = titleText }),
                    DialogContent = React.createElement(Dialog.Content, { LayoutOrder = 2 }, {
                        Frame = React.createElement(
                            "Frame",
                            {
                                Size = uDim2,
                                AutomaticSize = Enum.AutomaticSize.Y,
                                BackgroundTransparency = 1
                            },
                            {
                                UIListLayout = React.createElement("UIListLayout", {
                                    SortOrder = Enum.SortOrder.LayoutOrder,
                                    FillDirection = Enum.FillDirection.Vertical,
                                    HorizontalAlignment = Enum.HorizontalAlignment.Left,
                                    VerticalAlignment = Enum.VerticalAlignment.Top
                                }),
                                HeaderText = React.createElement(Dialog.Text, { Text = var5, LayoutOrder = 1 }),
                                TextboxFrame = React.createElement(
                                    "Frame",
                                    {
                                        Size = uDim2,
                                        AutomaticSize = Enum.AutomaticSize.Y,
                                        BackgroundTransparency = 1,
                                        LayoutOrder = 2
                                    },
                                    {
                                        UIListLayout = React.createElement("UIListLayout", {
                                            SortOrder = Enum.SortOrder.LayoutOrder,
                                            FillDirection = Enum.FillDirection.Vertical,
                                            HorizontalAlignment = Enum.HorizontalAlignment.Left,
                                            VerticalAlignment = Enum.VerticalAlignment.Top,
                                            Padding = UDim.new(0, 10)
                                        }),
                                        TextFieldHeader = React.createElement(
                                            FoundationText,
                                            {
                                                Text = textFieldHeaderText,
                                                tag = "size-full-0 auto-y text-title-large text-wrap text-align-x-left",
                                                LayoutOrder = 0
                                            }
                                        ),
                                        TextField = React.createElement(TextField, {
                                            text = textInput,
                                            placeholder = var4.emailPlaceholder,
                                            required = true,
                                            hint = errorText,
                                            error = errorText ~= "",
                                            onChange = onTextChange,
                                            width = UDim.new(1, 0),
                                            layoutOrder = 1
                                        })
                                    }
                                ),
                                DisclaimerFrame = React.createElement(
                                    "Frame",
                                    {
                                        Size = uDim2,
                                        AutomaticSize = Enum.AutomaticSize.Y,
                                        BackgroundTransparency = 1,
                                        LayoutOrder = 3
                                    },
                                    {
                                        UIListLayout = React.createElement("UIListLayout", {
                                            SortOrder = Enum.SortOrder.LayoutOrder,
                                            FillDirection = Enum.FillDirection.Vertical,
                                            HorizontalAlignment = Enum.HorizontalAlignment.Center,
                                            VerticalAlignment = Enum.VerticalAlignment.Top
                                        }),
                                        Disclaimer = React.createElement(FoundationText, {
                                            Text = var4.privacyPolicyFooter,
                                            tag = "size-full-0 auto-y text-caption-medium text-wrap text-align-x-left",
                                            LayoutOrder = 1
                                        }),
                                        PrivacyPolicy = React.createElement(LinkButton, {
                                            text = var4.privacyLinkText,
                                            layoutOrder = 2,
                                            fontStyle = "Footer",
                                            underlineAlwaysEnabled = false,
                                            onActivated = openPrivacyPolicyLink
                                        })
                                    }
                                )
                            }
                        )
                    }),
                    DialogActions = React.createElement(Dialog.Actions, {
                        LayoutOrder = 3,
                        actions = {{
                            text = buttonText,
                            variant = ButtonVariant.Standard,
                            onActivated = function()
                                onCollectEmailAndSendRequest(textInput)
                            end,
                            isDisabled = not canSendRequest
                        }}
                    })
                }
            )
        end

        return React.createElement(
            Dialog.Root,
            {
                size = DialogSize.Large,
                onClose = onCancel,
                disablePortal = disablePortal
            },
            {
                DialogTitle = React.createElement(Dialog.Title, { text = titleText }),
                DialogContent = React.createElement(Dialog.Content, { LayoutOrder = 2 }, {
                    Frame = React.createElement("Frame", {
                        AutomaticSize = Enum.AutomaticSize.XY,
                        BackgroundTransparency = 1
                    }, {
                        UIListLayout = React.createElement("UIListLayout", {
                            SortOrder = Enum.SortOrder.LayoutOrder,
                            FillDirection = Enum.FillDirection.Vertical,
                            HorizontalAlignment = Enum.HorizontalAlignment.Left,
                            VerticalAlignment = Enum.VerticalAlignment.Top
                        }),
                        HeaderText = React.createElement(StyledTextLabel, {
                            text = var5,
                            fontStyle = var3.Font.CaptionHeader,
                            colorStyle = var3.Theme.TextDefault,
                            textXAlignment = Enum.TextXAlignment.Left,
                            textYAlignment = Enum.TextYAlignment.Top,
                            textWrapped = true,
                            automaticSize = Enum.AutomaticSize.XY,
                            layoutOrder = 1,
                            lineHeight = 1
                        }),
                        TextboxFrame = React.createElement(
                            "Frame",
                            {
                                AutomaticSize = Enum.AutomaticSize.XY,
                                BackgroundTransparency = 1,
                                LayoutOrder = 2
                            },
                            {
                                UIListLayout = React.createElement("UIListLayout", {
                                    SortOrder = Enum.SortOrder.LayoutOrder,
                                    FillDirection = Enum.FillDirection.Vertical,
                                    HorizontalAlignment = Enum.HorizontalAlignment.Left,
                                    VerticalAlignment = Enum.VerticalAlignment.Top,
                                    Padding = UDim.new(0, 10)
                                }),
                                TextFieldHeader = React.createElement(StyledTextLabel, {
                                    text = textFieldHeaderText,
                                    fontStyle = var3.Font.Header2,
                                    colorStyle = var3.Theme.TextDefault,
                                    textWrapped = true,
                                    automaticSize = Enum.AutomaticSize.XY,
                                    layoutOrder = 0
                                }),
                                TextField = React.createElement(TextField, {
                                    text = textInput,
                                    placeholder = var4.emailPlaceholder,
                                    required = true,
                                    hint = errorText,
                                    error = errorText ~= "",
                                    onChange = onTextChange,
                                    width = UDim.new(1, 0),
                                    layoutOrder = 1
                                })
                            }
                        ),
                        DisclaimerFrame = React.createElement(
                            "Frame",
                            {
                                AutomaticSize = Enum.AutomaticSize.XY,
                                BackgroundTransparency = 1,
                                LayoutOrder = 3
                            },
                            {
                                UIListLayout = React.createElement("UIListLayout", {
                                    SortOrder = Enum.SortOrder.LayoutOrder,
                                    FillDirection = Enum.FillDirection.Vertical,
                                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                                    VerticalAlignment = Enum.VerticalAlignment.Top
                                }),
                                Disclaimer = React.createElement(StyledTextLabel, {
                                    text = var4.privacyPolicyFooter,
                                    fontStyle = var3.Font.Footer,
                                    colorStyle = var3.Theme.TextDefault,
                                    textXAlignment = Enum.TextXAlignment.Left,
                                    textWrapped = true,
                                    automaticSize = Enum.AutomaticSize.XY,
                                    layoutOrder = 1,
                                    lineHeight = 1
                                }),
                                PrivacyPolicy = React.createElement(LinkButton, {
                                    text = var4.privacyLinkText,
                                    layoutOrder = 2,
                                    fontStyle = "Footer",
                                    underlineAlwaysEnabled = false,
                                    onActivated = openPrivacyPolicyLink
                                })
                            }
                        )
                    })
                }),
                DialogActions = React.createElement(Dialog.Actions, {
                    LayoutOrder = 3,
                    actions = {{
                        text = buttonText,
                        variant = ButtonVariant.Standard,
                        onActivated = function()
                            onCollectEmailAndSendRequest(textInput)
                        end,
                        isDisabled = not canSendRequest
                    }}
                })
            }
        )
    end

    return React.createElement(InteractiveAlert, {
        title = titleText,
        screenSize = screenSize,
        position = var2 > 0 and UDim2.new(0.5, 0, 1, -var2 * 0.8) or UDim2.fromScale(0.5, 0.5),
        anchorPoint = var2 > 0 and Vector2.new(0.5, 1) or nil,
        buttonStackInfo = {
            buttons = {{
                buttonType = ButtonType.PrimarySystem,
                props = {
                    onActivated = function()
                        onCollectEmailAndSendRequest(textInput)
                    end,
                    text = buttonText,
                    isDisabled = not canSendRequest
                }
            }}
        },
        onCloseClicked = onCancel,
        bottomPadding = 0,
        middleContent = function()
            return React.createElement("Frame", {
                AutomaticSize = Enum.AutomaticSize.XY,
                BackgroundTransparency = 1
            }, {
                UIListLayout = React.createElement("UIListLayout", {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    FillDirection = Enum.FillDirection.Vertical,
                    HorizontalAlignment = Enum.HorizontalAlignment.Left,
                    VerticalAlignment = Enum.VerticalAlignment.Top
                }),
                HeaderText = React.createElement(StyledTextLabel, {
                    text = var5,
                    fontStyle = var3.Font.CaptionHeader,
                    colorStyle = var3.Theme.TextDefault,
                    textXAlignment = Enum.TextXAlignment.Left,
                    textYAlignment = Enum.TextYAlignment.Top,
                    textWrapped = true,
                    automaticSize = Enum.AutomaticSize.XY,
                    layoutOrder = 1
                }),
                TextboxFrame = React.createElement(
                    "Frame",
                    {
                        AutomaticSize = Enum.AutomaticSize.XY,
                        BackgroundTransparency = 1,
                        LayoutOrder = 2
                    },
                    {
                        UIListLayout = React.createElement("UIListLayout", {
                            SortOrder = Enum.SortOrder.LayoutOrder,
                            FillDirection = Enum.FillDirection.Vertical,
                            HorizontalAlignment = Enum.HorizontalAlignment.Left,
                            VerticalAlignment = Enum.VerticalAlignment.Top,
                            Padding = UDim.new(0, 10)
                        }),
                        TextFieldHeader = React.createElement(StyledTextLabel, {
                            text = textFieldHeaderText,
                            fontStyle = var3.Font.Header2,
                            colorStyle = var3.Theme.TextDefault,
                            textWrapped = true,
                            automaticSize = Enum.AutomaticSize.XY,
                            layoutOrder = 0
                        }),
                        TextField = React.createElement(TextField, {
                            text = textInput,
                            placeholder = var4.emailPlaceholder,
                            required = true,
                            hint = errorText,
                            error = errorText ~= "",
                            onChange = onTextChange,
                            width = UDim.new(1, 0),
                            layoutOrder = 1
                        })
                    }
                ),
                DisclaimerFrame = React.createElement(
                    "Frame",
                    {
                        AutomaticSize = Enum.AutomaticSize.XY,
                        BackgroundTransparency = 1,
                        LayoutOrder = 3
                    },
                    {
                        UIListLayout = React.createElement("UIListLayout", {
                            SortOrder = Enum.SortOrder.LayoutOrder,
                            FillDirection = Enum.FillDirection.Vertical,
                            HorizontalAlignment = Enum.HorizontalAlignment.Center,
                            VerticalAlignment = Enum.VerticalAlignment.Top
                        }),
                        Disclaimer = React.createElement(StyledTextLabel, {
                            text = var4.privacyPolicyFooter,
                            fontStyle = var3.Font.Footer,
                            colorStyle = var3.Theme.TextDefault,
                            textXAlignment = Enum.TextXAlignment.Left,
                            textWrapped = true,
                            automaticSize = Enum.AutomaticSize.XY,
                            layoutOrder = 1
                        }),
                        PrivacyPolicy = React.createElement(LinkButton, {
                            text = var4.privacyLinkText,
                            layoutOrder = 2,
                            fontStyle = "Footer",
                            underlineAlwaysEnabled = false,
                            onActivated = openPrivacyPolicyLink
                        })
                    }
                )
            })
        end
    })
end

return VPCNewParentUpsell
