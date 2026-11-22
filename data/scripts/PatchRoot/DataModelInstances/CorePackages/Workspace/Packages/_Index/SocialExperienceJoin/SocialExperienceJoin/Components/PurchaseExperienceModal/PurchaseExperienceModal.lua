-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:50:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialExperienceJoin = script:FindFirstAncestor("SocialExperienceJoin")
local SocialExperienceJoinParent = SocialExperienceJoin.Parent

local React = require(SocialExperienceJoinParent.React)
local Localization = require(SocialExperienceJoinParent.Localization)
local UIBlox = require(SocialExperienceJoinParent.UIBlox)

local useLocalization = Localization.Hooks.useLocalization
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local TextKeys = require(SocialExperienceJoin.Common.TextKeys)

return function(tbl1)
    local var1 = useLocalization({
        titleText = TextKeys.PurchaseExperienceModalTitle,
        bodyText = {
            TextKeys.PurchaseExperienceModalBody,
            gameName = tbl1.experienceName,
            X = tbl1.price
        },
        confirmButtonText = TextKeys.Unlock,
        cancelButtonText = TextKeys.Cancel,
        successToastTitle = TextKeys.SuccessPurchaseToastTitle,
        successToastMessage = {
            TextKeys.SuccessPurchaseToastMessage,
            gameName = tbl1.experienceName,
            price = tbl1.price
        }
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
                        onActivated = tbl1.cancelPurchase
                    }
                },
                {
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        text = var1.confirmButtonText,
                        onActivated = tbl1.purchaseExperience
                    }
                }
            }
        }
    })
end
