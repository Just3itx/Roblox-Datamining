-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:21:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local Cryo = require(AppChatParent.Cryo)
local Signals = require(AppChatParent.Signals)

local function createTopBarStore()
    local var1, var2 = Signals.createSignal({})

    local tbl1 = ({})

    return {
        getScreenTopBar = function(str1: string)
            if tbl1[str1] == nil then
                tbl1[str1] = Signals.createComputed(function(arg1)
                    return var1(arg1)[str1] or {}
                end)
            end
            return tbl1[str1]
        end,
        setScreenTopBar = function(str1: string, tbl2)
            var2(function(arg1)
                local var3 = Cryo.Dictionary.union(arg1[str1] or {}, tbl2)
                return Cryo.Dictionary.union(arg1, { [str1] = var3 })
            end)
        end,
        clearScreenTopBar = function(str1: string)
            var2(function(arg1)
                return Cryo.Dictionary.union(arg1, { [str1] = {} })
            end)
        end,
        resetStore = function()
            var2({})
        end
    }
end
return createTopBarStore
