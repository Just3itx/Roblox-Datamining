-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:41:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Analytics = require(script.Parent.Analytics)

local tbl1 = { 2, 10 }
local tbl2 = ({})
local module = {}

local function createDelayedTask(arg1, arg2, callback) -- Luacid: Inlined by compiler; 1 call site recovered
    local bool1 = false

    task.delay(arg1, function()
        if not bool1 then
            callback(arg2)
        end
    end)
    return function()
        bool1 = true
    end
end

local function cancelTasks()
    for _, value in ipairs(tbl2) do
        if value ~= nil then
            value()
        end
    end
    tbl2 = {}
end

function module.onPageChanged(arg1)
    cancelTasks()
    for i, value in ipairs(tbl1) do
        tbl2[i] = createDelayedTask(value, i, function(arg2)
            Analytics.reportPageHeartbeat(arg2, arg1)
        end)
    end
end

return module
