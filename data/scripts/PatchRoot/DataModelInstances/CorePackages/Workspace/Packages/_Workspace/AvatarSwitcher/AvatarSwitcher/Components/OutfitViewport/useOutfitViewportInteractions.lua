-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:31:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local AvatarSwitcherParent = script:FindFirstAncestor("AvatarSwitcher").Parent

local React = require(AvatarSwitcherParent.React)
local ReactOtter = require(AvatarSwitcherParent.ReactOtter)

local function swipeDistanceToRotationAngle(vec1: vector) -- Luacid: Inlined by compiler; 2 call sites recovered
    return -vec1.X * 1
end

local function useOutfitViewportInteractions(tbl1)
    local var1 = React.useRef(false)
    local var2 = React.useRef(Vector3.new())
    local var3, var4 = ReactOtter.useAnimatedBinding(0)
    local var5 = React.useRef(0)
    local var6 = React.useRef(0)
    local var7 = React.useRef(nil)
    local cameraCFrame, var9 = React.useBinding(CFrame.new())

    React.useEffect(function()
        local num1 = 0
        local name = "OutfitVewportSpin_" .. HttpService:GenerateGUID(false)
        local current = var7.current

        RunService:BindToRenderStep(name, Enum.RenderPriority.Camera.Value + 1, function(num2: number)
            if var1.current then
                local var10 = if var7.current and current then (var7.current - current) / num2 else Vector2.new(0, 0)
                var4(ReactOtter.instant(-var10.X * 1))
            else
                num1 += num2 * var3:getValue()
            end
            current = var7.current

            local ry = math.rad(num1) + math.rad(var5.current) + math.rad(var6.current)
            local cFrame = CFrame.Angles(0, ry, 0)
            local current2 = tbl1.defaultCameraDistanceRef.current

            var9(CFrame.lookAt(cFrame.LookVector * current2, Vector3.new(0, 0, 0), cFrame.UpVector))
        end)

        return function()
            RunService:UnbindFromRenderStep(name)
        end
    end, { var4, tbl1.defaultCameraDistanceRef, var9 })

    local var10 = React.useCallback(function(vec1: vector)
        local var10 = var5
        var10.current += swipeDistanceToRotationAngle(vec1 - var2.current)
        var1.current = false
        var7.current = nil
        var6.current = 0
        if tbl1.onInteractionChanged then
            tbl1.onInteractionChanged(false)
        end

        var4((ReactOtter.spring(0, { frequency = 1 })))
    end, { tbl1.onInteractionChanged, var4 })

    return {
        onInputBegan = React.useCallback(function(_, arg1)
            if arg1.UserInputType ~= Enum.UserInputType.MouseButton1 and arg1.UserInputType ~= Enum.UserInputType.Touch
                or var1.current
            then
                return
            end
            var1.current = true
            var2.current = arg1.Position
            var7.current = arg1.Position
            if tbl1.onInteractionChanged then
                tbl1.onInteractionChanged(true)
            end
        end, { tbl1.onInteractionChanged }),
        onInputChanged = React.useCallback(function(arg1)
            local bool1 = arg1.UserInputType == Enum.UserInputType.MouseMovement or arg1.UserInputType == Enum.UserInputType.Touch
            if var1.current and bool1 then
                var6.current = swipeDistanceToRotationAngle(arg1.Position - var2.current)
                var7.current = arg1.Position
            end
        end, {}),
        onInputEnded = React.useCallback(function(arg1)
            if (arg1.UserInputType == Enum.UserInputType.MouseButton1 or arg1.UserInputType == Enum.UserInputType.Touch) and var1.current then
                var10(arg1.Position)
            end
        end, { var10 }),
        cameraCFrame = cameraCFrame
    }
end

return useOutfitViewportInteractions
