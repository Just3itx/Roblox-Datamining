-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:30:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {
    View = { ids = "signal_view_item_ids", values = "signal_view_duration_seconds" },
    AddReaction = { ids = "signal_add_reaction_item_ids", values = "signal_add_reaction_values" },
    RemoveReaction = {
        ids = "signal_remove_reaction_item_ids",
        values = "signal_remove_reaction_values"
    },
    AddFollow = { ids = "signal_add_follow_item_ids", values = nil },
    RemoveFollow = { ids = "signal_remove_follow_item_ids", values = nil },
    Share = { ids = "signal_share_item_ids", values = nil },
    Report = { ids = "signal_report_item_ids", values = nil },
    Join = { ids = "signal_join_item_ids", values = nil }
}

local tbl2 = ({})
tbl2.__index = tbl2

local function createSignalTracker()
    return (setmetatable({ _payload = {}, _counts = {}, _totalCount = 0 }, tbl2))
end

function tbl2:recordSignal(str1: string, str2: string, str3: string?)
    local var1 = tbl1[str2]
    if var1 == nil then
        return
    end

    local _payload = self._payload
    local _counts = self._counts

    local ids = var1.ids
    local tbl3 = _payload[ids]
    if not tbl3 then
        tbl3 = {}
        _payload[ids] = tbl3
    end

    local values = var1.values
    local tbl4 = if values then _payload[values] else nil

    if values and not tbl4 then
        tbl4 = {}
        _payload[values] = tbl4
    end

    local _count = _counts[ids] or 0
    if _count >= 25 then
        table.remove(tbl3, 1)
        if tbl4 then
            table.remove(tbl4, 1)
        end
    else
        _counts[ids] = _count + 1
        self._totalCount += 1
    end

    table.insert(tbl3, str1)
    if tbl4 then
        table.insert(tbl4, str3 or "")
    end
end

function tbl2:getSignalsPayload()
    return if self._totalCount == 0 then nil else self._payload
end

function tbl2:getSignalCount()
    return self._totalCount
end

return createSignalTracker
