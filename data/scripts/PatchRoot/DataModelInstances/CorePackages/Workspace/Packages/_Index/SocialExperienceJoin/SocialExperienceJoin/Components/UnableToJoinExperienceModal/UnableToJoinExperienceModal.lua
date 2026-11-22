-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialExperienceJoin = script:FindFirstAncestor("SocialExperienceJoin")
local SocialExperienceJoinParent = SocialExperienceJoin.Parent

local React = require(SocialExperienceJoinParent.React)
local UIBlox = require(SocialExperienceJoinParent.UIBlox)
local Localization = require(SocialExperienceJoinParent.Localization)
local TextKeys = require(SocialExperienceJoin.Common.TextKeys)

local useLocalization = Localization.Hooks.useLocalization
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local ButtonType = UIBlox.App.Button.Enum.ButtonType

return function(tbl1)
    local var1 = useLocalization({
        titleText = TextKeys.UnableToJoin,
        bodyText = {
            TextKeys.NoExperienceAccess,
            name = tbl1.userPrimaryName
        },
        confirmButtonText = TextKeys.ViewDetails,
        cancelButtonText = TextKeys.Cancel
    })

    return React.createElement(InteractiveAlert, {
        screenSize = tbl1.screenSize,
        title = var1.titleText,
        bodyText = var1.bodyText,
        buttonStackInfo = {
            buttons = {
                {
                    buttonType = nil,
                    props = {
                        text = var1.cancelButtonText,
                        onActivated = tbl1.cancel
                    }
                },
                {
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        text = var1.confirmButtonText,
                        onActivated = tbl1.openGameDetailsPeekView
                    }
                }
            }
        }
    })
end
