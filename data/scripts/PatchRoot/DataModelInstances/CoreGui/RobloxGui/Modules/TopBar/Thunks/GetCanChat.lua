-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:11:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local Chat = game:GetService("Chat")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

local scriptParentParent = script.Parent.Parent
local SetCanChat = require(scriptParentParent.Actions.SetCanChat)

if require(scriptParentParent.Flags.FFlagTopBarDeprecateChatRodux) then
    return nil
end

local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local ChatSelector = require(RobloxGui.Modules.ChatSelector)

local LocalPlayer = Players.LocalPlayer
while not LocalPlayer do
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
    LocalPlayer = Players.LocalPlayer
end

return function(arg1)
    coroutine.wrap(function()
        local var1

        if RunService:IsStudio() then
            var1 = true
        else
            local success, result = pcall(function(): boolean
                return Chat:CanUserChatAsync(LocalPlayer.UserId)
            end)

            var1 = success and result
        end

        arg1:dispatch(SetCanChat(var1))
        if not var1 then
            ChatSelector:SetVisible(false)
        end
    end)()
end
