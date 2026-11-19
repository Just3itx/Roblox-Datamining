-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:41:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local PolicyProvider = require(CorePackages.Packages.InGameMenuDependencies).PolicyProvider
local SharedFlags = CorePackages.Workspace.Packages.SharedFlags
local GetFFlagGateEducationalPopupVisibilityViaGUAC = require(SharedFlags).GetFFlagGateEducationalPopupVisibilityViaGUAC

local var1 = PolicyProvider.GetPolicyImplementations.MemStorageService("app-policy")
local var2 = PolicyProvider.withGetPolicyImplementation(var1)

local GetFIntEducationalPopupDisplayMaxCount = require(script.Parent.Parent.Flags.GetFIntEducationalPopupDisplayMaxCount)

local isSubjectToDesktopPolicies = require(CorePackages.Workspace.Packages.SharedFlags).isSubjectToDesktopPolicies

function var2.Mapper(arg1)
    return {
        enableInGameHomeIcon = function()
            return isSubjectToDesktopPolicies()
        end,
        enableEducationalPopup = function()
            local engineFeature = game:GetEngineFeature("NativeCloseIntercept")
            return if isSubjectToDesktopPolicies() and engineFeature then not GetFFlagGateEducationalPopupVisibilityViaGUAC()
                or arg1.InExperienceCanViewEducationalPopup == nil
                or arg1.InExperienceCanViewEducationalPopup else false
        end,
        educationalPopupMaxDisplayCount = function()
            return isSubjectToDesktopPolicies() and GetFIntEducationalPopupDisplayMaxCount() or 0
        end,
        getGameInfoShowChatFeatures = function(): boolean
            return false
        end,
        enableFullscreenTitleBar = function()
            return arg1.FullscreenTitleBarEnabled or false
        end,
        getDisplayCheckboxInVoiceConsent = function()
            return arg1.DisplayCheckboxInVoiceConsent == nil or arg1.DisplayCheckboxInVoiceConsent
        end
    }
end

return var2
