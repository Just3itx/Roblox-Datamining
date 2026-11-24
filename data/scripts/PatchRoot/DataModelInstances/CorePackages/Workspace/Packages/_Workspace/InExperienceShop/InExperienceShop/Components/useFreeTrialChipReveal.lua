-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:11:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local React = require(InExperienceShopParent.React)

local FFlagFreeTrialChipBuyAnimation = require(InExperienceShop.Flags.FFlagFreeTrialChipBuyAnimation)

game:DefineFastInt("FreeTrialChipRevealDurationMs", 300)

local function easeOut(num1: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    return TweenService:GetValue(math.clamp(num1, 0, 1), Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
end

local function useFreeTrialChipReveal(bool1: boolean, current: string?)
    local revealLayer, var2 = React.useState(nil)
    local var3, var4 = React.useState(nil)
    local var5 = React.useRef(nil)
    var5.current = var3

    local revealSizeIsOwnRef = React.useRef(true)
    local var7 = React.useRef(nil)

    local sampleOnSettleRef = React.useRef(false)
    local isSettled, var10 = React.useState(false)
    local slotRef = React.useRef(nil)
    local placeholderRef = React.useRef(nil)
    local revealRef = React.useRef(nil)

    React.useEffect(function()
        if not bool1 then
            var7.current = nil
            sampleOnSettleRef.current = false
            revealSizeIsOwnRef.current = true
            var2(nil)
            var4(nil)
            var10(false)
            return
        end

        local current = slotRef.current
        local var14 = if current == nil then nil else current:FindFirstAncestorWhichIsA("LayerCollector")

        if var14 == nil or game:GetFastInt("FreeTrialChipRevealDurationMs") <= 0 then
            var10(true)
            return
        end
        var2(var14)
    end, {
        bool1,
        var2,
        var4,
        var10
    })

    React.useEffect(function()
        local current = revealRef.current
        if isSettled or revealLayer == nil or current == nil then
            return
        end

        local function publishRevealChipSize(vector2: Vector2)
            if var5.current ~= nil and (vector2.X <= 0 or vector2.Y <= 0) then
                return
            end
            local current2 = var7.current

            if current2 ~= nil and vector2.X == current2.X and vector2.Y == current2.Y then
                return
            end
            if current2 ~= nil then
                var7.current = nil
                sampleOnSettleRef.current = false
                revealSizeIsOwnRef.current = true
            end
            var5.current = vector2
            var4(vector2)
        end

        publishRevealChipSize(current.AbsoluteSize)
        local connection = current:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
            publishRevealChipSize(current.AbsoluteSize)
        end)
        return function()
            connection:Disconnect()
        end
    end, { isSettled, revealLayer, var4 })

    local bool2 = var3 ~= nil
    React.useEffect(function()
        local current = revealRef.current
        local current2 = placeholderRef.current
        if isSettled or not bool2 or revealLayer == nil or current == nil or current2 == nil then
            return
        end

        local var14 = revealLayer
        local function getRestPosition() -- Luacid: Inlined by compiler; 2 call sites recovered
            return current2.AbsolutePosition - var14.AbsolutePosition
        end

        local fastInt = game:GetFastInt("FreeTrialChipRevealDurationMs")

        local absoluteSizeX = var14.AbsoluteSize.X
        current.Position = UDim2.fromOffset(absoluteSizeX, getRestPosition().Y)

        local num1 = 0
        local connection = nil
        connection = RunService.Heartbeat:Connect(function(deltaTime: number)
            num1 += deltaTime * 1000
            local restPosition = getRestPosition()
            local num2 = if fastInt > 0 then easeOut(num1 / fastInt) else 1
            current.Position = UDim2.fromOffset(absoluteSizeX + (restPosition.X - absoluteSizeX) * num2, restPosition.Y)

            if not (fastInt <= num1) then
                return
            end

            if connection ~= nil then
                connection:Disconnect()
            end
            var7.current = nil
            revealSizeIsOwnRef.current = true
            var10(true)
        end)

        return function()
            if connection ~= nil then
                connection:Disconnect()
            end
        end
    end, {
        isSettled,
        bool2,
        revealLayer,
        var10
    })

    if FFlagFreeTrialChipBuyAnimation then
        local var14 = React.useRef(nil)
        React.useLayoutEffect(function()
            if current == nil or not bool1 then
                var14.current = nil
                return
            end

            local current3 = var14.current
            var14.current = current
            if current3 == nil or current3 == current then
                return
            end

            local current2 = slotRef.current
            local var15 = if current2 == nil then nil else current2:FindFirstAncestorWhichIsA("LayerCollector")

            if var15 == nil or game:GetFastInt("FreeTrialChipRevealDurationMs") <= 0 then
                return
            end
            var7.current = var5.current
            sampleOnSettleRef.current = true
            revealSizeIsOwnRef.current = false
            var2(var15)
            var10(false)
        end, {
            bool1,
            current,
            var2,
            var10
        })
    end
    return {
        isSettled = isSettled,
        revealLayer = revealLayer,
        revealChipSize = var3,
        revealSizeIsOwnRef = revealSizeIsOwnRef,
        sampleOnSettleRef = sampleOnSettleRef,
        slotRef = slotRef,
        placeholderRef = placeholderRef,
        revealRef = revealRef
    }
end

return useFreeTrialChipReveal
