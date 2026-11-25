-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local Foundation = require(ProfilePlatformParent.Foundation)
local SharedFlags = require(ProfilePlatformParent.SharedFlags)
local FFlagFriendsCallingClientGate_DEV = SharedFlags.FFlagFriendsCallingClientGate_DEV
local FFlagFriendsCallingServiceLuaMigration = SharedFlags.FFlagFriendsCallingServiceLuaMigration
local var1 = require(ProfilePlatformParent.Loggers).Logger:new(script.Name)

local ButtonVariant = Foundation.Enums.ButtonVariant

local Enums = require(ProfilePlatform.Common.Enums)
local _Types = require(ProfilePlatform.Components.CTARow.Types)
local EventNames = require(ProfilePlatform.Analytics.EventNames)
local ProfileTypes = Enums.ProfileTypes

return {
    [Enums.ProfileActions.Call] = FFlagFriendsCallingClientGate_DEV and function(arg1)
        local tbl1 = {
            text = "Call",
            variant = ButtonVariant.Standard,
            onActivated = 0
        }
        local onActivated = {}
        onActivated[ProfileTypes.User] = function()
            if arg1.buttonSurface == Enums.ButtonSurface.ContextualMenu then
                arg1.analytics.fireAnalyticsEvent(EventNames.ContextualMenuButtonCall, { buttonSurface = arg1.buttonSurface })
            else
                arg1.analytics.fireAnalyticsEvent(EventNames.CTAButtonCall, { buttonSurface = arg1.buttonSurface })
            end

            if not FFlagFriendsCallingServiceLuaMigration then
                task.spawn(function()
                    pcall(function()
                        local var2 = arg1.callingService or game:GetService("CallingService")
                        local tbl3 = { tonumber(arg1.profileId) }
                        var2:CreateCallAsync(tbl3, "")
                    end)
                end)

                return
            end

            local var2 = arg1.friendsCallingService or game:GetService("FriendsCallingService")
            local success, result = pcall(function()
                local var3 = var2
                local tbl3 = {
                    participantIds = { tonumber(arg1.profileId) }
                }
                var3:StartCall(tbl3)
            end)

            if not success then
                var1:debug("FriendsCallingService:StartCall failed: {}", result)
            end
        end

        tbl1.onActivated = onActivated
        return tbl1
    end or nil
}
