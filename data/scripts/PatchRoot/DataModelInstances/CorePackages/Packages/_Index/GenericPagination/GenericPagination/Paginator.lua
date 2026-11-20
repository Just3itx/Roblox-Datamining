-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local dependencies = require(script.Parent.dependencies)
local t = dependencies.t
local LinkedList = dependencies.LinkedList
local Promise = dependencies.Promise

local module = { llRoot = nil, llIndex = nil, _isFetching = false }

module.__index = module

local var1 = t.strictInterface({ pageSize = t.number, fetchWithCursor = t.callback, fetchInit = t.callback })

function module.new(arg1)
    assert(var1(arg1))
    local result = ({})
    for k, value in pairs(arg1) do
        result[k] = value
    end
    setmetatable(result, module)

    result:_init()
    return result
end

function module._init(arg1)
    arg1._isFetching = true
    return arg1.fetchInit():andThen(function(arg2, arg3)
        arg1.llRoot = LinkedList.createNode()
        arg1.llIndex = arg1.llRoot
        arg1.llIndex:CreatePrevious(arg2)
        arg1.llIndex:CreateNext(arg3)
        arg1._isFetching = false
    end)
end

function module.getCurrent(arg1)
    return arg1.llIndex.value or {}
end

function module.getNext(arg1)
    if arg1._isFetching then
        return Promise.reject("Paginator is currently busy. Please wait.")
    end

    local value = arg1.llIndex.next.value or ""

    if value == "" then
        return Promise.reject("Next cursor is invalid")
    end

    arg1.llIndex = arg1.llIndex.next
    arg1._isFetching = true

    return arg1.fetchWithCursor(value):andThen(function(arg2, arg3)
        arg1.llIndex.previous.value = arg2
        if arg1.llIndex.next then
            arg1.llIndex.next.value = arg3
        else
            arg1.llIndex:CreateNext(arg3)
        end
        arg1._isFetching = false
    end)
end

function module.getPrevious(arg1)
    if arg1._isFetching then
        return Promise.reject("Paginator is currently busy. Please wait.")
    end

    local value = arg1.llIndex.previous.value or ""

    if value == "" then
        return Promise.reject("Previous cursor is invalid")
    end

    arg1.llIndex = arg1.llIndex.previous
    arg1._isFetching = true

    return arg1.fetchWithCursor(value, true):andThen(function(arg2, arg3)
        arg1.llIndex.next.value = arg3
        if arg1.llIndex.previous then
            arg1.llIndex.previous.value = arg2
        else
            arg1.llIndex:CreatePrevious(arg2)
        end
        arg1._isFetching = false
    end)
end

function module.isFetching(arg1)
    return arg1._isFetching
end

return module
