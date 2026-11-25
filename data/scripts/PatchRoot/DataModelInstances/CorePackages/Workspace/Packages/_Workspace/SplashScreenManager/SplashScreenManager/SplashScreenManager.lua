-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:10:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SplashScreenManagerParent = script:FindFirstAncestor("SplashScreenManager").Parent

local _RunService = game:GetService("RunService")
local RunService = require(SplashScreenManagerParent.MockableProxyServices).RunService

local colorCorrectionEffect = nil
local function obfuscateEnvironment() -- Luacid: Inlined by compiler; 1 call site recovered
    colorCorrectionEffect = Instance.new("ColorCorrectionEffect")
    if colorCorrectionEffect then
        colorCorrectionEffect.Name = "__SplashScreenManager_Fader__"
        colorCorrectionEffect.Parent = game:GetService("Lighting")

        colorCorrectionEffect.TintColor = Color3.new(0, 0, 0)
        colorCorrectionEffect.Enabled = true
    end
end

local function unobfuscateEnvironment() -- Luacid: Inlined by compiler; 2 call sites recovered
    if colorCorrectionEffect then
        colorCorrectionEffect:Destroy()
        colorCorrectionEffect = nil
    end
end

local bool1 = false
local isFPSAtTarget = true
local bool3 = false
local tbl1 = {}

local function callCallbacks() -- Luacid: Inlined by compiler; 2 call sites recovered
    for _, value in tbl1 do
        value(isFPSAtTarget)
    end
end

return {
    initialize = function(num1: number, num2: number?, num3: number?)
        if bool3 or bool1 then
            return
        end

        isFPSAtTarget = false
        obfuscateEnvironment()
        callCallbacks()
        local tbl2 = {}
        local num4 = 0
        local num5 = 1 / num1
        local num6 = num3 or num1

        local startTime = tick()
        local num7 = 0

        local connection = nil
        local function func1() -- Luacid: Inlined by compiler; 1 call site recovered
            if connection then
                connection:Disconnect()
            end

            unobfuscateEnvironment()
            isFPSAtTarget = true
            bool3 = false
        end

        connection = RunService.RenderStepped:Connect(function(deltaTime: number)
            num7 = tick() - startTime

            table.insert(tbl2, deltaTime)
            num4 += deltaTime
            if #tbl2 > num6 then
                local var1 = table.remove(tbl2, 1)
                if var1 ~= nil then
                    num4 -= var1
                end
            end

            local var1 = num4 / #tbl2

            if num2 and num2 < num7 then
                isFPSAtTarget = true
                callCallbacks()
                func1()
                return
            end

            if #tbl2 >= num6 and math.floor(var1 * 100) <= math.floor(num5 * 100) then
                isFPSAtTarget = true
                callCallbacks()
                func1()
            end
        end)

        bool3 = true
    end,
    addStatusChangeListener = function<T>(arg1: T): T
        table.insert(tbl1, arg1)
        return arg1
    end,
    removeStatusChangeListener = function(arg1)
        for value, value2 in tbl1 do
            if value2 == arg1 then
                table.remove(tbl1, value)
            end
        end
    end,
    isFPSAtTarget = function()
        return isFPSAtTarget
    end,
    __setTestMode = function()
        bool1 = true
    end
}
