-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:11:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local assetSource = require(script.Parent.assetSource)
local _types = require(script.Parent.types)

local default = assetSource.default

local tbl1 = ({})

return {
    load = function(num1: number) -- name: loadBackgroundAsset
        local var1 = tbl1[num1]
        if var1 then
            return var1
        end

        local var2 = default(num1):catch(function(arg1)
            tbl1[num1] = nil
            error(arg1)
        end)
        tbl1[num1] = var2
        return var2
    end,
    clearCache = function()
        tbl1 = {}
    end
}
