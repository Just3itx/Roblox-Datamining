-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:10:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Rodux = require(script.Parent.Rodux)
local Cryo = require(script.Parent.Parent.Cryo)
local buildActionName = require(script.Parent.buildActionName)

return function(arg1)
    return function()
        local createReducer = Rodux.createReducer
        local tbl1 = {}
        tbl1[buildActionName(arg1)] = function(arg2, tbl2)
            local tbl3 = {}
            if #tbl2.ids == 0 then
                tbl3[tbl2.keymapper()] = tbl2.status
            else
                for _, value in ipairs(tbl2.ids) do
                    tbl3[tbl2.keymapper(value)] = tbl2.status
                end
            end

            return Cryo.Dictionary.join(arg2, tbl3)
        end

        return createReducer({}, tbl1)
    end
end
