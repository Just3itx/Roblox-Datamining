-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:10:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local _LuauPolyfill = require(AppChatParent.LuauPolyfill)
local Promise = require(AppChatParent.Promise)

local tbl1 = {}
local bool1 = false
local num1 = 0
local var1 = nil

local function completeRequest() -- Luacid: Inlined by compiler; 2 call sites recovered
    bool1 = false
    var1()
end

var1 = function()
    if bool1 then
        return
    end

    local var2 = table.remove(tbl1, 1)
    while var2 and var2.owner.cancelled do
        var2.resolve(nil)
        var2 = table.remove(tbl1, 1)
    end

    if not var2 then
        return
    end

    bool1 = true

    local function func1(arg1)
        var2.resolve(arg1)
        completeRequest()
    end

    local function func2(arg1)
        var2.reject(arg1)
        completeRequest()
    end

    Promise.try(var2.request):andThen(func1, func2)
end

return {
    createOwner = function()
        return { cancelled = false }
    end,
    cancelOwner = function(tbl2)
        tbl2.cancelled = true
    end,
    enqueue = function(owner, request: (...any) -> (...any))
        num1 += 1
        return {
            generation = num1,
            promise = Promise.new(function(resolve: (...any) -> (...any), reject: (...any) -> (...any))
                table.insert(tbl1, { owner = owner, request = request, resolve = resolve, reject = reject })

                var1()
            end)
        }
    end,
    isLatestGeneration = function(num2: number): boolean
        return num2 == num1
    end
}
