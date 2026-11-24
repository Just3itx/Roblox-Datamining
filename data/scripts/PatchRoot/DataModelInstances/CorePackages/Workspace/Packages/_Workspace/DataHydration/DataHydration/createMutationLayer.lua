-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:11:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent
local Cryo = require(DataHydrationParent.Cryo)
local Signals = require(DataHydrationParent.Signals)

local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)

local function createMutationLayer()
    local tbl1 = {}
    local tbl2 = {}
    local tbl3 = ({})

    local tbl4 = ({})

    local function getOrCreateMutationSignal(str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
        if not tbl1[str1] then
            local tbl5 = tbl1
            local tbl6 = tbl2
            local var1, var2 = Signals.createSignal(nil)
            tbl5[str1] = var1
            tbl6[str1] = var2
        end
        return tbl1[str1], tbl2[str1]
    end

    local function has(str1: string): boolean -- Luacid: Inlined by compiler; 1 call site recovered
        return if tbl1[str1] then tbl1[str1](false) ~= nil else false
    end

    return {
        set = function(str1: string, arg1)
            local var1, var2 = getOrCreateMutationSignal(str1)
            local var3 = var1(false)
            if type(var3) == "table" and type(arg1) == "table" then
                var2((Cryo.Dictionary.union(var3, arg1)))
                return
            end
            var2(arg1)
        end,
        clear = function(str1: string)
            if tbl2[str1] then
                tbl2[str1](nil)
            end
            tbl4[str1] = nil
        end,
        has = has,
        get = function(str1: string)
            if not tbl1[str1] then
                return nil
            end
            return tbl1[str1](false)
        end,
        markCommitted = function(str1: string)
            if has(str1) then
                tbl4[str1] = true
            end
        end,
        isCommitted = function(str1: string): boolean
            return tbl4[str1] == true
        end,
        drainCommitted = function(tbl5, callback: (...any) -> (...any))
            for _, value in tbl5 do
                if not tbl4[value] then
                    continue
                end

                local var1 = if tbl1[value] then tbl1[value](false) or nil else nil

                if var1 ~= nil then
                    callback(value, var1)
                end
                if tbl2[value] then
                    tbl2[value](nil)
                end
                tbl4[value] = nil
            end
        end,
        getMergedResult = function(str1: string, arg1)
            if tbl3[str1] then
                return tbl3[str1]
            end

            local var1, _ = getOrCreateMutationSignal(str1)

            local computed = Signals.createComputed(function(arg2)
                local var2 = var1(arg2)
                local var3 = arg1.data(arg2)
                if var2 == nil then
                    return var3
                end
                if type(var2) ~= "table" then
                    return var2
                end

                local var4 = type(var3) ~= "table" and {} or var3
                return (Cryo.Dictionary.join(var4, var2))
            end)

            tbl3[str1] = {
                data = computed,
                status = arg1.status
            }

            return tbl3[str1]
        end,
        clearAll = function()
            for _, value in tbl2 do
                value(nil)
            end
            tbl4 = {}
            tbl3 = {}
        end
    }
end
return createMutationLayer
