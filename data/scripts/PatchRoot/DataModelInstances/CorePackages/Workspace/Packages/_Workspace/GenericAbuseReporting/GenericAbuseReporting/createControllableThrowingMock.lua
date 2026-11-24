-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:51:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent

local React = require(GenericAbuseReportingParent.React)

local function createControllableThrowingMock()
    local tbl1 = { mode = nil, renderCount = 0 }

    return {
        reset = function()
            tbl1.mode = nil
            tbl1.renderCount = 0
        end,
        setMode = function(mode: string?)
            tbl1.mode = mode
        end,
        wrap = function(func1: (...any) -> (...any))
            return function(arg1)
                local tbl2 = tbl1
                tbl2.renderCount += 1
                local renderCount = tbl1.renderCount

                local _, var1 = React.useState(0)
                React.useEffect(function()
                    if tbl1.mode == "afterFirst" and renderCount == 1 then
                        var1(1)
                    end
                end, { renderCount })

                if tbl1.mode == "always" then
                    error("simulated render error (pre-handle)")
                elseif tbl1.mode == "afterFirst" and renderCount > 1 then
                    error("simulated render error (post-handle)")
                end

                return func1(arg1)
            end
        end
    }
end

return createControllableThrowingMock
