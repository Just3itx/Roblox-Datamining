-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:31:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProgressLoadingParent = script:FindFirstAncestor("ProgressLoading").Parent

local _React = require(ProgressLoadingParent.React)
local getPregameOverride, var2 = require(ProgressLoadingParent.Signals).createSignal(nil)

return {
    getPregameOverride = getPregameOverride,
    setPregameOverride = function(tbl1, setAt: number?)
        if tbl1 == nil then
            var2(nil)
            return
        end
        local var3 = table.clone(tbl1)
        var3.setAt = setAt or os.clock()
        var2(var3)
    end,
    claims = function(tbl1, placeId: number, num1: number): boolean
        return tbl1.placeId == placeId and num1 - (tbl1.setAt or 0) <= 15
    end
}
