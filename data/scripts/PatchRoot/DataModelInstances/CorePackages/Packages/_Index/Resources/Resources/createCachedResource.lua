-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:51:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _types = require(script.Parent.types)

local function once(callback) -- Luacid: Inlined by compiler; 1 call site recovered
    local bool1 = false
    local function notAgain()
        if not bool1 then
            bool1 = true
            callback()
        end
    end
    return notAgain
end

local function createCachedResource(arg1)
    local var1 = nil
    local var2 = nil
    local num1 = 0

    local function disposeResource() -- Luacid: Inlined by compiler; 1 call site recovered
        num1 -= 1
        if num1 ~= 0 then
            return
        end

        var1 = nil
        if var2 ~= nil then
            local var3 = var2
            var2 = nil
            var3()
        end
    end

    local function constructResource()
        var2, var1 = arg1()
    end

    local function handleError(bool1: boolean, ...)
        if not bool1 then
            disposeResource()
            error(...)
        end
    end

    local function cachedResource()
        num1 += 1
        if num1 == 1 then
            handleError(pcall(constructResource))
        end

        local func1 = once(disposeResource)
        return func1, var1
    end

    return cachedResource
end

return createCachedResource
