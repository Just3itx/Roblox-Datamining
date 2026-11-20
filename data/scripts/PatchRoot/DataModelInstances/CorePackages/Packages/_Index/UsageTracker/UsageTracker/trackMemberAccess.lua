-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:51:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UsageTrackerParent = script:FindFirstAncestor("UsageTracker").Parent
local Cryo = require(UsageTrackerParent.Cryo)

local isReactComponent = require(script.Parent.isReactComponent)
local UsageGraph = require(script.Parent.UsageGraph)

local function trackMemberAccess(str1: string, tbl1, func1: ((...any) -> (...any))?)
    local tbl2 = ({})
    local tbl3 = ({})

    local var1 = func1 or isReactComponent

    local function wrap(str2: string, tbl4)
        local tbl5 = ({})
        local tbl6 = ({})

        for value, value2 in tbl4 do
            if value == "__index" or typeof(value) ~= "string" then
                continue
            end

            local var2 = str2 .. "." .. value
            if var1(value2) then
                tbl2[var2] = {}
                tbl5[value] = value2
            elseif typeof(value2) == "table" and not tbl3[value2] then
                tbl6[value] = wrap(var2, value2)
            else
                tbl6[value] = value2
            end

            tbl3[value2] = true
        end

        return (setmetatable(tbl6, {
            __index = function(_, arg1)
                local var2 = tbl5[arg1]
                if not var2 then
                    return rawget(tbl6, arg1)
                end
                local var3 = str2 .. "." .. arg1
                local dmPath, lineNumber = debug.info(2, "sl")
                tbl2[var3] = Cryo.List.join(tbl2[var3], {{ dmPath = dmPath, lineNumber = lineNumber }})

                return var2
            end
        }))
    end

    local var2 = wrap(str1, tbl1)
    var2[UsageGraph.UsageGraphKey] = tbl2

    return var2
end

return trackMemberAccess
