-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:31:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Signals = require(MomentsParent.Signals)

local function createMomentsShellStackStore()
    local var1, var2 = Signals.createSignal({})
    local getTopShellId = Signals.createComputed(function(arg1)
        local var3 = var1(arg1)
        return var3[#var3]
    end)
    local num1 = 0

    return {
        getTopShellId = getTopShellId,
        pushShell = function()
            num1 += 1
            local num2 = num1
            var2(function(arg1)
                local var3 = table.clone(arg1)
                table.insert(var3, num2)
                return var3
            end)

            local function removeShell()
                var2(function(arg1)
                    local var3 = table.find(arg1, num2)
                    if var3 == nil then
                        return arg1
                    end
                    local var4 = table.clone(arg1)
                    table.remove(var4, var3)
                    return var4
                end)
            end

            return num2, removeShell
        end
    }
end
return createMomentsShellStackStore
