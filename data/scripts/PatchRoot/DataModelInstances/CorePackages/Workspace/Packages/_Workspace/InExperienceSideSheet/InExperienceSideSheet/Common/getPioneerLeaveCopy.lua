-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:21:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceSideSheet = script:FindFirstAncestor("InExperienceSideSheet")
local InExperienceSideSheetParent = InExperienceSideSheet.Parent

local Constants = require(InExperienceSideSheet.Common.Constants)
local FFlagPioneerLeaveLogsOut = require(InExperienceSideSheetParent.SharedFlags).FFlagPioneerLeaveLogsOut
local FFlagPioneerLogoutButtonLabel = require(InExperienceSideSheet.Flags).FFlagPioneerLogoutButtonLabel

return {
    getPioneerLeaveButtonKey = function(bool1: boolean)
        if bool1 and not FFlagPioneerLeaveLogsOut then
            return Constants.LocalizationKeys.QuitButton
        end

        if FFlagPioneerLogoutButtonLabel and bool1 and FFlagPioneerLeaveLogsOut then
            return Constants.LocalizationKeys.LogoutButton
        end

        return "CoreScripts.InGameMenu.LeaveGame"
    end,
    getPioneerLeaveConfirmationKey = function(bool1: boolean)
        if bool1 and not FFlagPioneerLeaveLogsOut then
            return Constants.LocalizationKeys.QuitConfirmation
        end

        if FFlagPioneerLogoutButtonLabel and bool1 and FFlagPioneerLeaveLogsOut then
            return Constants.LocalizationKeys.LogoutConfirmation
        end

        return "CoreScripts.InGameMenu.Prompt.ConfirmLeaveGame"
    end
}
