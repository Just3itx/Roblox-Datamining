-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:11:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(callback: (...any) -> (...any))
    local currentVector2 = nil

    local connection = nil

    local function fireCallback(vector2: Vector2) -- Luacid: Inlined by compiler; 3 call sites recovered
        if vector2 ~= currentVector2 then
            currentVector2 = vector2
            callback(vector2)
        end
    end

    local function onViewportSizeChanged() -- Luacid: Inlined by compiler; 2 call sites recovered
        local currentCamera = workspace.CurrentCamera
        if currentCamera then
            fireCallback(currentCamera.ViewportSize)
        end
    end

    local function onCurrentCameraChanged() -- Luacid: Inlined by compiler; 1 call site recovered
        if connection then
            connection:Disconnect()
            connection = nil
        end

        local currentCamera = workspace.CurrentCamera
        if currentCamera then
            connection = currentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(onViewportSizeChanged)
            onViewportSizeChanged()
        end
    end

    local connection2 = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(onCurrentCameraChanged)
    onCurrentCameraChanged()

    return function()
        if connection2 then
            connection2:Disconnect()
            connection2 = nil
        end

        if connection then
            connection:Disconnect()
            connection = nil
        end
    end
end
