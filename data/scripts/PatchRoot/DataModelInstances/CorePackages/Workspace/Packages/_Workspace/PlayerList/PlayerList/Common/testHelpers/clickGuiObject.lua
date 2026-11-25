-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:01:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualInputManager = game:GetService("VirtualInputManager")

local function clickGuiObject(arg1)
    local screenGui = arg1:FindFirstAncestorOfClass("ScreenGui")
    local screenGui2 = screenGui or Instance.new("ScreenGui")
    local bool1 = screenGui == nil
    local var1

    if bool1 then
        screenGui2.Parent = game:GetService("CoreGui")
        var1 = arg1

        while arg1.Parent ~= nil and arg1.Parent.Parent ~= game do
            arg1 = arg1.Parent
        end

        arg1.Parent = screenGui2
    else
        var1 = arg1
        arg1 = nil
    end

    VirtualInputManager:WaitForInputEventsProcessed()
    local absolutePosition = var1.AbsolutePosition
    local absoluteSize = var1.AbsoluteSize
    local x = absolutePosition.X + absoluteSize.X / 2
    local y = absolutePosition.Y + absoluteSize.Y / 2

    local bool2 = false
    local connection = var1.Activated:Connect(function()
        bool2 = true
    end)

    VirtualInputManager:SendMouseButtonEvent(x, y, 0, true, nil, 1)
    VirtualInputManager:SendMouseButtonEvent(x, y, 0, false, nil, 1)
    VirtualInputManager:WaitForInputEventsProcessed()

    if not bool2 then
        VirtualInputManager:SendTouchEvent(1, 0, x, y)
        VirtualInputManager:SendTouchEvent(1, 2, x, y)
        VirtualInputManager:WaitForInputEventsProcessed()
    end

    connection:Disconnect()

    if not bool1 then
        return
    end

    if arg1 then
        arg1.Parent = nil
    end
    screenGui2:Destroy()
end

return clickGuiObject
