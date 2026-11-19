-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarEditorService = game:GetService("AvatarEditorService")
local Players = game:GetService("Players")

local scriptParentParent = script.Parent.Parent

local CloseMenu = require(scriptParentParent.Thunks.CloseMenu)
local SetRespawning = require(scriptParentParent.Actions.SetRespawning)
local SendAnalytics = require(scriptParentParent.Utility.SendAnalytics)
local Constants = require(scriptParentParent.Resources.Constants)

return function(arg1)
    local state = arg1:getState()
    if state.respawn.enabled then
        AvatarEditorService:BustAvatarFetchCache()

        if state.respawn.customCallback then
            state.respawn.customCallback:Fire()
        else
            local character = Players.LocalPlayer.Character
            if character ~= nil then
                local humanoid = character:FindFirstChild("Humanoid")
                if humanoid ~= nil and humanoid:IsA("Humanoid") then
                    humanoid.Health = 0
                end
            end
        end
    end

    arg1:dispatch(SetRespawning(false))
    arg1:dispatch(CloseMenu)
    SendAnalytics(
        Constants.AnalyticsInGameMenuName,
        Constants.AnalyticsRespawnCharacterName,
        {
            confirmed = Constants.AnalyticsConfirmedName
        }
    )
end
