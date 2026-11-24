-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:21:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local createSignal = require(ExpChatParent.Signals).createSignal

local function createCharacterStore()
    local getCharacters, var2 = createSignal({})

    local function getKey(arg1): string -- Luacid: Inlined by compiler; 2 call sites recovered
        return tostring(arg1)
    end

    return {
        getCharacters = getCharacters,
        handleCharacterAdded = function(arg1, arg2)
            local key = getKey(arg1)

            var2(function(arg3)
                local var3 = table.clone(arg3)
                var3[key] = arg2
                return var3
            end)
        end,
        handlePlayerRemoved = function(arg1)
            local key = getKey(arg1)

            var2(function(arg2)
                local var3 = table.clone(arg2)
                var3[key] = nil
                return var3
            end)
        end
    }
end

return createCharacterStore
