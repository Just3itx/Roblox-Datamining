-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:41:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ReactSceneUnderstanding = script:FindFirstAncestor("ReactSceneUnderstanding")

local React = require(ReactSceneUnderstanding.Parent.React)

local useState = React.useState
local useCallback = React.useCallback
local useEffect = React.useEffect

local camera = Instance.new("Camera")

local function useCurrentCamera()
    local var1, var2 = useState(nil)

    local var3 = useCallback(function()
        local currentCamera = workspace.CurrentCamera
        if currentCamera and currentCamera ~= var1 then
            var2(currentCamera)
        end
    end, { var1 })

    useEffect(function()
        local connection = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(var3)

        return function()
            connection:Disconnect()
        end
    end, { var3 })

    useEffect(var3, {})

    return var1 or camera
end

return useCurrentCamera
