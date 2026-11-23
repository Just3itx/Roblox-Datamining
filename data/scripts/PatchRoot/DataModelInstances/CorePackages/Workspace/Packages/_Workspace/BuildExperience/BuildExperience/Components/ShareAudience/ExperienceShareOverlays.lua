-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:11:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)
local FriendsOnlyShareDialog = require(BuildExperience.Components.ShareAudience.FriendsOnlyShareDialog)
local PlaytestersOnlyShareDialog = require(BuildExperience.Components.ShareAudience.PlaytestersOnlyShareDialog)

local _useExperienceShareFlow = require(BuildExperience.utils.useExperienceShareFlow)

local function ExperienceShareOverlays(tbl1)
    local shareLinkError = useLocalization({ shareLinkError = LocalizationStrings.PRIVATE_INVITES_SHARE_LINK_ERROR }).shareLinkError

    local createElement = React.createElement
    local fragment = React.Fragment
    local var1 = nil
    local tbl2 = {
        FriendsOnlyShareDialog = if tbl1.activeDialog == "friends" then React.createElement(FriendsOnlyShareDialog, { onCancel = tbl1.onCancel, onShare = tbl1.onConfirmFriends }) else nil,
        PlaytestersOnlyShareDialog = 0
    }
    local var2

    if tbl1.activeDialog == "playtesters" then
        local createElement2 = React.createElement
        local var3 = PlaytestersOnlyShareDialog
        local tbl3 = {
            onCancel = tbl1.onCancel,
            onShare = tbl1.onConfirmPlaytesters,
            errorText = 0
        }

        if not tbl1.hasShareError then
            shareLinkError = nil
        end

        tbl3.errorText = shareLinkError
        var2 = createElement2(var3, tbl3)
    else
        var2 = nil
    end

    tbl2.PlaytestersOnlyShareDialog = var2
    return createElement(fragment, var1, tbl2)
end

return ExperienceShareOverlays
