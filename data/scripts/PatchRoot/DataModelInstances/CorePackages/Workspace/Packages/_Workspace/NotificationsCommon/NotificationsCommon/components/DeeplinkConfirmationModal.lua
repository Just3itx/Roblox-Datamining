-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:20:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local scriptParentParentParent = script.Parent.Parent.Parent
local React = require(scriptParentParentParent.React)
local UIBlox = require(scriptParentParentParent.UIBlox)
local ReactRoblox = require(scriptParentParentParent.ReactRoblox)

local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local ButtonType = UIBlox.App.Button.Enum.ButtonType

local bool1 = game:DefineFastFlag("EnableToastNotificationsDeeplinkConfirmationModalHeightFix", false)

local RobloxTranslator = require(scriptParentParentParent.RobloxTranslator)
local FFlagGameInviteInExpJoinCta3 = require(scriptParentParentParent.SharedFlags).FFlagGameInviteInExpJoinCta3

return function(tbl1)
    local screenSize, var2 = React.useState(Vector2.new(800, 600))

    local title = RobloxTranslator:FormatByKey(
        FFlagGameInviteInExpJoinCta3 and tbl1.titleKey or "Notifications.ToastNotifications.Title.LeavingExperience"
    )
    local bodyText = RobloxTranslator:FormatByKey(
        FFlagGameInviteInExpJoinCta3 and tbl1.bodyKey or "Notifications.ToastNotifications.Label.LeaveExperienceConfirmation"
    )
    local text = RobloxTranslator:FormatByKey("InGame.InspectMenu.Action.Cancel")
    local var1 = RobloxTranslator:FormatByKey("InGame.InspectMenu.Action.Confirm")
    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Active = true,
        BackgroundTransparency = if tbl1.backgroundTransparency then tbl1.backgroundTransparency else 0.5,
        BackgroundColor3 = Color3.new(0, 0, 0),
        Size = UDim2.new(1, 0, 1, if bool1 then GuiService.TopbarInset.Height else 0)
    }
    tbl2[ReactRoblox.Change.AbsoluteSize] = function(arg1)
        var2(arg1.AbsoluteSize)
    end
    tbl2.Position = if bool1 then UDim2.fromOffset(0, -GuiService.TopbarInset.Height) else nil

    return createElement(str1, tbl2, {
        Alert = React.createElement(InteractiveAlert, {
            screenSize = screenSize,
            title = title,
            bodyText = bodyText,
            buttonStackInfo = {
                buttons = {
                    {
                        props = {
                            onActivated = function()
                                tbl1.closeCallback(false)
                            end,
                            text = text
                        }
                    },
                    {
                        buttonType = ButtonType.PrimarySystem,
                        props = {
                            onActivated = function()
                                tbl1.closeCallback(true)
                            end,
                            text = var1
                        }
                    }
                }
            }
        })
    })
end
