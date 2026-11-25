-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local SharedFlags = require(ProfilePlatformParent.SharedFlags)
local Enums = require(ProfilePlatformParent.CurrencyTransfers).Enums
local TransferDirection = Enums.TransferDirection
local TransferOrigination = Enums.TransferOrigination

local Enums2 = require(ProfilePlatform.Common.Enums)
local _Types = require(ProfilePlatform.Components.CTARow.Types)
local EventNames = require(ProfilePlatform.Analytics.EventNames)
local ProfileTypes = Enums2.ProfileTypes

local FFlagProfilePlatformEnableCurrencyTransfer = SharedFlags.FFlagProfilePlatformEnableCurrencyTransfer

return {
    [Enums2.ProfileActions.CurrencyTransfer] = FFlagProfilePlatformEnableCurrencyTransfer and function(arg1)
        local tbl1 = {
            text = arg1.localized[Enums2.ProfileActions.CurrencyTransfer],
            onActivated = 0
        }
        local onActivated = {}
        onActivated[ProfileTypes.User] = function()
            if arg1.buttonSurface == Enums2.ButtonSurface.ContextualMenu then
                arg1.analytics.fireAnalyticsEvent(
                    EventNames.ContextualMenuButtonCurrencyTransfer,
                    {
                        buttonSurface = arg1.buttonSurface
                    }
                )
            else
                arg1.analytics.fireAnalyticsEvent(EventNames.CTAButtonCurrencyTransfer, { buttonSurface = arg1.buttonSurface })
            end

            local navigateToTransfer = arg1.navigateTo and arg1.navigateTo.navigateToTransfer
            if not navigateToTransfer then
                return
            end

            navigateToTransfer({
                recipientUserId = arg1.profileId,
                direction = TransferDirection.Send,
                transferOrigination = TransferOrigination.Profile
            })
        end

        tbl1.onActivated = onActivated
        return tbl1
    end or nil
}
