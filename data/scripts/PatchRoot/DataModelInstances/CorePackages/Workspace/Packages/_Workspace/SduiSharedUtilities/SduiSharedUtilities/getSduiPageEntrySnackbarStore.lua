-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:50:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilitiesParent = script:FindFirstAncestor("SduiSharedUtilities").Parent

local Signals = require(SduiSharedUtilitiesParent.Signals)

local function createSduiPageEntrySnackbarStore()
    local tbl1 = ({})

    return {
        getSignal = function(str1: string)
            local var1 = tbl1[str1]
            if var1 then
                return var1.get
            end

            local get, set = Signals.createSignal(nil)
            tbl1[str1] = { get = get, set = set }

            return get
        end,
        show = function(str1: string, tbl2)
            local var1 = tbl1[str1]
            if var1 then
                var1.set(tbl2)
                return
            end
            local get, set = Signals.createSignal(nil)
            tbl1[str1] = { get = get, set = set }

            set(tbl2)
        end,
        hide = function(str1: string)
            local var1 = tbl1[str1]
            if var1 then
                var1.set(nil)
                return
            end
            local get, set = Signals.createSignal(nil)
            tbl1[str1] = { get = get, set = set }

            set(nil)
        end
    }
end
local var1 = nil

local function getSduiPageEntrySnackbarStore()
    if var1 == nil then
        var1 = createSduiPageEntrySnackbarStore()
    end
    return var1
end

return getSduiPageEntrySnackbarStore
