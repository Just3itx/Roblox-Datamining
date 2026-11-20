-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:41:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewRecyclerRoblox = script:FindFirstAncestor("ViewRecyclerRoblox")
local _ViewRecycler = require(ViewRecyclerRoblox.Parent.ViewRecycler)

local module = {}

function module.new(callback: (...any) -> (...any), func1: ((...any) -> (...any))?)
    local var1 = func1 or task.defer
    local var2 = nil
    local bool1 = true

    local function cancelPending() -- Luacid: Inlined by compiler; 1 call site recovered
        var2 = nil
    end

    return {
        add = function(arg1)
            if not bool1 then
                return
            end
            local tbl1 = var2
            if tbl1 == nil then
                tbl1 = {}
                var2 = tbl1
                var1(function()
                    if bool1 and var2 == tbl1 then
                        var2 = nil
                        callback(tbl1)
                    end
                end)
            end
            table.insert(tbl1, arg1)
        end,
        flush = function()
            local var3 = var2
            if not bool1 or var3 == nil then
                return nil
            end
            var2 = nil
            callback(var3)
            return var3
        end,
        cancelPending = cancelPending,
        destroy = function()
            bool1 = false
            cancelPending()
        end
    }
end

return module
