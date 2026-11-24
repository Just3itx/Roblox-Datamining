-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TeleportService = game:GetService("TeleportService")
local InExperienceDetailsPrompt = script:FindFirstAncestor("InExperienceDetailsPrompt")
local InExperienceDetailsPromptParent = InExperienceDetailsPrompt.Parent
local React = require(InExperienceDetailsPromptParent.React)
local InExperienceDetailsPromptContainer = require(InExperienceDetailsPrompt.Features.InExperienceDetailsPromptContainer)

local fireInExperienceDetailsPromptOpenedEvent = require(InExperienceDetailsPromptParent.DiscoveryAnalytics).Events.fireInExperienceDetailsPromptOpenedEvent
local DiscoveryEventErrorLogger = require(InExperienceDetailsPromptParent.DiscoveryUtils).DiscoveryEventErrorLogger

local FFlagLuaAppIedpOverlayAndNavigationFix = require(InExperienceDetailsPromptParent.SharedFlags).FFlagLuaAppIedpOverlayAndNavigationFix

local function InExperienceDetailsPromptApp()
    local universeId, var2 = React.useState(nil)
    local var3, var4 = React.useState(false)

    React.useEffect(function()
        local connection = TeleportService.OpenExperienceDetailsPrompt:Connect(function(universeId: number)
            var2(tostring(universeId))
            var4(true)
            fireInExperienceDetailsPromptOpenedEvent({ targetUniverseId = tostring(universeId) })
        end)

        return function()
            if connection then
                connection:Disconnect()
            end
        end
    end, {})

    if not (var3 and universeId) then
        return nil
    end

    local function closePrompt() -- Luacid: Inlined by compiler; 2 call sites recovered
        var2(nil)
        var4(false)
    end

    local tbl1 = {
        universeId = universeId,
        onJoin = function(num1: number?)
            if num1 then
                TeleportService:PromptExperienceDetailsCompleted(Enum.PromptExperienceDetailsResult.TeleportAttempted)
                TeleportService:Teleport(num1)
                closePrompt()
                return
            end

            DiscoveryEventErrorLogger.reportError(
                "InExperienceDetailsPromptAppOnJoinMissingRootPlaceId",
                "Missing valid root place id for universe id",
                { universeId = universeId }
            )
        end,
        onClose = function()
            TeleportService:PromptExperienceDetailsCompleted(Enum.PromptExperienceDetailsResult.PromptClosed)
            closePrompt()
        end
    }

    if FFlagLuaAppIedpOverlayAndNavigationFix then
        return (React.createElement(InExperienceDetailsPromptContainer, tbl1))
    end

    return (React.createElement(
        "ScreenGui",
        {
            ScreenInsets = Enum.ScreenInsets.None
        },
        {
            InExperienceDetailsPrompt = React.createElement(InExperienceDetailsPromptContainer, tbl1)
        }
    ))
end
return InExperienceDetailsPromptApp
