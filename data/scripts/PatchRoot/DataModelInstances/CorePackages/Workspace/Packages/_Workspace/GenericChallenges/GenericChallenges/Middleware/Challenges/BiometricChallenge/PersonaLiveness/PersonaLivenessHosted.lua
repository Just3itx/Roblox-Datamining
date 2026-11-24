-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:30:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericChallengesParent = script:FindFirstAncestor("GenericChallenges").Parent

local React = require(GenericChallengesParent.React)

local AppLinking = require(GenericChallengesParent.RoactServiceTags).AppLinking

local useRoactService = require(GenericChallengesParent.RobloxAppHooks).useRoactService
local useLocalization = require(GenericChallengesParent.Localization).Hooks.useLocalization

local FullscreenPageWithSafeArea = require(GenericChallengesParent.AppBlox).FullscreenPageWithSafeArea

local Foundation = require(GenericChallengesParent.Foundation)
local Dialog = Foundation.Dialog
local DialogSize = Foundation.Enums.DialogSize
local View = Foundation.View
local Button = Foundation.Button
local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize
local FillBehavior = Foundation.Enums.FillBehavior
local Loading = Foundation.Loading
local FoundationText = Foundation.Text

local FocusNavigationUtils = require(GenericChallengesParent.FocusNavigationUtils)
local FocusNavigableSurfaceWrapper = FocusNavigationUtils.FocusNavigableSurfaceWrapper
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum

local function PersonaLivenessHosted(tbl1)
    local webLink = tbl1.webLink
    local onCancel = tbl1.onCancel
    local sessionId = tbl1.sessionId

    local var1 = useRoactService(AppLinking)

    local var2, var3 = React.useState(false)

    local onActivated = React.useCallback(function()
        var3(true)
        var1:openURL(webLink)
    end, { var1, webLink, sessionId })

    local var4 = React.useCallback(function()
        onCancel()
    end, { onCancel, sessionId })

    local var6 = useLocalization({
        title = "Feature.BiometricChallenge.Title.ConfirmHuman",
        bodyText = "Feature.BiometricChallenge.Content.LivenessHostedPrompt",
        loadingText = "Feature.BiometricChallenge.Content.Loading",
        continueButton = "Feature.BiometricChallenge.Action.Continue",
        cancelButton = "Feature.BiometricChallenge.Action.Cancel"
    })

    return React.createElement(
        "ScreenGui",
        {
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
            DisplayOrder = 200,
            IgnoreGuiInset = true
        },
        {
            Overlay = React.createElement(FullscreenPageWithSafeArea, { includeStatusBar = false }, {
                FocusNavigableSurface = React.createElement(
                    FocusNavigableSurfaceWrapper,
                    {
                        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.ModerationOverlay,
                        isIsolated = true
                    },
                    {
                        Dialog = React.createElement(Dialog.Root, {
                            size = DialogSize.Medium,
                            hasBackdrop = true
                        }, {
                            DialogTitle = not var2 and React.createElement(Dialog.Title, { text = var6.title, LayoutOrder = 1 }),
                            DialogContent = React.createElement(Dialog.Content, nil, {
                                DialogView = React.createElement(View, {
                                    tag = "col fill auto-xy items-center gap-medium"
                                }, {
                                    Loading = var2
                                        and React.createElement(View, { LayoutOrder = 1, tag = "auto-xy margin-top-medium" }, { React.createElement(Loading, {}) }),
                                    DialogBody = var2
                                        and React.createElement(
                                            FoundationText,
                                            {
                                                Text = var6.loadingText,
                                                LayoutOrder = 2,
                                                tag = "text-wrap auto-y size-full-0 text-body-medium"
                                            }
                                        )
                                        or React.createElement(Dialog.Text, { Text = var6.bodyText, LayoutOrder = 2 }),
                                    DialogFooter = React.createElement(View, {
                                        tag = "row size-full-0 auto-y gap-small",
                                        LayoutOrder = 3
                                    }, {
                                        CancelButton = React.createElement(Button, {
                                            variant = ButtonVariant.Standard,
                                            size = InputSize.Medium,
                                            text = var6.cancelButton,
                                            fillBehavior = FillBehavior.Fill,
                                            onActivated = var4,
                                            LayoutOrder = 1
                                        }),
                                        ContinueButton = not var2
                                            and React.createElement(Button, {
                                                variant = ButtonVariant.Emphasis,
                                                size = InputSize.Medium,
                                                text = var6.continueButton,
                                                fillBehavior = FillBehavior.Fill,
                                                onActivated = onActivated,
                                                icon = "icons/navigation/externallink_medium",
                                                LayoutOrder = 2
                                            })
                                    })
                                })
                            })
                        })
                    }
                )
            })
        }
    )
end

return PersonaLivenessHosted
