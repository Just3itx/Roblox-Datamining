-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:41:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystemParent = script:FindFirstAncestor("SduiCoreSystem").Parent

local Signals = require(SduiCoreSystemParent.Signals)

local var1 = (setmetatable({}, { __mode = "v" }))

local function ensureFieldSignal(tbl1, str1: string) -- Luacid: Inlined by compiler; 3 call sites recovered
    local var2 = tbl1[str1]
    if var2 then
        return var2
    end

    local get, set = Signals.createSignal(nil)
    local tbl2 = { get = get, set = set }

    tbl1[str1] = tbl2
    return tbl2
end

local function getSduiClientPageScope(str1: string)
    local var2 = var1[str1]
    if var2 then
        return var2
    end

    local tbl1 = {}

    local tbl2 = {
        get = function(str2: string)
            return ensureFieldSignal(tbl1, str2).get(false)
        end,
        set = function(str2: string, arg1)
            ensureFieldSignal(tbl1, str2).set(arg1)
        end,
        getSignal = function(str2: string)
            return ensureFieldSignal(tbl1, str2).get
        end
    }

    var1[str1] = tbl2
    return tbl2
end

return getSduiClientPageScope
