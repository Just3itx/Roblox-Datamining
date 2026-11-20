-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:01:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PolicyService = game:GetService("PolicyService")
local Players = game:GetService("Players")

local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local Promise = require(scriptParentParentParent.Promise)

local Logger = require(scriptParentParent.Logger)

return function(arg1): () -> {onPolicyChanged: (any) -> RBXScriptConnection, read: () -> nil}
    arg1 = arg1 or {}
    arg1.PolicyService = arg1.PolicyService or PolicyService
    arg1.PlayersService = arg1.PlayersService or Players

    assert(arg1.PolicyService, "expected dependencies.PolicyService")
    assert(arg1.PlayersService, "expected dependencies.PlayersService")

    local PolicyService2 = arg1.PolicyService
    local playersService = arg1.PlayersService

    return function()
        return {
            read = function()
                return nil
            end,
            onPolicyChanged = function(arg2): RBXScriptConnection
                local bindableEvent = Instance.new("BindableEvent")

                local connection = bindableEvent.Event:Connect(arg2)

                Promise.new(function(callback, callback2)
                    local localPlayer = playersService.LocalPlayer
                    if not localPlayer then
                        callback2("LocalPlayer not found")

                        return
                    end

                    local success, result = pcall(function()
                        return PolicyService2:GetPolicyInfoForPlayerAsync(localPlayer)
                    end)
                    if not success then
                        callback2("GetPolicyInfoForPlayerAsync had an error when calling")
                    elseif result then
                        callback(result)
                    else
                        callback2("GetPolicyInfoForPlayerAsync return nil value")
                    end
                end):andThen(function(arg3)
                    bindableEvent:Fire(arg3)
                end):catch(function(arg3)
                    Logger:warning("Could not fetch from PolicyService due to error: {}", arg3)
                end)

                return connection
            end
        }
    end
end
