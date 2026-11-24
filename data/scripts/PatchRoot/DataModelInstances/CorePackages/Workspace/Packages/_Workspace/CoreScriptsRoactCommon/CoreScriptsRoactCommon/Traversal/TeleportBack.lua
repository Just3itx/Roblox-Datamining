-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:31:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TeleportService = game:GetService("TeleportService")

local engineFeature = game:GetEngineFeature("UseTeleportedPlacesBackHistory2")

local CoreScriptsRoactCommonParent = script:FindFirstAncestor("CoreScriptsRoactCommon").Parent

local isRunningInStudio = require(CoreScriptsRoactCommonParent.AppCommonLib).isRunningInStudio

local FFlagUseLocalTraversalHistory = require(script.Parent.Flags).FFlagUseLocalTraversalHistory
local num1 = game:DefineFastInt("TeleportBackAttemptLimit", 5)
local num2 = game:DefineFastInt("TeleportBackRetryDelay", 1)

local function TeleportBack(placeId: number?)
    if isRunningInStudio() then
        warn("Teleporting is not supported in Studio")
        return
    end

    local num3 = 0
    local success, result

    repeat
        success, result = pcall(function()
            if (FFlagUseLocalTraversalHistory or engineFeature) and placeId then
                return TeleportService:TeleportTrustedBackHistory(placeId)
            end
            return TeleportService:TeleportTrustedBackForth(false)
        end)

        num3 += 1
        if not success then
            task.wait(num2)
        end
    until success or num3 == num1

    if not success then
        warn(result)
    end

    return success, result
end

return TeleportBack
