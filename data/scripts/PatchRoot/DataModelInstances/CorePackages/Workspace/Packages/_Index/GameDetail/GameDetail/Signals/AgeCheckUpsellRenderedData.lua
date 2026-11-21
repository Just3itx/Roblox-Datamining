-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetailParent = script:FindFirstAncestor("GameDetail").Parent
local Signals = require(GameDetailParent.Signals)

local AgeCheckUpsellDismissedData = require(script.Parent.AgeCheckUpsellDismissedData)

local tbl1 = ({})

local function getOrCreate(str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    local tbl2 = tbl1[str1]
    if not tbl2 then
        local get, set = Signals.createSignal(false)
        tbl2 = { get = get, set = set }
        tbl1[str1] = tbl2
    end
    return tbl2
end

return {
    getIsAgeCheckUpsellRendered = function(arg1, str1: string?)
        if str1 == nil or str1 == "" or AgeCheckUpsellDismissedData.getIsAgeCheckUpsellDismissed(arg1) then
            return false
        end

        return getOrCreate(str1).get(arg1)
    end,
    setAgeCheckUpsellRendered = function(str1: string, bool1: boolean)
        if str1 == nil or str1 == "" then
            return
        end
        getOrCreate(str1).set(bool1)
    end
}
