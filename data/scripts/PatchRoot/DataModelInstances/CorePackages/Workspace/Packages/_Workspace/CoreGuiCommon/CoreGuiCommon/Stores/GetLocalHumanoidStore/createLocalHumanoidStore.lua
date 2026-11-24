-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:00:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local CoreGuiCommonParent = script:FindFirstAncestor("CoreGuiCommon").Parent
local Signals = require(CoreGuiCommonParent.Signals)
local Cryo = require(CoreGuiCommonParent.Cryo)
local createSignal = Signals.createSignal

return function()
    local getLocalHumanoid, var2 = createSignal(nil)

    local getHealthValue, var4 = createSignal({}, Cryo.Dictionary.equals)

    local connection = nil
    local connection2 = nil
    local connection3 = nil

    local localPlayer = Players.LocalPlayer
    while not localPlayer do
        Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
        localPlayer = Players.LocalPlayer
    end

    local function updateHealthValue()
        local var5 = getLocalHumanoid(false)
        var4(var5 and { health = var5.Health, maxHealth = var5.MaxHealth, isDead = var5.Health <= 0 } or {})
    end

    local function unobserveHumanoid() -- Luacid: Inlined by compiler; 2 call sites recovered
        if connection3 then
            connection3:Disconnect()
            connection3 = nil
        end
        if connection then
            connection:Disconnect()
            connection = nil
        end
        if connection2 then
            connection2:Disconnect()
            connection2 = nil
        end

        var2(nil)
    end

    local function observeHumanoid()
        unobserveHumanoid()
        local character = localPlayer.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                var2(humanoid)
                connection = humanoid.HealthChanged:Connect(updateHealthValue)
                connection2 = humanoid.Died:Connect(updateHealthValue)
            else
                connection3 = character.ChildAdded:Connect(function(child: Instance)
                    if child:IsA("Humanoid") then
                        observeHumanoid()
                    end
                end)
            end
        end
        updateHealthValue()
    end

    local connection4 = localPlayer.CharacterAdded:Connect(observeHumanoid)
    local connection5 = localPlayer.CharacterRemoving:Connect(observeHumanoid)
    observeHumanoid()

    return {
        getLocalHumanoid = getLocalHumanoid,
        getHealthValue = getHealthValue,
        cleanup = function()
            connection4:Disconnect()
            connection5:Disconnect()
            unobserveHumanoid()
        end
    }
end
