-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:10:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local createSignal = require(ChatUIPrimitivesParent.Signals).createSignal

local function createExpressionCooldownStore()
    local getCooldownEndsAtByKey, var2 = createSignal({})

    local function getCooldownEndsAt(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
        return getCooldownEndsAtByKey(false)[str1]
    end

    local function setDeadline(str1: string, num1: number?) -- Luacid: Inlined by compiler; 3 call sites recovered
        local var3 = table.clone(getCooldownEndsAtByKey(false))
        if num1 == nil then
            var3[str1] = nil
        else
            var3[str1] = num1
        end
        var2(var3)
    end

    return {
        getCooldownEndsAtByKey = getCooldownEndsAtByKey,
        getCooldownEndsAt = getCooldownEndsAt,
        startCooldown = function(str1: string, num1: number)
            setDeadline(str1, num1)

            task.delay(math.max(0, num1 - os.clock()), function()
                if getCooldownEndsAt(str1) == num1 then
                    setDeadline(str1, nil)
                end
            end)
        end,
        clearCooldown = function(str1: string)
            setDeadline(str1, nil)
        end,
        _resetForTesting = function()
            var2({})
        end
    }
end
return createExpressionCooldownStore
