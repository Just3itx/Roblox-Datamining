-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")

local perUserAppStorage = require(ExpChat.Utils.perUserAppStorage)

local module = {}

function module.hasBeenDismissed(): boolean
    return perUserAppStorage.getEntry("ExpChatDictationFtux").dismissed == true
end

function module.markDismissed()
    perUserAppStorage.updateEntry("ExpChatDictationFtux", function(tbl1): {[any]: any}?
        if tbl1.dismissed == true then
            return nil
        end
        tbl1.dismissed = true
        return tbl1
    end)
end

function module.hasBeenUsed(): boolean
    return perUserAppStorage.getEntry("ExpChatDictationFtux").used == true
end

function module.markUsed()
    perUserAppStorage.updateEntry("ExpChatDictationFtux", function(tbl1): {[any]: any}?
        if tbl1.used == true then
            return nil
        end
        tbl1.used = true
        return tbl1
    end)
end

return module
