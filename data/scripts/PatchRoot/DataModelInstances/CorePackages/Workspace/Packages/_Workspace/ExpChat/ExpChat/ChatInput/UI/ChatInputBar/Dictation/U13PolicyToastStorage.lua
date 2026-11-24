-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:51:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")

local perUserAppStorage = require(ExpChat.Utils.perUserAppStorage)

local module = {}

function module.hasBeenShown(): boolean
    return perUserAppStorage.getEntry("ExpChatDictationU13PolicyToast").shown == true
end

function module.markShown()
    perUserAppStorage.updateEntry("ExpChatDictationU13PolicyToast", function(tbl1): {[any]: any}?
        if tbl1.shown == true then
            return nil
        end
        tbl1.shown = true
        return tbl1
    end)
end

return module
