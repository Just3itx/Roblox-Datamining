-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
local CorePackages = game:GetService("CorePackages")

local scriptParentParent = script.Parent.Parent

local Images = require(CorePackages.Packages.InGameMenuDependencies).UIBlox.App.ImageSet.Images

local FFlagCoreUiMigrateUIBloxToFoundation = require(CorePackages.Workspace.Packages.SharedFlags).FFlagCoreUiMigrateUIBloxToFoundation

local Constants = require(scriptParentParent.Resources.Constants)

local pagesByIndex = {
    {
        key = Constants.InitalPageKey,
        navigationDepth = 1,
        component = script.InitalPage,
        parentPage = nil
    },
    {
        key = Constants.MainPagePageKey,
        navigationDepth = 1,
        component = script.Parent.MainPage,
        parentPage = nil
    },
    {
        key = "Players",
        title = "CoreScripts.InGameMenu.PageTitle.Players",
        icon = if FFlagCoreUiMigrateUIBloxToFoundation then "icons/controls/players" else Images["icons/controls/players"],
        component = script.PlayersPage,
        navigationDepth = 2,
        parentPage = Constants.MainPagePageKey
    },
    {
        key = "InviteFriends",
        title = "CoreScripts.InGameMenu.PageTitle.InviteFriends",
        icon = if FFlagCoreUiMigrateUIBloxToFoundation then "icons/actions/friends/friendInvite" else Images["icons/actions/friends/friendInvite"],
        component = script.Parent.InviteFriendsPage,
        navigationDepth = 2,
        parentPage = Constants.MainPagePageKey
    },
    {
        key = "GameSettings",
        title = "CoreScripts.InGameMenu.PageTitle.GameSettings",
        icon = if FFlagCoreUiMigrateUIBloxToFoundation then "icons/common/settings" else Images["icons/common/settings"],
        component = script.Parent.GameSettingsPage.BasicPage,
        navigationDepth = 2,
        parentPage = Constants.MainPagePageKey
    },
    {
        key = "Report",
        title = "CoreScripts.InGameMenu.PageTitle.Report",
        icon = if FFlagCoreUiMigrateUIBloxToFoundation then "icons/actions/feedback" else Images["icons/actions/feedback"],
        component = script.Parent.ReportPage,
        navigationDepth = 2,
        parentPage = Constants.MainPagePageKey
    },
    {
        key = "Controls",
        title = "CoreScripts.InGameMenu.PageTitle.Controls",
        icon = if FFlagCoreUiMigrateUIBloxToFoundation then "icons/controls/controls" else Images["icons/controls/controls"],
        component = script.Parent.ControlsPage,
        isModal = true,
        navigationDepth = 2,
        parentPage = Constants.MainPagePageKey
    },
    {
        key = "AdvancedGameSettings",
        title = "CoreScripts.InGameMenu.PageTitle.GameSettings",
        icon = Images["icons/menu/settings_large"],
        component = script.Parent.GameSettingsPage.AdvancedPage,
        isSecondaryPage = true,
        navigationDepth = 3,
        parentPage = "GameSettings"
    },
    {
        key = "VRGameSettings",
        title = "CoreScripts.InGameMenu.PageTitle.VRComfortSettings",
        icon = Images["icons/menu/settings_large"],
        component = script.Parent.GameSettingsPage.VRComfortSettingsPage,
        isSecondaryPage = true,
        navigationDepth = 3,
        parentPage = "GameSettings"
    },
    {
        key = Constants.LeaveToAppPromptPageKey,
        navigationDepth = 1,
        component = script.Dialog.LeaveToAppPrompt,
        parentPage = nil
    },
    {
        key = Constants.LeaveGamePromptPageKey,
        navigationDepth = 1,
        component = script.Dialog.LeaveGamePrompt,
        parentPage = nil
    }
}

local pagesByKey = {}

for index, value in ipairs(pagesByIndex) do
    value.index = index
    local bool1 = pagesByKey[value.key] == nil
    local key = value.key
    assert(bool1, ("page key %s is duplicated"):format(key))
    pagesByKey[value.key] = value
end

return { pagesByIndex = pagesByIndex, pagesByKey = pagesByKey }
