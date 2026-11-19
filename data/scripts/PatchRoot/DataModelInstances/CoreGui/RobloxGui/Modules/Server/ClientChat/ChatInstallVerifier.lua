-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:30:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local StarterPlayer = game:GetService("StarterPlayer")

local function waitForChildOfClass(arg1, className: string)
    local child = arg1:FindFirstChildOfClass(className)
    while not child or child.ClassName ~= className do
        child = arg1.ChildAdded:Wait()
    end
    return child
end

local child = waitForChildOfClass(Players.LocalPlayer, "PlayerScripts")
local child2 = waitForChildOfClass(StarterPlayer, "StarterPlayerScripts")

function VerifyScriptExistence()
    local scriptToVerifyValue = script:WaitForChild("ScriptToVerify").Value
    if child:FindFirstChild(scriptToVerifyValue) then
        return
    end

    local var1 = child2:FindFirstChild(scriptToVerifyValue)
    if var1 then
        local archivable = var1.Archivable
        var1.Archivable = true
        var1:Clone().Parent = child
        var1.Archivable = archivable
    end
end

VerifyScriptExistence()
script:Destroy()
