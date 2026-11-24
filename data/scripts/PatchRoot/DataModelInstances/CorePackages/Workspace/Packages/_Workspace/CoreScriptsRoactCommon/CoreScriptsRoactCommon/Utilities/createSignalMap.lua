-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:31:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreScriptsRoactCommonParent = script:FindFirstAncestor("CoreScriptsRoactCommon").Parent

local Signals = require(CoreScriptsRoactCommonParent.Signals)
local Cryo = require(CoreScriptsRoactCommonParent.Cryo)

local function createSignalMap(tbl1)
    local tbl2 = ({})
    local num1 = 0
    if tbl1 then
        for k, value in pairs(tbl1) do
            tbl2[k] = value
            num1 += 1
        end
    end

    local var1, var2 = Signals.createSignal(tbl2)
    local getCount, var4 = Signals.createSignal(num1)

    local function setData(arg1, arg2, arg3)
        local var5 = var1(arg3)
        local var6 = var5[arg1]
        local var7 = Cryo.Dictionary.join(var5, { [arg1] = arg2 })
        if not var6 then
            var4(getCount(arg3) + 1)
        end
        var2(var7)
    end

    local function removeData(arg1, arg2)
        local var5 = var1(arg2)
        if not var5[arg1] then
            return
        end

        local var6 = Cryo.Dictionary.join(var5, { [arg1] = Cryo.None })

        var4(getCount(arg2) - 1)
        var2(var6)
    end

    local getAllData = Signals.createComputed(function(arg1)
        return var1(arg1)
    end)

    return {
        getData = function(arg1, arg2)
            return var1(arg2)[arg1]
        end,
        setData = setData,
        removeData = removeData,
        getCount = getCount,
        iterateData = function(callback: (...any) -> (...any), arg1)
            return Signals.createEffect(function()
                local var5 = var1(arg1)
                for k, value in pairs(var5) do
                    callback(k, value)
                end
            end)
        end,
        getAllData = getAllData
    }
end

return createSignalMap
