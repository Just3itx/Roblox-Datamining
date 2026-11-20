-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:01:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")

local _Types = require(script.Parent.Parent.Parent.Types)

local function defaultClipLength(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    local num1 = 0
    for _, value in tbl1 do
        if num1 < value.Length then
            num1 = value.Length
        end
    end
    return num1
end

local function wrapAction(func1: (...any) -> (...any), callback: ((...any) -> (...any))?) -- Luacid: Inlined by compiler; 3 call sites recovered
    return if callback == nil then func1 else function()
        callback(func1)
    end
end

local function wrapSeek(func1: (...any) -> (...any), callback: ((...any) -> (...any))?): (number) -> () | (...any) -> (...any) -- Luacid: Inlined by compiler; 1 call site recovered
    return if callback == nil then func1 else function(num1: number)
        callback(func1, num1)
    end
end

local function wrapBool(func1: (...any) -> (...any), getIsPlaying: ((...any) -> (...any))?) -- Luacid: Inlined by compiler; 1 call site recovered
    return if getIsPlaying == nil then func1 else function()
        return getIsPlaying(func1)
    end
end

local function wrapNumber(func1: (...any) -> (...any), getPosition: ((...any) -> (...any))?) -- Luacid: Inlined by compiler; 1 call site recovered
    return if getPosition == nil then func1 else function()
        return getPosition(func1)
    end
end

local function createPlayhead(tbl1)
    local root = tbl1.root
    local var1 = tbl1.tracks or {}

    local var2 = tbl1.getClipLength or function()
        return defaultClipLength(var1)
    end
    local getDuration = tbl1.getDuration or var2
    local syncVisuals = tbl1.syncVisuals
    local animator = tbl1.animator
    local var4 = tbl1.canPlay or function(): boolean
        return getDuration() > 0
    end

    local num1 = 0
    local bool1 = false
    local bool2 = false
    local connection = nil

    local function stopClock() -- Luacid: Inlined by compiler; 2 call sites recovered
        if connection ~= nil then
            connection:Disconnect()
            connection = nil
        end
    end

    local function poseRig() -- Luacid: Inlined by compiler; 2 call sites recovered
        if animator ~= nil and not RunService:IsRunning() then
            animator:StepAnimations(0)
        end
    end

    local function applyPlayhead(num2: number)
        local var5 = getDuration()
        local var6 = var2()
        if var5 <= 0 then
            num1 = 0
            poseRig()

            if syncVisuals ~= nil then
                syncVisuals(num1)
            end
            return
        end
        num1 = math.clamp(num2, 0, var5)
        if var6 > 0 then
            for _, value in var1 do
                value.TimePosition = num1 % var6
            end
        end

        poseRig()

        if syncVisuals ~= nil then
            syncVisuals(num1)
        end
    end

    local function startClock() -- Luacid: Inlined by compiler; 1 call site recovered
        if connection ~= nil or bool2 then
            return
        end
        connection = RunService.Heartbeat:Connect(function(deltaTime: number)
            if bool2 or not bool1 then
                return
            end
            local var5 = getDuration()
            if var5 <= 0 then
                return
            end
            applyPlayhead((num1 + deltaTime) % var5)
        end)
    end

    local function func1()
        if bool2 then
            return
        end

        if not var4() then
            bool1 = false
            return
        end

        if syncVisuals ~= nil then
            syncVisuals(num1)
        end
        for _, value in var1 do
            value:AdjustSpeed(1)
            if not value.IsPlaying then
                value:Play(0)
            end
        end
        applyPlayhead(num1)
        bool1 = true
        startClock()
    end

    local function func2()
        if bool2 then
            return
        end

        stopClock()

        for _, value in var1 do
            value:AdjustSpeed(0)
        end
        bool1 = false
    end

    local function func3(num2: number)
        if bool2 then
            return
        end
        applyPlayhead(num2)
    end

    local function func4()
        if bool2 then
            return
        end
        bool2 = true
        bool1 = false
        stopClock()

        for _, value in var1 do
            value:AdjustSpeed(0)
            value:Stop(0)
        end
        table.clear(var1)
        root:Destroy()
    end

    applyPlayhead(0)

    return {
        play = wrapAction(func1, tbl1.play),
        pause = wrapAction(func2, tbl1.pause),
        seek = wrapSeek(func3, tbl1.seek),
        dispose = wrapAction(func4, tbl1.dispose),
        getIsPlaying = wrapBool(function()
            return bool1
        end, tbl1.getIsPlaying),
        getPosition = wrapNumber(function()
            return num1
        end, tbl1.getPosition),
        getDuration = getDuration
    }
end

return createPlayhead
