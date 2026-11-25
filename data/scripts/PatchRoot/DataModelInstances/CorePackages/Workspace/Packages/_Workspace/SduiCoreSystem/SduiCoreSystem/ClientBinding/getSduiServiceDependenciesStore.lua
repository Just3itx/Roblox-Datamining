-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:41:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent

local SduiErrors = require(SduiCoreSystem.SduiErrors)
local SduiLogger = require(SduiCoreSystem.SduiLogger)

local FFlagSduiHostedDependencies = require(SduiCoreSystemParent.SharedFlags).FFlagSduiHostedDependencies

local _SduiBuilderTypes = require(SduiCoreSystem.SduiBuilderTypes)

local function createSduiServiceDependenciesStore()
    local var1 = nil

    local var2 = FFlagSduiHostedDependencies and {} or nil

    local var3 = FFlagSduiHostedDependencies and {
        __index = function(_, arg1)
            return if var1 then var1[arg1] else nil
        end
    } or nil

    return {
        getDependencies = function(str1: string)
            local var4 = var1
            if FFlagSduiHostedDependencies then
                local var5 = var2[str1]
                if var5 then
                    var4 = var5[#var5]
                else
                    var4 = var1
                end
            end

            if var4 == nil then
                SduiLogger.reportError(
                    SduiErrors.SduiErrorType.GetNilDependencies,
                    { message = "Getting dependencies before they were set" },
                    str1
                )
            end

            return var4
        end,
        setDependencies = function(arg1)
            var1 = arg1
        end,
        setScopedDependencies = FFlagSduiHostedDependencies and function(str1: string, tbl1) -- name: setScopedDependencies
            local tbl2 = var2[str1]
            if tbl2 == nil then
                tbl2 = {}
                var2[str1] = tbl2
            end
            local var4 = setmetatable(table.clone(tbl1), var3)
            table.insert(tbl2, var4)
            return function()
                local var5 = table.find(tbl2, var4)
                if var5 then
                    table.remove(tbl2, var5)
                end
                if #tbl2 == 0 and var2[str1] == tbl2 then
                    var2[str1] = nil
                end
            end
        end or nil
    }
end

local var1 = nil

local function getSduiServiceDependenciesStore()
    if var1 == nil then
        var1 = createSduiServiceDependenciesStore()
    end
    return var1
end

return getSduiServiceDependenciesStore
