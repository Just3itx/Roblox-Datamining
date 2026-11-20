-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:41:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ReactSceneUnderstanding = script:FindFirstAncestor("ReactSceneUnderstanding")

local UserInputService = game:GetService("UserInputService")

local ReactUtils = require(ReactSceneUnderstanding.Parent.ReactUtils)
local React = require(ReactSceneUnderstanding.Parent.React)
local enums = require(ReactSceneUnderstanding.enums)
local useCurrentCamera = require(ReactSceneUnderstanding.useCurrentCamera)

local useCallback = React.useCallback
local useEffect = React.useEffect
local useRef = React.useRef
local useState = React.useState
local useEventConnection = ReactUtils.useEventConnection

local function useCameraState(arg1)
    local var1 = useCurrentCamera()
    local var2, var3 = useState(enums.CameraState.Idle)
    local var4 = useRef(nil)

    local var5 = arg1 or var1

    local var6 = useCallback(function()
        var3(function(moving)
            return if moving == enums.CameraState.Moving then moving else enums.CameraState.Moving
        end)

        if var4.current then
            task.cancel(var4.current)
        end

        var4.current = task.delay(0.2, function()
            var3(enums.CameraState.Idle)
        end)
    end, {})

    useEventConnection(UserInputService.InputChanged, function(arg2)
        if arg2.UserInputType == Enum.UserInputType.MouseWheel then
            var6()
        end
    end, { var6 })

    useEffect(function()
        local connection = var5:GetPropertyChangedSignal("CFrame"):Connect(var6)

        return function()
            connection:Disconnect()
        end
    end, { var5, var6 })

    return var2
end

return useCameraState
