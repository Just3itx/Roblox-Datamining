-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:10:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local ContextActionService = game:GetService("ContextActionService")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local CorePackages = game:GetService("CorePackages")
local LocalizationService = game:GetService("LocalizationService")
local Players = game:GetService("Players")

local SharedFlags = CorePackages.Workspace.Packages.SharedFlags
local GetFFlagGateEducationalPopupVisibilityViaGUAC = require(SharedFlags).GetFFlagGateEducationalPopupVisibilityViaGUAC

local InExperienceCapabilities = require(CorePackages.Workspace.Packages.InExperienceCapabilities).InExperienceCapabilities
local isSideSheetEnabled = require(CorePackages.Workspace.Packages.InExperienceSideSheetUtils.isSideSheetEnabled)
local FFlagSurvBloxEventTypeEnabled = require(SharedFlags).FFlagSurvBloxEventTypeEnabled
local toggleSideSheet = if isSideSheetEnabled then require(CorePackages.Workspace.Packages.InExperienceSideSheet).toggleSideSheet else nil

local notificationTypeList = GuiService:GetNotificationTypeList()
local Roact = require(CorePackages.Packages.Roact)
local LinkingProtocol = require(CorePackages.Workspace.Packages.LinkingProtocol)
local DeepLinkSource = LinkingProtocol.Enums.DeepLinkSource
local LinkingProtocol2 = LinkingProtocol.LinkingProtocol
local Localization = require(CorePackages.Workspace.Packages.InExperienceLocales).Localization
local SendAnalytics = require(RobloxGui.Modules.InGameMenu.Utility.SendAnalytics)
local UserLocalStore = require(RobloxGui.Modules.InGameMenu.Utility.UserLocalStore)
local GetDefaultQualityLevel = require(CorePackages.Workspace.Packages.AppCommonLib).GetDefaultQualityLevel
local SurveyEventPublisher = require(CorePackages.Workspace.Packages.OnPlatformSurveys.SurveyEventPublisher)
local WebViewEventType = require(CorePackages.Workspace.Packages.OnPlatformSurveys.WebViewEventType)
local MessageBus = require(CorePackages.Workspace.Packages.MessageBus).MessageBus

local UIBlox = require(CorePackages.Packages.InGameMenuDependencies).UIBlox
local Images = UIBlox.App.ImageSet.Images
local EducationalModal = UIBlox.App.Dialog.Modal.EducationalModal

local renderWithCoreScriptsStyleProvider = require(RobloxGui.Modules.Common.renderWithCoreScriptsStyleProvider)

local var1 = nil

local Constants = require(RobloxGui.Modules:WaitForChild("InGameMenu"):WaitForChild("Resources"):WaitForChild("Constants"))

local GetFIntEducationalPopupDisplayMaxCount = require(RobloxGui.Modules.Flags.GetFIntEducationalPopupDisplayMaxCount)

local function Initialize()
    local var2 = require(RobloxGui.Modules.Settings.SettingsPageFactory):CreateNewPage()

    function var2.LeaveAppFunc(arg1)
        GuiService.SelectedCoreObject = nil

        SendAnalytics("educational_popup", "educational_close_app", { source = if arg1 then "Native" else "Button" })

        RunService.RenderStepped:wait()
        RunService.RenderStepped:wait()

        settings().Rendering.QualityLevel = GetDefaultQualityLevel()

        GuiService:BroadcastNotification("", notificationTypeList.NATIVE_EXIT)
    end
    function var2.LeaveGameFunc(arg1)
        GuiService.SelectedCoreObject = nil

        SendAnalytics("educational_popup", "educational_confirmed", { source = if arg1 then "Gamepad" else "Button" })

        if LinkingProtocol2.default:isInternalDlicEnabled() then
            local var3 = LinkingProtocol2.default:createInternalDlic("roblox://navigation/home", DeepLinkSource.LuaInternal)

            LinkingProtocol2.default:detectDeeplinkIntent(var3)
        else
            LinkingProtocol2.default:detectURL("roblox://navigation/home")
        end

        RunService.RenderStepped:wait()
        RunService.RenderStepped:wait()

        game:Shutdown()

        settings().Rendering.QualityLevel = GetDefaultQualityLevel()
    end
    function var2.LeaveGameFromHotkey(_, userInputState, arg1)
        if userInputState == Enum.UserInputState.Begin then
            local bool1 = arg1.UserInputType == Enum.UserInputType.Gamepad1
                or arg1.UserInputType == Enum.UserInputType.Gamepad2
                or arg1.UserInputType == Enum.UserInputType.Gamepad3
                or arg1.UserInputType == Enum.UserInputType.Gamepad4

            var2.LeaveGameFunc(bool1)
        end
    end
    function var2.DontLeaveFunc(arg1)
        var1.dismissedFrom = if arg1 then "Gamepad" else "Button"

        if var2.HubRef then
            var2.HubRef:PopMenu(arg1, true)
        end
    end
    function var2.DontLeaveFromHotkey(_, userInputState, arg1)
        if userInputState == Enum.UserInputState.Begin then
            local bool1 = arg1.UserInputType == Enum.UserInputType.Gamepad1
                or arg1.UserInputType == Enum.UserInputType.Gamepad2
                or arg1.UserInputType == Enum.UserInputType.Gamepad3
                or arg1.UserInputType == Enum.UserInputType.Gamepad4

            var2.DontLeaveFunc(bool1)
        end
    end

    function var2.DontShowAgain()
        local userLocalStore = UserLocalStore.new()
        userLocalStore:SetItem("NativeCloseLuaPromptDisplayCount", tostring(math.huge))
        userLocalStore:Flush()
    end

    function var2.ShouldShow(): boolean
        local userLocalStore = UserLocalStore.new()
        local var3 = tonumber(userLocalStore:GetItem("NativeCloseLuaPromptDisplayCount"))
        if GetFIntEducationalPopupDisplayMaxCount() < var3 then
            return false
        end
        local var4 = var3 + 1
        userLocalStore:SetItem("NativeCloseLuaPromptDisplayCount", tostring(var4))
        userLocalStore:Flush()
        return true
    end

    var2.TabHeader = nil

    var2.Page.Name = "ExitModalPage"
    var2.ShouldShowBottomBar = false
    var2.ShouldShowHubBar = false
    var2.IsPageClipped = false

    var2.Page.Size = UDim2.new(1, 0, 0, 1)

    local localization = Localization.new(LocalizationService.RobloxLocaleId)

    local function ExitModal()
        localization:SetLocale(LocalizationService.RobloxLocaleId)
        local tbl1 = {
            title = localization:Format("CoreScripts.InGameMenu.ExitModal.Title"),
            subtitle = localization:Format("CoreScripts.InGameMenu.ExitModal.Subtitle"),
            bodyTextOpenMenu = localization:Format("CoreScripts.InGameMenu.ExitModal.BodyTextOpenMenu"),
            bodyTextClickHome = localization:Format("CoreScripts.InGameMenu.ExitModal.BodyTextClickHome"),
            optionDontShow = localization:Format("CoreScripts.InGameMenu.ExitModal.OptionDontShow"),
            actionExit = localization:Format("CoreScripts.InGameMenu.ExitModal.ActionExit"),
            actionHome = localization:Format("CoreScripts.InGameMenu.ExitModal.ActionHome")
        }
        local tbl2 = {
            Roact.createElement(EducationalModal, {
                bodyContents = {
                    {
                        text = tbl1.bodyTextOpenMenu,
                        isSystemMenuIcon = true
                    },
                    {
                        icon = Images["icons/menu/home_off"],
                        text = tbl1.bodyTextClickHome
                    }
                },
                hasDoNotShow = true,
                cancelText = tbl1.actionExit,
                confirmText = tbl1.actionHome,
                doNotShowText = tbl1.optionDontShow,
                titleBackgroundImageProps = {
                    image = "rbxasset://textures/ui/LuaApp/graphic/Auth/GridBackground_05202026.jpg",
                    imageHeight = 200,
                    text = "<font face=\"GothamBlack\" size=\"42\">" .. tbl1.title .. "</font><font size=\"4\"><br /></font><br />" .. tbl1.subtitle
                },
                screenSize = CoreGui.RobloxGui.AbsoluteSize,
                onDismiss = function()
                    var2.DontLeaveFunc(false)
                end,
                onCancel = function(arg1)
                    if arg1 then
                        var2.DontShowAgain()
                    end
                    var2.LeaveAppFunc(false)
                end,
                onConfirm = function(arg1)
                    if arg1 then
                        var2.DontShowAgain()
                    end
                    var2.LeaveGameFunc(false)

                    if FFlagSurvBloxEventTypeEnabled then
                        SurveyEventPublisher.publishSurveyEvent(WebViewEventType.LeaveButtonClick)
                        return
                    end

                    local customProps = {
                        chromeSeenCount = tostring(0)
                    }
                    local userId = tostring(Players.LocalPlayer.UserId)
                    MessageBus.publish(
                        Constants.OnSurveyEventDescriptor,
                        {
                            eventType = Constants.SurveyEventType,
                            userId = userId,
                            customProps = customProps
                        }
                    )
                end
            })
        }
        return renderWithCoreScriptsStyleProvider(tbl2)
    end

    local var3 = Roact.mount(ExitModal(), var2.Page, "ExitModal")

    local bool1 = false
    local function func1()
        if bool1 then
            return
        end

        bool1 = true
        task.delay(1, function()
            bool1 = false
            var3 = Roact.update(var3, ExitModal())
        end)
    end

    LocalizationService:GetPropertyChangedSignal("RobloxLocaleId"):Connect(func1)
    CoreGui.RobloxGui:GetPropertyChangedSignal("AbsoluteSize"):Connect(func1)

    return var2
end

var1 = Initialize()

var1.Displayed.Event:connect(function()
    if not var1.ShouldShow()
        or GetFFlagGateEducationalPopupVisibilityViaGUAC() and not InExperienceCapabilities.canViewEducationalPopup
    then
        var1.LeaveAppFunc(true)
    end

    var1.dismissedFrom = "Menu"
    ContextActionService:BindCoreAction("LeaveGameAction", var1.LeaveGameFromHotkey, false, Enum.KeyCode.ButtonA)

    ContextActionService:BindCoreAction("DontLeaveAction", var1.DontLeaveFromHotkey, false, Enum.KeyCode.ButtonB)

    if isSideSheetEnabled then
        toggleSideSheet(false)
    end
end)

var1.Hidden.Event:connect(function()
    if var1.dismissedFrom then
        SendAnalytics("educational_popup", "educational_dismiss_prompt", { source = var1.dismissedFrom })

        var1.dismissedFrom = nil
    end

    ContextActionService:UnbindCoreAction("LeaveGameAction")
    ContextActionService:UnbindCoreAction("DontLeaveAction")
end)

return var1
