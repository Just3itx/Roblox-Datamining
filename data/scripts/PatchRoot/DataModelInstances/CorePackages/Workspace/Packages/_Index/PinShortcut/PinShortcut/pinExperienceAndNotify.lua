-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T09:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local showPinExperienceResult = require(script.Parent.showPinExperienceResult)

local function pinExperienceAndNotify(arg1, arg2, str1: string, func1: (...any) -> (...any), arg3)
    local var1 = arg3 or game:GetService("PinShortcutService")

    local connection = nil

    connection = var1.OnPinExperienceCompleted:Connect(function(status: Enum.PinExperienceStatus, placeId: number, universeId: number, experienceName: string)
        if connection then
            connection:Disconnect()
            connection = nil
        end

        local shouldShowLuaNotificationOnPinExperienceCompleted = false
        pcall(function()
            shouldShowLuaNotificationOnPinExperienceCompleted = var1:ShouldShowLuaNotificationOnPinExperienceCompleted()
        end)
        if not shouldShowLuaNotificationOnPinExperienceCompleted then
            return
        end

        showPinExperienceResult(func1, status, experienceName, {
            onViewShortcut = var1:IsRevealPinnedExperienceAvailable() and function()
                pcall(function()
                    var1:RevealPinnedExperience(placeId)
                end)
            end or nil,
            onRetry = function()
                pinExperienceAndNotify(placeId, universeId, experienceName, func1, var1)
            end
        })
    end)

    if not pcall(function()
        var1:PinExperience(arg1, arg2, str1)
    end) and connection then
        connection:Disconnect()
        connection = nil
    end
end

return pinExperienceAndNotify
