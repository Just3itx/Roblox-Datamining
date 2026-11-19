-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:20:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")
local CorePackages = game:GetService("CorePackages")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local RoactRodux = InGameMenuDependencies.RoactRodux
local t = InGameMenuDependencies.t
local Images = InGameMenuDependencies.UIBlox.App.ImageSet.Images

local scriptParentParent = script.Parent.Parent
local withLocalization = require(scriptParentParent.Localization.withLocalization)
local CloseNativeClosePrompt = require(scriptParentParent.Actions.CloseNativeClosePrompt)
local LeaveGame = require(scriptParentParent.Utility.LeaveGame)

local EducationalPopupDialog = require(script.Parent.EducationalPopupDialog)

local SendAnalytics = require(scriptParentParent.Utility.SendAnalytics)

local notificationTypeList = GuiService:GetNotificationTypeList()

local var1 = Roact.PureComponent:extend("EducationalPopup")

var1.validateProps = t.strictInterface({ screenSize = t.Vector2, onDismiss = t.callback, onConfirm = t.callback, isClosingApp = t.boolean })

function var1.init(arg1)
    function arg1.onCancel()
        SendAnalytics("educational_popup", "educational_close_app", {})
        GuiService:BroadcastNotification("", notificationTypeList.NATIVE_EXIT)
    end
end

function var1.render(arg1)
    return withLocalization({
        title = "CoreScripts.InGameMenu.ExitModal.Title",
        subtitle = "CoreScripts.InGameMenu.ExitModal.Subtitle",
        bodyTextOpenMenu = "CoreScripts.InGameMenu.ExitModal.BodyTextOpenMenu",
        bodyTextClickHome = "CoreScripts.InGameMenu.ExitModal.BodyTextClickHome",
        actionExit = "CoreScripts.InGameMenu.ExitModal.ActionExit",
        actionHome = "CoreScripts.InGameMenu.ExitModal.ActionHome"
    })(
        function(arg2)
            return Roact.createElement(EducationalPopupDialog, {
                bodyContents = {
                    {
                        text = arg2.bodyTextOpenMenu,
                        isSystemMenuIcon = true
                    },
                    {
                        icon = Images["icons/menu/home_off"],
                        text = arg2.bodyTextClickHome
                    }
                },
                cancelText = arg2.actionExit,
                confirmText = arg2.actionHome,
                titleBackgroundImageProps = {
                    image = "rbxasset://textures/ui/LuaApp/graphic/Auth/GridBackground_05202026.jpg",
                    imageHeight = 200,
                    text = "<font face=\"GothamBlack\" size=\"42\">" .. arg2.title .. "</font><font size=\"4\"><br /></font><br />" .. arg2.subtitle
                },
                screenSize = arg1.props.screenSize,
                onDismiss = arg1.props.onDismiss,
                onCancel = arg1.onCancel,
                onConfirm = arg1.props.onConfirm,
                blurBackground = true,
                visible = arg1.props.isClosingApp
            })
        end
    )
end

function var1.didUpdate(arg1)
    local isClosingApp = arg1.props.isClosingApp
    GuiService:SetMenuIsOpen(isClosingApp, "EducationalPopup")
end

return RoactRodux.UNSTABLE_connect2(function(arg1, _)
    return {
        isClosingApp = arg1.nativeClosePrompt.closingApp,
        screenSize = arg1.screenSize
    }
end, function(callback)
    return {
        onDismiss = function()
            callback(CloseNativeClosePrompt())
            RbxAnalyticsService:ReportCounter("EducationalPopup_Dismiss", 1)
            SendAnalytics("educational_popup", "educational_dismiss_prompt", {})
        end,
        onConfirm = function()
            RbxAnalyticsService:ReportCounter("EducationalPopup_Confirm", 1)
            SendAnalytics("educational_popup", "educational_confirmed", {})

            LeaveGame()
        end
    }
end)(var1)
