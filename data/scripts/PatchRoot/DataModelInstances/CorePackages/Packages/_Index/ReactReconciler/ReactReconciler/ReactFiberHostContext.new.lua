-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:30:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _ReactInternalTypes = require(script.Parent.ReactInternalTypes)

local ReactFiberStackNew = require(script.Parent["ReactFiberStack.new"])

local ReactFiberHostConfig = require(script.Parent.ReactFiberHostConfig)

local getChildHostContext = ReactFiberHostConfig.getChildHostContext
local getRootHostContext = ReactFiberHostConfig.getRootHostContext
local createCursor = ReactFiberStackNew.createCursor
local push = ReactFiberStackNew.push
local pop = ReactFiberStackNew.pop

local tbl1 = {}

local cursor = createCursor(tbl1)
local cursor2 = createCursor(tbl1)

local cursor3 = createCursor(tbl1)

function requiredContext<T>(current: T): T
    return current
end

function getRootHostContainer()
    return cursor3.current
end

function pushHostContainer(arg1, arg2)
    push(cursor3, arg2, arg1)

    push(cursor2, arg1, arg1)

    push(cursor, tbl1, arg1)
    local rootHostContext = getRootHostContext(arg2)

    pop(cursor, arg1)
    push(cursor, rootHostContext, arg1)
end

function popHostContainer(arg1)
    pop(cursor, arg1)
    pop(cursor2, arg1)
    pop(cursor3, arg1)
end

function getHostContext()
    return cursor.current
end

function pushHostContext(arg1)
    local var1 = requiredContext(cursor3.current)
    local var2 = requiredContext(cursor.current)
    local childHostContext = getChildHostContext(var2, arg1.type, var1)

    if var2 == childHostContext then
        return
    end

    push(cursor2, arg1, arg1)
    push(cursor, childHostContext, arg1)
end

function popHostContext(current)
    if cursor2.current ~= current then
        return
    end

    pop(cursor, current)
    pop(cursor2, current)
end

return {
    getHostContext = getHostContext,
    getRootHostContainer = getRootHostContainer,
    popHostContainer = popHostContainer,
    popHostContext = popHostContext,
    pushHostContainer = pushHostContainer,
    pushHostContext = pushHostContext
}
