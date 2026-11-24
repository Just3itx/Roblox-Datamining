-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:51:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent

local React = require(GenericAbuseReportingParent.React)

local function useScrollbarOffset(vector2: Vector2, vector2_2: Vector2): number
    local var1, var2 = React.useState(false)

    React.useEffect(function()
        if vector2.Y > vector2_2.Y then
            var2(true)
            return
        end
        var2(false)
    end, { vector2, vector2_2 })

    return if var1 then 16 else 0
end

return useScrollbarOffset
