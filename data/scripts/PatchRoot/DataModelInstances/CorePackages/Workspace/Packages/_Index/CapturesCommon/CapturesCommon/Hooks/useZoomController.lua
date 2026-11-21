-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:10:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local UserInputService = game:GetService("UserInputService")

local React = require(scriptParentParentParent.React)
local ReactOtter = require(scriptParentParentParent.ReactOtter)
local ReactUtils = require(scriptParentParentParent.ReactUtils)

local isPointWithinBounds = require(scriptParentParent.Utils.isPointWithinBounds)

local useMotor = ReactOtter.useMotor
local useCallback = React.useCallback
local useEffect = React.useEffect
local useEventConnection = ReactUtils.useEventConnection
local useRef = React.useRef
local useState = React.useState

local tbl1 = { dampingRatio = 1, frequency = 4 }

local function useZoomController(bool1: boolean)
    local var1, var2 = useState(false)

    local var3 = useRef(nil)
    local var4 = useRef(nil)
    local var5 = useRef(nil)

    local var6 = useCallback(function(arg1)
        if not var3.current then
            return
        end

        var3.current.AnchorPoint = Vector2.new(arg1.xAnchor, arg1.yAnchor)
        var3.current.Position = UDim2.fromScale(arg1.xPos, arg1.yPos)
        var3.current.Size = UDim2.fromScale(arg1.scale, arg1.scale)
    end, {})

    local var7 = useMotor({ scale = 1, xAnchor = 0.5, yAnchor = 0.5, xPos = 0.5, yPos = 0.5 }, var6)

    useEffect(function()
        if not var3.current then
            return
        end

        if bool1 then
            var4.current = var3.current.AbsolutePosition
            var5.current = var3.current.AbsoluteSize
            return
        end
        var4.current = nil
        var5.current = nil

        var3.current.AnchorPoint = Vector2.new(0.5, 0.5)
        var3.current.Position = UDim2.fromScale(0.5, 0.5)
        var3.current.Size = UDim2.fromScale(1, 1)
    end, { bool1 })

    local var8 = useCallback(function(tbl2, arg1, _, userInputState, _)
        if not (bool1 and var3.current) then
            return
        end

        if userInputState == Enum.UserInputState.End and var1 or #tbl2 < 2 then
            var7({
                scale = ReactOtter.spring(1, tbl1),
                xPos = ReactOtter.spring(var3.current.AnchorPoint.X, tbl1),
                yPos = ReactOtter.spring(var3.current.AnchorPoint.Y, tbl1)
            })

            var4.current = nil
            var5.current = nil

            var2(false)
            return
        end

        if userInputState == Enum.UserInputState.Begin then
            local var8 = tbl2[1]
            local var9 = tbl2[2]
            local absolutePosition = var3.current.AbsolutePosition
            local absoluteSize = var3.current.AbsoluteSize

            if not (isPointWithinBounds(var8, absolutePosition, absoluteSize) and isPointWithinBounds(var9, absolutePosition, absoluteSize)) then
                return
            end

            var4.current = absolutePosition
            var5.current = absoluteSize

            local var10 = absolutePosition + absoluteSize / 2
            local var11 = (var8 + var9) / 2 - var10
            local var12 = var11.X / absoluteSize.X + 0.5
            local var13 = var11.Y / absoluteSize.Y + 0.5

            var7({
                xAnchor = ReactOtter.instant(var12),
                yAnchor = ReactOtter.instant(var13),
                xPos = ReactOtter.instant(var12),
                yPos = ReactOtter.instant(var13)
            })
            var2(true)
        end

        if not var1 or not var4.current or not var5.current then
            return
        end

        local num1 = math.clamp(arg1, 0.5, 3)
        local var8 = var4.current + var5.current / 2
        local var9 = (tbl2[1] + tbl2[2]) / 2 - var8
        local var10 = var9.X / var5.current.X + 0.5
        local var11 = var9.Y / var5.current.Y + 0.5

        var7({ scale = ReactOtter.instant(num1), xPos = ReactOtter.instant(var10), yPos = ReactOtter.instant(var11) })
    end, { bool1, var1, var7 })

    useEventConnection(UserInputService.TouchPinch, var8)

    return var1, var3
end

return useZoomController
