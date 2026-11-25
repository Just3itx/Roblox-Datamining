-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:21:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NotificationsCommon = script:FindFirstAncestor("NotificationsCommon")
local Logger = require(NotificationsCommon.Logger)

local tbl1 = {}

local function logListenerError(arg1)
    Logger:error("DeeplinkTapListeners: a listener failed: {}", tostring(arg1))
end

return {
    connect = function(listener: (...any) -> (...any))
        local tbl2 = { listener = listener, connected = true }
        table.insert(tbl1, tbl2)
        return function()
            if not tbl2.connected then
                return
            end
            tbl2.connected = false
            local var1 = table.find(tbl1, tbl2)
            if var1 then
                table.remove(tbl1, var1)
            end
        end
    end,
    notify = function(tbl2)
        for _, value in table.clone(tbl1) do
            if value.connected then
                xpcall(value.listener, logListenerError, tbl2)
            end
        end
    end
}
