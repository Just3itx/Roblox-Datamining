-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:00:37Z
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

local function disposeChildren(tbl1)
    local tbl2 = {}

    for i = #tbl1, 1, -1 do
        local success, result = pcall(tbl1[i])
        if not success then
            table.insert(tbl2, result)
        end
    end

    if #tbl2 > 0 then
        error(table.concat(tbl2, "\n"))
    end
end

local function createResource(callback: (...any) -> (...any))
    local bool1 = false

    local tbl1 = {}

    local function dispose() -- Luacid: Inlined by compiler; 1 call site recovered
        if bool1 then
            return
        end

        bool1 = true
        local tbl2 = tbl1
        tbl1 = {}
        disposeChildren(tbl2)
    end

    local function capture(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
        if not bool1 then
            table.insert(tbl1, arg1)
            return
        end
        error("attempted to track a child after the resource has been disposed")
    end

    local function own(arg1, ...)
        capture(arg1)
        return ...
    end

    local function handleError(bool2: boolean, ...)
        if not bool2 then
            dispose()
            local error = error
            local select = select
            error((select(1, ...)))
        end
        return ...
    end

    return once(dispose), handleError(pcall(callback, own))
end

return createResource
