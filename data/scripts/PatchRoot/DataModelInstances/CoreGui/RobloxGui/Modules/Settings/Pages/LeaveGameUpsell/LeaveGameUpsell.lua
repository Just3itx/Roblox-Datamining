-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:11:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local ContextActionService = game:GetService("ContextActionService")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local GuiService = game:GetService("GuiService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")

local default = require(RobloxGui.Modules.VoiceChat.VoiceChatServiceManager).default
local Constants = require(RobloxGui.Modules.VoiceChat.Constants)

local Roact = require(CorePackages.Packages.Roact)
local React = require(CorePackages.Packages.React)
local UIBlox = require(CorePackages.Packages.UIBlox)
local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local Button = UIBlox.App.Button.Button
local ButtonStack = UIBlox.App.Button.ButtonStack
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local useStyle = UIBlox.Core.Style.useStyle
local PhoneLegalDisclaimer = require(CorePackages.Workspace.Packages.PhoneUpsell).PhoneLegalDisclaimer
local InExperienceProviderContainer = require(CorePackages.Workspace.Packages.InExperienceContainer).InExperienceProviderContainer

local PostPhoneUpsellDisplayed = require(CorePackages.Workspace.Packages.PhoneUpsell).Http.Requests.PostPhoneUpsellDisplayed
local PhoneUpsellController = require(CorePackages.Workspace.Packages.PhoneUpsell).PhoneUpsellController
local Constants2 = require(CorePackages.Workspace.Packages.PhoneUpsell).Constants
local RoactNetworking = require(CorePackages.Workspace.Packages.RoactServiceTags).RoactNetworking
local useAppPolicy = require(CorePackages.Workspace.Packages.UniversalAppPolicy).useAppPolicy
local useLocalization = require(CorePackages.Workspace.Packages.Localization).Hooks.useLocalization
local useRoactService = require(CorePackages.Workspace.Packages.RobloxAppHooks).useRoactService
local useInputType = require(CorePackages.Workspace.Packages.RoactUtils).Hooks.useInputType
local InputTypeConstants = require(CorePackages.Workspace.Packages.InputType).InputTypeConstants
local useEventConnection = require(CorePackages.Packages.ReactUtils).useEventConnection
local getPlatformTarget = require(CorePackages.Workspace.Packages.Analytics).getPlatformTarget
local EventStreamConstants = require(CorePackages.Workspace.Packages.AuthAnalytics).EventStreamConstants
local leaveGame = require(RobloxGui.Modules.Settings.leaveGame)

local GetFFlagDisablePVUpsellDataConsent = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagDisablePVUpsellDataConsent

local engineFeature = game:GetEngineFeature("RbxAnalyticsServiceExposePlaySessionId")

local GetFFlagAddMorePhoneUpsellEvents = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagAddMorePhoneUpsellEvents

RobloxGui:WaitForChild("Modules"):WaitForChild("TenFootInterface")

local Constants3 = require(RobloxGui.Modules:WaitForChild("InGameMenu"):WaitForChild("Resources"):WaitForChild("Constants"))

local function Initialize()
    local var1 = require(RobloxGui.Modules.Settings.SettingsPageFactory):CreateNewPage()

    var1.playsessionid = ""
    if engineFeature then
        var1.playsessionid = RbxAnalyticsService:GetPlaySessionId()
    end

    function var1.DontLeaveFunc(arg1)
        if var1.HubRef then
            var1.HubRef:PopMenu(arg1, true)
        end

        RbxAnalyticsService:SetRBXEventStream(
            Constants3.AnalyticsTargetName,
            Constants3.AnalyticsInGameMenuName,
            Constants3.AnalyticsLeaveGameName,
            {
                confirmed = Constants3.AnalyticsCancelledName,
                universeid = tostring(game.GameId),
                source = Constants3.AnalyticsLeaveGameSource,
                playsessionid = var1.playsessionid
            }
        )
    end
    function var1.DontLeaveFromHotkey(_, userInputState, arg1)
        if userInputState == Enum.UserInputState.Begin then
            local bool1 = arg1.UserInputType == Enum.UserInputType.Gamepad1
                or arg1.UserInputType == Enum.UserInputType.Gamepad2
                or arg1.UserInputType == Enum.UserInputType.Gamepad3
                or arg1.UserInputType == Enum.UserInputType.Gamepad4

            var1.DontLeaveFunc(bool1)
        end
    end
    function var1.DontLeaveFromButton(arg1)
        var1.DontLeaveFunc(arg1)
    end

    var1.TabHeader = nil

    var1.Page.Name = "LeaveGameUpsellPage"
    var1.ShouldShowBottomBar = false
    var1.ShouldShowHubBar = false
    var1.DisableTopPadding = true

    function var1.UpsellComponent(arg1)
        local upsellType = var1.upsellType
        local var2 = useStyle()
        local var3 = useLocalization({
            headerKey = if upsellType == Constants.PHONE_UPSELL_VALUE_PROP.VoiceChat then "Feature.VerificationUpsell.Heading.UnlockVoiceChat" else "Feature.VerificationUpsell.Heading.DontLoseAccess",
            bodyKey = if upsellType == Constants.PHONE_UPSELL_VALUE_PROP.VoiceChat then "Feature.VerificationUpsell.Description.UnlockVoiceChatBody" else "Feature.VerificationUpsell.Description.RecoverAccountEasily",
            voiceConsent = "Feature.VerificationUpsell.Description.VoiceLegalConsent2",
            voiceDisclaimer = "Feature.VerificationUpsell.Description.VoiceLegalDisclaimer2",
            button = "Feature.VerificationUpsell.Action.AddPhoneNumber",
            termsOfUse = "Feature.VerificationUpsell.Action.SMSTerms",
            privacyPolicy = "Feature.VerificationUpsell.Action.Privacy"
        })

        var3.voiceDisclaimer = var3.voiceDisclaimer:gsub("{buttonText}", var3.button)
        local showLegalTextCheckbox = useAppPolicy(function(arg2)
            return upsellType == Constants.PHONE_UPSELL_VALUE_PROP.VoiceChat and arg2.RequireExplicitVoiceConsent()
        end)
        local legalTextChecked, var6 = React.useState(false)

        local createElement = React.createElement
        local str1 = "Frame"
        local tbl1 = {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            LayoutOrder = arg1.LayoutOrder
        }

        local tbl2 = {
            ListLayout = React.createElement(
                "UIListLayout",
                {
                    FillDirection = Enum.FillDirection.Vertical,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, 12)
                }
            ),
            Header = React.createElement(
                StyledTextLabel,
                {
                    text = var3.headerKey,
                    fontStyle = var2.Font.Header2,
                    colorStyle = var2.Theme.TextEmphasis,
                    layoutOrder = 1
                }
            ),
            Body = React.createElement(StyledTextLabel, {
                text = var3.bodyKey,
                textWrapped = true,
                size = UDim2.new(1, 0, 0, 0),
                automaticSize = Enum.AutomaticSize.Y,
                fontStyle = var2.Font.Body,
                lineHeight = 1.1,
                colorStyle = var2.Theme.TextDefault,
                layoutOrder = 2
            }),
            Button = React.createElement(Button, {
                buttonType = ButtonType.Secondary,
                size = UDim2.new(1, 0, 0, var2.Tokens.Size.Size_1200),
                layoutOrder = 3,
                text = var3.button,
                onActivated = function()
                    var1.HubRef:SetVisibility(false, true)
                    if GetFFlagAddMorePhoneUpsellEvents() then
                        RbxAnalyticsService:SendEventDeferred(
                            getPlatformTarget(),
                            "verificationUpsell",
                            "modalAction",
                            {
                                origin = arg1.origin,
                                btn = EventStreamConstants.Button.Continue,
                                section = arg1.section
                            }
                        )
                    end

                    PhoneUpsellController.openPhoneUpsell({
                        origin = arg1.origin,
                        eventContext = "verificationUpsell",
                        onSuccessBeforeToast = function()
                            default:DisablePhoneVerificationUpsell()
                            arg1.onUpsellComplete()
                            var1.HubRef:SetVisibility(true, false)
                            var1.HubRef:SwitchToPage(var1.HubRef.LeaveGameUpsellPage, true)
                        end,
                        onSuccess = function()
                            if upsellType == Constants.PHONE_UPSELL_VALUE_PROP.VoiceChat then
                                default:EnableVoice()
                                arg1.setVoiceEnabled(true)
                            end
                        end
                    })
                end,
                isDisabled = showLegalTextCheckbox and not legalTextChecked
            }),
            PhoneLegalDisclaimer = 0
        }

        local var7

        if GetFFlagDisablePVUpsellDataConsent() then
            var7 = nil
        else
            local createElement2 = React.createElement
            local var8 = PhoneLegalDisclaimer
            local tbl3 = {
                legalText = if showLegalTextCheckbox then var3.voiceConsent else var3.voiceDisclaimer,
                termsOfUse = var3.termsOfUse,
                privacyPolicy = var3.privacyPolicy,
                showLegalText = upsellType == Constants.PHONE_UPSELL_VALUE_PROP.VoiceChat,
                showLegalButtons = true,
                showLegalTextCheckbox = showLegalTextCheckbox,
                legalTextChecked = legalTextChecked,
                setLegalTextChecked = 0,
                onTermsOfUseClick = 0,
                onPrivacyPolicyClick = 0,
                LayoutOrder = 4
            }

            function tbl3.setLegalTextChecked()
                var6(not legalTextChecked)
            end
            function tbl3.onTermsOfUseClick()
                if GetFFlagAddMorePhoneUpsellEvents() then
                    RbxAnalyticsService:SendEventDeferred(
                        getPlatformTarget(),
                        "verificationUpsell",
                        "modalAction",
                        {
                            origin = arg1.origin,
                            field = "termsOfService",
                            section = arg1.section
                        }
                    )
                end

                arg1.showWebpage(Constants2.TERMS_OF_SERVICE_URL)
            end
            function tbl3.onPrivacyPolicyClick()
                if GetFFlagAddMorePhoneUpsellEvents() then
                    RbxAnalyticsService:SendEventDeferred(
                        getPlatformTarget(),
                        "verificationUpsell",
                        "modalAction",
                        {
                            origin = arg1.origin,
                            field = "privacyPolicy",
                            section = arg1.section
                        }
                    )
                end

                arg1.showWebpage(Constants2.PRIVACY_POLICY_URL)
            end

            var7 = createElement2(var8, tbl3)
        end

        tbl2.PhoneLegalDisclaimer = var7
        return createElement(str1, tbl1, tbl2)
    end

    function var1.LeaveGameComponent(arg1)
        local var2 = useStyle()
        local var3 = useLocalization({
            confirmLeave = "Feature.VerificationUpsell.Action.ConfirmLeave",
            dontLeave = "Feature.VerificationUpsell.Action.DontLeave",
            returnWithVoice = "Feature.VerificationUpsell.Action.ReturnWithVoice"
        })

        local var4, var5 = React.useState("Incomplete")
        local bool1 = var4 == "Incomplete"
        local upsellType = var1.upsellType
        local origin = if upsellType == Constants.PHONE_UPSELL_VALUE_PROP.VoiceChat then "exitConfirmationScreenVoice" else "exitConfirmationScreenSecurity"

        local section = GetFFlagAddMorePhoneUpsellEvents() and (if var4 == "Incomplete" then "entry" else "verifyPhoneSuccess") or nil

        local buttonRef = React.useRef(nil)
        local var8, setVoiceEnabled = React.useState(false)

        local var10 = useRoactService(RoactNetworking)

        local var11 = useInputType()

        local function func1()
            ContextActionService:UnbindCoreAction("LeaveGameCancelAction")
            if var4 == "Completed" then
                var5("CompletedAndClosed")
            end
        end

        useEventConnection(var1.Displayed.Event, function()
            if var11 ~= InputTypeConstants.Touch then
                GuiService.SelectedCoreObject = buttonRef.current
            end
            ContextActionService:BindCoreAction("LeaveGameCancelAction", var1.DontLeaveFromHotkey, false, Enum.KeyCode.ButtonB)

            if var1.postSent then
                return
            end

            PostPhoneUpsellDisplayed(var10, Constants.EXIT_CONFIRMATION_PHONE_UPSELL_IXP_LAYER, os.time(), true, true):catch(
                function(_) end
            )

            if GetFFlagAddMorePhoneUpsellEvents() then
                RbxAnalyticsService:SendEventDeferred(
                    getPlatformTarget(),
                    "verificationUpsell",
                    "modalAction",
                    {
                        origin = arg1.origin,
                        aType = EventStreamConstants.ActionType.Shown,
                        section = arg1.section
                    }
                )
            end

            var1.postSent = true
        end)

        useEventConnection(var1.Hidden.Event, func1)

        local yOffset = if RobloxGui.AbsoluteSize.Y < 500 or RobloxGui.AbsoluteSize.X < 500 then 0 else 200

        local createElement = React.createElement
        local str2 = "Frame"
        local tbl1 = {
            Size = UDim2.new(1, 0, 0, 0),
            Position = UDim2.new(0, 0, 0, yOffset),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1
        }
        local tbl2 = {
            ListLayout = React.createElement(
                "UIListLayout",
                {
                    FillDirection = Enum.FillDirection.Vertical,
                    SortOrder = Enum.SortOrder.LayoutOrder
                }
            ),
            LeaveGame = 0,
            TopSpacer = 0,
            UpsellComponents = 0
        }
        local createElement2 = React.createElement
        local str3 = "Frame"
        local tbl3 = {
            Size = UDim2.new(1, 0, 0, 0),
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.Y,
            LayoutOrder = 1
        }
        local tbl4 = {
            ListLayout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                Padding = UDim.new(0, var2.Tokens.Size.Size_600),
                SortOrder = Enum.SortOrder.LayoutOrder
            }),
            LeaveGameButtons = 0
        }
        local createElement3 = React.createElement
        local var12 = ButtonStack
        local tbl5 = {
            buttons = 0,
            buttonHeight = 0,
            disableGamepadRefs = true,
            isRoactGamepadEnabled = false
        }
        local tbl6 = {
            buttonType = ButtonType.PrimarySystem,
            isDefaultChild = true,
            props = {
                layoutOrder = 1,
                text = var3.confirmLeave,
                onActivated = function()
                    if not var8
                        and (var4 == "Completed" or var4 == "CompletedAndClosed")
                        and upsellType == Constants.PHONE_UPSELL_VALUE_PROP.VoiceChat
                    then
                        default:EnableVoice()
                        setVoiceEnabled(true)
                    end
                    if GetFFlagAddMorePhoneUpsellEvents() then
                        RbxAnalyticsService:SendEventDeferred(
                            getPlatformTarget(),
                            "verificationUpsell",
                            "formInteraction",
                            { origin = origin, btn = "confirmLeave", section = section }
                        )
                    end
                    leaveGame(false)
                end,
                buttonRef = buttonRef
            }
        }
        local tbl7 = {
            buttonType = ButtonType.Secondary,
            props = 0
        }
        local props = {
            layoutOrder = 2,
            text = if var4 == "Completed" and upsellType == Constants.PHONE_UPSELL_VALUE_PROP.VoiceChat then var3.returnWithVoice else var3.dontLeave,
            onActivated = 0
        }

        function props.onActivated()
            if GetFFlagAddMorePhoneUpsellEvents() then
                if var4 == "Completed" and upsellType == Constants.PHONE_UPSELL_VALUE_PROP.VoiceChat then
                    RbxAnalyticsService:SendEventDeferred(
                        getPlatformTarget(),
                        "verificationUpsell",
                        "formInteraction",
                        { origin = origin, btn = "returnWithVoice", section = section }
                    )
                elseif var4 == "Incomplete" then
                    RbxAnalyticsService:SendEventDeferred(
                        getPlatformTarget(),
                        "verificationUpsell",
                        "modalAction",
                        {
                            origin = origin,
                            aType = EventStreamConstants.ActionType.Dismiss,
                            section = section
                        }
                    )
                end
            end
            var1.DontLeaveFromButton()
        end

        tbl7.props = props
        tbl5.buttons = { tbl6, tbl7 }

        tbl5.buttonHeight = var2.Tokens.Size.Size_1200
        tbl4.LeaveGameButtons = createElement3(var12, tbl5)
        tbl2.LeaveGame = createElement2(str3, tbl3, tbl4)

        tbl2.TopSpacer = React.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                LayoutOrder = 2,
                Size = UDim2.new(1, 0, 0, var2.Tokens.Size.Size_600)
            }
        )
        local element

        if bool1 then
            element = React.createElement(React.Fragment, {}, {
                Divider = React.createElement("Frame", {
                    LayoutOrder = 3,
                    BackgroundColor3 = var2.Tokens.Color.Stroke.Emphasis.Color3,
                    BackgroundTransparency = var2.Tokens.Color.Stroke.Emphasis.Transparency,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 1)
                }),
                BottomSpacer = React.createElement(
                    "Frame",
                    {
                        BackgroundTransparency = 1,
                        LayoutOrder = 4,
                        Size = UDim2.new(1, 0, 0, var2.Tokens.Size.Size_600)
                    }
                ),
                Upsell = React.createElement(var1.UpsellComponent, {
                    origin = origin,
                    section = section,
                    LayoutOrder = 5,
                    showWebpage = arg1.showWebpage,
                    onUpsellComplete = function()
                        var5("Completed")
                    end,
                    setVoiceEnabled = setVoiceEnabled
                })
            })
        else
            element = nil
        end

        tbl2.UpsellComponents = element
        return createElement(str2, tbl1, tbl2)
    end

    local element = React.createElement(
        InExperienceProviderContainer,
        {},
        React.createElement(var1.LeaveGameComponent, {
            showWebpage = function() end
        }, {})
    )

    var1.handle = Roact.mount(element, var1.Page, "LeaveGameUpsell")

    var1.Page.Size = UDim2.new(1, 0, 0, 0)
    var1.Page.AutomaticSize = Enum.AutomaticSize.Y

    return var1
end

local var1 = Initialize()

function var1.SetUpsellProp(arg1, upsellType)
    if upsellType == Constants.PHONE_UPSELL_VALUE_PROP.None then
        return
    end

    arg1.upsellType = upsellType
    arg1.handle = Roact.update(
        arg1.handle,
        React.createElement(
            InExperienceProviderContainer,
            {},
            React.createElement(arg1.LeaveGameComponent, {
                showWebpage = function() end
            }, {})
        )
    )
end

return var1
