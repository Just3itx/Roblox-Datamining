-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:31:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContactImporterParent = script:FindFirstAncestor("ContactImporter").Parent
local RoactAppExperiment = require(ContactImporterParent.RoactAppExperiment)
local str1 = game:DefineFastString("ContactImportLayer", "Social.ContactList")

local str2 = game:DefineFastString("ContactImportGreenFindFriendsButtonExperimentVariable", "green_find_friends_button")

local str3 = game:DefineFastString("ContactImportRemoveCloseButtonExperimentVariable", "remove_close_button")

local useUserExperiment = RoactAppExperiment.useUserExperiment

local function isGreenFindFriendsButtonExperimentEnabled(arg1): boolean
    return ((arg1 or {})[str1] or {})[str2] == true
end

local function isRemoveCloseButtonExperimentEnabled(arg1): boolean
    return ((arg1 or {})[str1] or {})[str3] == true
end

return {
    isGreenFindFriendsButtonExperimentEnabled = isGreenFindFriendsButtonExperimentEnabled,
    isRemoveCloseButtonExperimentEnabled = isRemoveCloseButtonExperimentEnabled,
    useIsGreenFindFriendsButtonExperimentEnabled = function(tbl1)
        return useUserExperiment({ str1 }, isGreenFindFriendsButtonExperimentEnabled, tbl1.isExposureEnabled)
    end,
    useIsRemoveCloseButtonExperimentEnabled = function(tbl1)
        return useUserExperiment({ str1 }, isRemoveCloseButtonExperimentEnabled, tbl1.isExposureEnabled)
    end
}
