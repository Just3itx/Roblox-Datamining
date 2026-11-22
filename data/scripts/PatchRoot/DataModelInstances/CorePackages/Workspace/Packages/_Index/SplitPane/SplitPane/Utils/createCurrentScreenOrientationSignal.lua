-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:31:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local SplitPaneParent = script:FindFirstAncestor("SplitPane").Parent
local Signals = require(SplitPaneParent.Signals)

local function createCurrentScreenOrientationSignal()
    local var1, var2 = Signals.createSignal(nil)
    local connection = nil
    local connection2 = nil

    local function connectToPlayerGui(playerGui: PlayerGui) -- Luacid: Inlined by compiler; 2 call sites recovered
        var2(playerGui.CurrentScreenOrientation)
        connection = playerGui:GetPropertyChangedSignal("CurrentScreenOrientation"):Connect(function()
            var2(playerGui.CurrentScreenOrientation)
        end)
    end

    local localPlayer = Players.LocalPlayer
    if localPlayer then
        local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")
        if playerGui then
            connectToPlayerGui(playerGui)
        else
            connection2 = localPlayer.ChildAdded:Connect(function(child: Instance)
                if not child:IsA("PlayerGui") then
                    return
                end

                if connection2 then
                    connection2:Disconnect()
                end
                connection2 = nil
                connectToPlayerGui(child)
            end)
        end
    end

    return var1, function()
        if connection then
            connection:Disconnect()
        end
        if connection2 then
            connection2:Disconnect()
        end
    end
end

return createCurrentScreenOrientationSignal
