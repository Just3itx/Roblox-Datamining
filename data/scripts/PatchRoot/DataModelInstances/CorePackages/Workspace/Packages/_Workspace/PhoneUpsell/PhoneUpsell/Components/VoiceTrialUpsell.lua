-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:11:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PhoneUpsell = script:FindFirstAncestor("PhoneUpsell")
local PhoneUpsellParent = PhoneUpsell.Parent

local React = require(PhoneUpsellParent.React)
local UIBlox = require(PhoneUpsellParent.UIBlox)
local normalizeFontFace = require(PhoneUpsellParent.Foundation).Utility.normalizeFontFace
local useStyle = UIBlox.Core.Style.useStyle
local useLocalization = require(PhoneUpsellParent.Localization).Hooks.useLocalization
local useRef = React.useRef
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local Images = UIBlox.App.ImageSet.Images
local Cryo = require(PhoneUpsellParent.Cryo)
local PostUserOptIn = require(PhoneUpsellParent.VoiceChat).PostUserOptIn
local useRoactService = require(PhoneUpsellParent.RobloxAppHooks).useRoactService
local RoactNetworking = require(PhoneUpsellParent.RoactServiceTags).RoactNetworking
local FocusNavigationUtils = require(PhoneUpsellParent.FocusNavigationUtils)
local FocusNavigableSurfaceWrapper = FocusNavigationUtils.FocusNavigableSurfaceWrapper
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local useDispatch = require(PhoneUpsellParent.RoactUtils).Hooks.RoactRodux.useDispatch
local ToastRodux = require(PhoneUpsellParent.ToastRodux)
local SetCurrentToastMessage = ToastRodux.Actions.SetCurrentToastMessage
local PostUpsellTrialOptIn = require(PhoneUpsell.Http.Requests.PostUpsellTrialOptIn)

local tbl1 = {}

local function getButtonStackProps(text: string, buttonHeight: number, onActivated: (...any) -> (...any), text2: string, onActivated2: (...any) -> (...any))
    local buttons = {{
        buttonType = ButtonType.PrimarySystem,
        props = { onActivated = onActivated, text = text }
    }}

    if text2 and text2 ~= "" then
        table.insert(buttons, 1, { buttonType = ButtonType.Secondary, props = { onActivated = onActivated2, text = text2 } })
    end

    return { buttonHeight = buttonHeight, buttons = buttons }
end

local function VoiceTrialUpsell(tbl2)
    local var1 = Cryo.Dictionary.union(tbl1, tbl2)

    local var2 = useDispatch()
    local ref = useRef(nil)
    local var4 = useStyle()
    local baseSize = var4.Font.BaseSize
    local var5 = useLocalization({
        titleKey = "Feature.VerificationUpsell.Heading.TryVoiceChat",
        descriptionKey = "Feature.VerificationUpsell.Description.VoiceLegalConsent2",
        buttonKey = "Feature.VerificationUpsell.Action.TurnOn",
        extraButtonKey = "Feature.VerificationUpsell.Action.NotNow.2"
    })
    local var6 = useRoactService(RoactNetworking)

    local function handleTurnOn()
        var1.onClose()
        PostUserOptIn(var6, true, false):andThen(function(_)
            return PostUpsellTrialOptIn(var6, var1.upsellCardType)
        end):andThen(function()
            var2(
                SetCurrentToastMessage({
                    toastMessage = "Feature.VerificationUpsell.Heading.VoiceChatTurnedOn",
                    isLocalized = false,
                    toastType = ToastRodux.Enums.ToastType.SuccessConfirmation,
                    toastIcon = Images["icons/status/success_large"],
                    toastIconColorStyle = {
                        Color = var4.Tokens.Color.System.Success.Color3
                    },
                    slideIn = true
                })
            )

            var1.onCompletion()
        end):catch(function()
            var2(
                SetCurrentToastMessage({
                    toastMessage = "Feature.VerificationUpsell.Heading.VoiceChatJoinFailed",
                    isLocalized = false,
                    toastType = ToastRodux.Enums.ToastType.NetworkingError,
                    toastIconColorStyle = {
                        Color = var4.Tokens.Color.System.Alert.Color3
                    },
                    slideIn = true
                })
            )
        end)
    end

    local createElement = React.createElement
    local var7 = FocusNavigableSurfaceWrapper
    local tbl3 = {
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp,
        isIsolated = true,
        frameProps = { ref = ref }
    }
    local tbl4 = { Modal = 0 }
    local createElement2 = React.createElement
    local var8 = InteractiveAlert
    local tbl5 = {
        title = var5.titleKey,
        screenSize = if ref and ref.current then ref.current.AbsoluteSize else Vector2.new(500, 500),
        buttonStackInfo = getButtonStackProps(var5.buttonKey, var4.Tokens.Size.Size_1200, handleTurnOn, var5.extraButtonKey, var1.onClose),
        onCloseClicked = var1.onClose,
        middleContent = 0
    }

    function tbl5.middleContent()
        return React.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.Y,
                Size = UDim2.new(1, 0, 0, 0)
            },
            {
                BodyText = React.createElement("TextLabel", {
                    LayoutOrder = 0,
                    BackgroundTransparency = 1,
                    Text = var5.descriptionKey,
                    TextSize = baseSize,
                    TextColor3 = var4.Theme.TextDefault.Color,
                    TextTransparency = var4.Theme.TextDefault.Transparency,
                    FontFace = normalizeFontFace(var4.Tokens.Typography.BodyLarge.Font),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextWrapped = true,
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    RichText = true
                })
            }
        )
    end

    tbl4.Modal = createElement2(var8, tbl5)
    return createElement(var7, tbl3, tbl4)
end

return VoiceTrialUpsell
