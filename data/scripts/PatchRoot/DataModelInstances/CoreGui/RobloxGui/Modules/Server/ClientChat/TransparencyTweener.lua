-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

local RunService = game:GetService("RunService")

local _scriptParent = script.Parent

local tbl1 = { __ClassName = "TransparencyTweener" }

function tbl1.__tostring(arg1)
    return arg1.__ClassName .. ": " .. arg1.MemoryLocation
end

tbl1.__metatable = "The metatable is locked"
function tbl1.__index(arg1, arg2, _)
    if rawget(arg1, arg2) then
        return rawget(arg1, arg2)
    end

    if rawget(tbl1, arg2) then
        return rawget(tbl1, arg2)
    end
    if arg2 == "Transparency" then
        return rawget(arg1, "InternalLastTweenPercentage")
    end

    error(arg2 .. " is not a valid member of " .. arg1.__ClassName)
end

function tbl1.__newindex(arg1, arg2, internalLastTweenPercentage)
    if arg2 == "Transparency" then
        arg1.InternalLastTweenPercentage = internalLastTweenPercentage
        arg1:SetPropertiesToTweenPercentage(internalLastTweenPercentage)
        return
    end

    error(arg2 .. " is not a valid member of " .. arg1.__ClassName)
end

function tbl1.Dump(arg1)
    local str1 = tostring(arg1)

    for k, tweenObject in pairs(arg1.TweenObjects) do
        local str2 = " | "
        if type(k) == "table" then
            str2 ..= "{{" .. k:Dump() .. "}}"
        elseif type(k) == "userdata" then
            str2 ..= k.Name .. "/" .. k:GetFullName()
        end

        for k2, value in pairs(tweenObject) do
            local str3 = tostring(value)
            str2 ..= " [" .. k2 .. "=" .. string.sub(str3, 1, 4) .. "]"
        end

        str1 ..= str2
    end

    return str1
end

function tbl1.OutputTest(arg1)
    print("Test Output for {={" .. arg1:Dump() .. "}=}")
    for k, tweenObject in pairs(arg1.TweenObjects) do
        print("TweenObject:", k)
        for k2, value in pairs(tweenObject) do
            local print = print
            local str1 = tostring(value)
            print("\t[" .. k2 .. "=" .. string.sub(str1, 1, 4) .. "] Actual:" .. k[k2])
        end
    end
end

function tbl1.RegisterTweenObjectProperty(arg1, arg2, arg3, arg4)
    arg4 = arg4 or arg2[arg3]

    if not arg1.TweenObjects[arg2] then
        arg1.TweenObjects[arg2] = {}
    end

    arg1.TweenObjects[arg2][arg3] = arg4

    arg1:SetObjectPropertyToPercentValue(arg2, arg3, arg4, arg1.InternalLastTweenPercentage)
end

function tbl1.UnregisterTweenObject(arg1, arg2)
    arg1.TweenObjects[arg2] = nil
end

function tbl1.SetObjectPropertyToPercentValue(_, arg1, arg2, arg3, arg4)
    arg1[arg2] = arg3 + (1 - arg3) * arg4
end

function tbl1.SetPropertiesToTweenPercentage(arg1, arg2)
    for k, tweenObject in pairs(arg1.TweenObjects) do
        for k2, value in pairs(tweenObject) do
            arg1:SetObjectPropertyToPercentValue(k, k2, value, arg2)
        end
    end
end

function tbl1.Tween(arg1, arg2, internalLastTweenPercentage, arg4)
    if arg1.Tweening then
        arg1.QueuedTween = { arg2, internalLastTweenPercentage, arg4 }
        arg1.TweenIsQueued = true
        arg1:CancelTween()
        return
    end
    arg1.Tweening = true

    local var1 = arg4

    if var1 then
        arg1:SetPropertiesToTweenPercentage(var1)
    else
        var1 = arg1.InternalLastTweenPercentage
    end

    local now = tick()
    local var2 = now + arg2
    local var3 = internalLastTweenPercentage - var1

    local num1 = 0
    spawn(function()
        local var4 = tick()
        while var4 < var2 and not arg1.Canceled do
            num1 = math.min(math.max((var4 - now) / arg2, 0), 1)
            local var5 = var1 + var3 * num1
            arg1.InternalLastTweenPercentage = var5
            arg1:SetPropertiesToTweenPercentage(var5)

            RunService.RenderStepped:wait()
            var4 = tick()
        end

        if not arg1.Canceled then
            arg1.InternalLastTweenPercentage = internalLastTweenPercentage
            arg1:SetPropertiesToTweenPercentage(internalLastTweenPercentage)
        else
            arg1.Canceled = false

            if arg1.TweenIsQueued then
                arg1.TweenIsQueued = false
                arg1.Tweening = false
                arg1:Tween(unpack(arg1.QueuedTween))
                return
            end
        end

        arg1.Tweening = false
    end)
end

function tbl1.CancelTween(arg1)
    arg1.Canceled = true
end

function module.new()
    local tbl2 = {}
    tbl2.MemoryLocation = tostring(tbl2):match("[0123456789ABCDEF]+")

    tbl2.TweenObjects = setmetatable({}, { __mode = "k" })

    tbl2.Transparency = nil
    tbl2.InternalLastTweenPercentage = 0
    tbl2.Tweening = false
    tbl2.Canceled = false

    tbl2.TweenIsQueued = false
    tbl2.QueuedTween = {}

    return (setmetatable(tbl2, tbl1))
end

return module
