-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:00:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local React = require(CorePackages.Packages.React)

return function()
    local connection = nil
    local connection2 = nil
    local var1, var2 = React.useState(Vector2.new(0, 0))

    local function func1() -- Luacid: Inlined by compiler; 1 call site recovered
        local currentCamera = workspace.CurrentCamera
        if currentCamera then
            var2(Vector2.new(currentCamera.ViewportSize.X, currentCamera.ViewportSize.Y))
        end
    end

    local function func2()
        local currentCamera = workspace.CurrentCamera

        if connection2 then
            pcall(function()
                connection2:Disconnect()
            end)
            connection2 = nil
        end

        if currentCamera then
            connection2 = currentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(func1)
        end
    end

    React.useEffect(function()
        connection = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(func2)
        func2()
        func1()

        return function()
            if connection then
                connection:Disconnect()
            end
            if connection2 then
                connection2:Disconnect()
            end
        end
    end, {})

    return var1
end
