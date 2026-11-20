-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:21:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Signals = require(scriptParentParent.Signals)
local createSignal = Signals.createSignal
local createComputed = Signals.createComputed

local batch = require(scriptParentParent.SignalsScheduler).batch

local function createWrappedSignal(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    local getter, setter = createSignal(function()
        return arg1
    end)
    return { getter = getter, setter = setter }
end

local function createProxy(arg1)
    local tbl1 = ({})

    for value, value2 in arg1 do
        tbl1[value] = createWrappedSignal(value2)
    end

    local var1, var2 = createSignal(nil, function(): boolean
        return false
    end)

    local computed = createComputed(function(arg2): number
        var1(arg2)
        local num1 = 0
        for _, value in ipairs(tbl1) do
            if value.getter(false) ~= nil then
                num1 += 1
            end
        end
        return num1
    end)

    local function nextSignal(arg2, arg3)
        while true do
            local var3
            arg3, var3 = next(arg2, arg3)
            if arg3 == nil then
                break
            end

            if var3 == nil then
                continue
            end

            local var4 = var3.getter(false)
            if var4 ~= nil then
                return arg3, var4
            end
        end

        return nil
    end

    return (setmetatable({}, (table.freeze({
        __len = function() -- name: untrackedLength
            return computed(false)
        end,
        __call = function(_, arg2) -- name: createTrackedProxy
            local function nextSignal2(arg3, arg4)
                while true do
                    local var3
                    arg4, var3 = next(arg3, arg4)
                    if arg4 == nil then
                        break
                    end

                    if var3 == nil then
                        continue
                    end

                    local var4 = var3.getter(arg2)
                    if var4 ~= nil then
                        return arg4, var4
                    end
                end

                return nil
            end

            return (setmetatable({}, (table.freeze({
                __len = function() -- name: trackedLength
                    return computed(arg2)
                end,
                __iter = function() -- name: trackedIterator
                    var1(arg2)
                    return nextSignal2, tbl1
                end,
                __index = function(_, arg3) -- name: trackedIndex
                    local var3 = tbl1[arg3]
                    if var3 == nil then
                        if arg2 == nil then
                            return nil
                        end

                        var3 = createWrappedSignal(nil)

                        tbl1[arg3] = var3
                    end
                    return var3.getter(arg2)
                end,
                __newindex = function(_, arg3, arg4) -- name: noNewIndex
                    error(`attempt to update read-only store at {arg3} with {arg4}`, 2)
                end,
                __metatable = false
            }))))
        end,
        __iter = function() -- name: untrackedIterator
            return nextSignal, tbl1
        end,
        __index = function(_, arg2) -- name: untrackedIndex
            local var3 = tbl1[arg2]
            if var3 ~= nil then
                return var3.getter(false)
            end
            return nil
        end,
        __newindex = function(_, arg2, arg3) -- name: newIndex
            local tbl2 = tbl1[arg2]
            if tbl2 == nil then
                if arg3 ~= nil then
                    tbl2 = createWrappedSignal(arg3)

                    tbl1[arg2] = tbl2
                    var2()
                end

                return
            end

            local var3 = tbl2.getter(false)
            if var3 == arg3 then
                return
            end

            batch(function()
                tbl2.setter(function()
                    return arg3
                end)
                if var3 == nil or arg3 == nil then
                    var2()
                end
            end)
        end,
        __metatable = false
    }))))
end
return createProxy
