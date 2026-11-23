-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TrustedContacts = script:FindFirstAncestor("TrustedContacts")
local TrustedContactsParent = TrustedContacts.Parent

local React = require(TrustedContactsParent.React)
local useLocalization = require(TrustedContactsParent.Localization).Hooks.useLocalization
local Foundation = require(TrustedContactsParent.Foundation)
local ButtonVariant = Foundation.Enums.ButtonVariant
local Dialog = Foundation.Dialog
local DialogSize = Foundation.Enums.DialogSize

local Analytics = require(script.Parent.Parent.Parent.Analytics)
local useTCAnalytics = Analytics.useTCAnalytics
local EventNames = Analytics.EventNames

local Contexts = require(TrustedContactsParent.SocialLuaAnalytics).Analytics.Enums.Contexts

local FStringConnectionGraphCoreAmpNameSpace = require(TrustedContactsParent.SharedFlags).FStringConnectionGraphCoreAmpNameSpace

local FFlagTCUpdateProfileCTAButton = require(TrustedContactsParent.SharedFlags).FFlagTCUpdateProfileCTAButton

local _Types = require(TrustedContacts.Common.Types)

local function TrustedFriendsVPCPrologue(tbl1)
    local var1 = useLocalization({
        cancel = "CommonUI.Controls.Action.Cancel",
        ask = "Feature.Friends.Label.Ask",
        askYourParent = "Feature.Friends.Label.AskYourParent",
        vpcRequired = "Feature.Friends.Label.AddFriendVPC"
    })

    local fireAnalyticsEvent = useTCAnalytics({ friendId = tbl1.userId }).fireAnalyticsEvent

    local var2 = React.useCallback(function()
        tbl1.externalNavigation.closeModal()
    end, { tbl1.externalNavigation })

    local onActivated = React.useCallback(function()
        fireAnalyticsEvent(EventNames.TrustedFriendsVPCCancelClicked)
        var2()
    end, { var2, fireAnalyticsEvent })

    local completionCallback = React.useCallback(function(_, _)
        if FFlagTCUpdateProfileCTAButton and tbl1.completionCallback then
            tbl1.completionCallback()
        end
    end, { if FFlagTCUpdateProfileCTAButton then tbl1.completionCallback else nil })

    local var3 = React.useCallback(function()
        fireAnalyticsEvent(EventNames.TrustedFriendsVPCAskClicked)
        var2()

        tbl1.externalNavigation.openAmpWizard({
            featureName = "TriggerTrustedFriendVPCRecourse",
            completionCallback = completionCallback,
            recourseData = {
                targetUserId = tbl1.userId
            },
            entryPointEventCtx = Contexts.TrustedFriendsVPCPrologue,
            extraParameters = {{
                name = "targetUser",
                type = "UserId",
                value = tbl1.userId
            }},
            nameSpace = FStringConnectionGraphCoreAmpNameSpace
        })
    end, {
        fireAnalyticsEvent,
        var2,
        tbl1.externalNavigation,
        tbl1.userId,
        completionCallback
    })

    return React.createElement(Dialog.Root, {
        size = DialogSize.Small
    }, {
        Title = React.createElement(Dialog.Title, { LayoutOrder = 1, text = var1.askYourParent }),
        Content = React.createElement(
            Dialog.Content,
            { LayoutOrder = 2 },
            {
                Text = React.createElement(Dialog.Text, { Text = var1.vpcRequired })
            }
        ),
        Buttons = React.createElement(Dialog.Actions, {
            LayoutOrder = 3,
            actions = {
                {
                    text = var1.ask,
                    variant = ButtonVariant.Emphasis,
                    onActivated = var3
                },
                {
                    text = var1.cancel,
                    variant = ButtonVariant.Standard,
                    onActivated = onActivated
                }
            }
        })
    })
end

return {
    Screen = function(tbl1)
        return React.createElement(TrustedFriendsVPCPrologue, {
            userId = tbl1.navigation.getParam("userId"),
            completionCallback = tbl1.navigation.getParam("completionCallback"),
            externalNavigation = tbl1.screenProps.externalNavigation
        })
    end
}
