-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:21:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommon = script:FindFirstAncestor("MomentsCommon")

local _MediaTypes = require(MomentsCommon.Media.MediaTypes)

local function createMediaNodeRegistry()
    local tbl1 = {}

    return {
        register = function(tbl2)
            assert(not tbl1[tbl2.kind], `mediaNodeRegistry: kind "{tbl2.kind}" already registered`)
            tbl1[tbl2.kind] = tbl2
        end,
        getFactory = function(str1: string)
            return tbl1[str1]
        end,
        create = function(str1: string, tbl2, arg1)
            local var1 = tbl1[str1]
            assert(var1, `mediaNodeRegistry: no factory registered for kind "{str1}"`)
            return var1.create(tbl2, arg1)
        end,
        getKinds = function()
            local kinds = {}
            for value in tbl1 do
                table.insert(kinds, value)
            end
            table.sort(kinds)
            return kinds
        end
    }
end
return createMediaNodeRegistry
