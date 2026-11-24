-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:30:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local createEffect = require(DataHydrationParent.Signals).createEffect

local _types = require(script.Parent.types)

local tbl1 = ({})

local function onTerminal(arg1, callback: ((...any) -> (...any))?, callback2: ((...any) -> (...any))?)
    local tbl2 = {}
    local bool1 = false
    local bool2 = false

    local function cleanupEffect() -- Luacid: Inlined by compiler; 3 call sites recovered
        if bool2 then
            return
        end
        bool2 = true
        local var1 = tbl1[tbl2]
        tbl1[tbl2] = nil
        if var1 ~= nil then
            var1()
        end
    end

    local function settle(arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
        if bool1 then
            return
        end
        bool1 = true
        cleanupEffect()

        if arg2.status == "succeeded" and callback then
            callback(arg2.result)
        elseif arg2.status == "failed" and callback2 then
            callback2(arg2.error or "request failed", arg2.errorCode)
        end
    end

    local var1 = arg1(false)
    if var1.status ~= "pending" then
        settle(var1)
        return
    end

    local effect = createEffect(function(arg2)
        local var2 = arg1(arg2)
        if var2.status == "pending" then
            return
        end

        settle(var2)
    end)

    if bool2 then
        effect()
    else
        tbl1[tbl2] = effect
    end
end

return onTerminal
