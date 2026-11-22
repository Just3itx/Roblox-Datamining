-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:20:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local React = require(MomentsParent.React)
local _MomentsCommon = require(MomentsParent.MomentsCommon)

local sampleWindow = require(script.Parent.sampleWindow)

local RunService = game:GetService("RunService")
local VideoService = game:GetService("VideoService")

local defaultConfig = sampleWindow.defaultConfig

local function useVideoScrubPreview(bool1: boolean, bool2: boolean, func1: (...any) -> (...any))
    local contentA, var2 = React.useBinding(nil)
    local contentB, var4 = React.useBinding(nil)
    local frontIsA, var6 = React.useBinding(true)
    local imageARef = React.useRef(nil)
    local imageBRef = React.useRef(nil)
    local isLoading, var10 = React.useState(true)

    local var11 = React.useRef(nil)
    local var12 = React.useRef(false)
    local var13 = React.useRef(0)
    local var14 = React.useRef(false)
    local var15 = React.useRef(false)
    local var16 = React.useRef(0)
    local var17 = React.useRef(nil)
    local var18 = React.useRef(false)
    local var19 = React.useRef(0)
    local var20 = React.useRef({})

    local var21 = React.useRef(nil)
    if var21.current == nil then
        var21.current = {
            byTime = {},
            set = {},
            times = {}
        }
    end

    local current = var21.current

    local function rebuildCache()
        local set = ({})
        local times = {}
        for value in current.byTime do
            set[value] = true
            table.insert(times, value)
        end
        table.sort(times)
        current.set = set
        current.times = times
    end

    local function getRange()
        if bool1 == nil or bool1.region == nil then
            return {
                min = 0,
                max = var13.current
            }
        end

        return {
            min = bool1.region.startTime,
            max = bool1.region.endTime
        }
    end

    local function ensureSampler() -- Luacid: Inlined by compiler; 1 call site recovered
        if var11.current ~= nil or var12.current or bool1 == nil then
            return
        end
        var12.current = true
        local current2 = var16.current
        local content = bool1.content
        task.spawn(function()
            local success, result = pcall(function(): VideoSampler
                return VideoService:CreateVideoSamplerAsync(content, { Size = Enum.VideoSampleSize.Small })
            end)
            if current2 ~= var16.current then
                return
            end
            var12.current = false
            if not success then
                warn(`[moments] scrub preview sampler failed: {tostring(result)}`)
                return
            end
            var11.current = result
            var13.current = result.TimeLength or 0
        end)
    end

    local function runFetch(fetch) -- Luacid: Inlined by compiler; 1 call site recovered
        var14.current = true
        local current2 = var16.current
        task.spawn(function()
            local current3 = var11.current
            local success, result = pcall(function()
                return current3:GetSamplesAtTimesAsync(fetch)
            end)
            if current2 ~= var16.current then
                return
            end
            var14.current = false
            if not success then
                return
            end
            for value, value2 in fetch do
                local var22 = result[value]
                if var22 ~= nil and var22.Image ~= nil then
                    current.byTime[value2] = var22.Image
                end
            end
            rebuildCache()
        end)
    end

    local function tick()
        local var22 = func1()
        if var22 == nil then
            return
        end
        local range = getRange()
        if range.max <= range.min then
            return
        end

        local position = range.min + var22 * (range.max - range.min)

        local time = os.clock()
        local current2 = var20.current
        table.insert(current2, { time = time, position = position })
        while #current2 > 1 and time - current2[1].time > 0.12 do
            table.remove(current2, 1)
        end
        local var24 = sampleWindow.estimateVelocity(current2)

        local var25 = sampleWindow.planTargets(position, var24, range, defaultConfig)
        local var26 = sampleWindow.diff(var25, current.set)

        if #var26.evict > 0 then
            for _, value in var26.evict do
                current.byTime[value] = nil
            end
            rebuildCache()
        end

        if not var14.current and #var26.fetch > 0 and var11.current ~= nil then
            runFetch(var26.fetch)
        end

        if var18.current then
            local bool3 = not frontIsA:getValue()
            local current3 = if bool3 then imageARef.current else imageBRef.current
            local var27 = os.clock() - var19.current
            if current3 == nil or current3.IsLoaded or var27 >= 0.2 then
                var6(bool3)
                var18.current = false
                if not var15.current then
                    var15.current = true
                    var10(false)
                end
            end
        end

        local var27 = sampleWindow.selectFrameTime(position, current.times)
        local var1 = if var27 == nil then nil else current.byTime[var27]

        if var1 == nil or var1 == var17.current then
            return
        end

        var17.current = var1
        if not frontIsA:getValue() then
            var2(var1)
        else
            var4(var1)
        end
        var19.current = os.clock()
        var18.current = true
    end

    React.useEffect(function()
        if not bool2 or bool1 == nil then
            return
        end

        ensureSampler()
        var20.current = {}
        local connection = RunService.RenderStepped:Connect(tick)
        return function()
            connection:Disconnect()
        end
    end, { bool2, bool1 })

    React.useEffect(function()
        return function()
            local var22 = var16
            var22.current += 1
            local current2 = var11.current
            if current2 ~= nil then
                pcall(function()
                    current2:Destroy()
                end)
            end
            var11.current = nil
            var21.current = {
                byTime = {},
                set = {},
                times = {}
            }
        end
    end, {})

    return {
        contentA = contentA,
        contentB = contentB,
        frontIsA = frontIsA,
        imageARef = imageARef,
        imageBRef = imageBRef,
        isLoading = isLoading
    }
end

return useVideoScrubPreview
