-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:01:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatformCommonParent = script:FindFirstAncestor("ProfilePlatformCommon").Parent

local PromptsEntryPoint = require(ProfilePlatformCommonParent.ServerTriggeredModals).PromptsEntryPoint

local SduiLoadTimer = require(ProfilePlatformCommonParent.SduiSharedUtilities).SduiLoadTimer
local AppPage = require(ProfilePlatformCommonParent.RobloxAppEnums).AppPage

local FFlagSduiAllowNoConfigsBuilt = require(ProfilePlatformCommonParent.SharedFlags).FFlagSduiAllowNoConfigsBuilt
local bool1 = game:DefineFastFlag("ProfileCompletionUsePlatformSurfaceKey", false)
local bool2 = game:DefineFastFlag("ProfileCompletionReplaceOnFetch", false)

return function()
    local loadTimer = SduiLoadTimer.createLoadTimer("ProfileCompletion")

    return {
        entryPoint = PromptsEntryPoint.SelfUserProfileOpen,
        surfaceKey = if bool1 then AppPage.ProfilePlatform else "ProfileCompletion",
        configKey = "ProfileCompletion",
        clearOnEmptyResponse = true,
        replaceOnFetch = if bool2 then true else nil,
        allowNoConfigsBuilt = if FFlagSduiAllowNoConfigsBuilt then true else nil,
        loadTimer = loadTimer
    }
end
