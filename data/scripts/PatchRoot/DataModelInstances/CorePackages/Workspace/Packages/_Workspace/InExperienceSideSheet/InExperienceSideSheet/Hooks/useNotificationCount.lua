-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:31:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceSideSheetParent = script:FindFirstAncestor("InExperienceSideSheet").Parent

local _Chrome = require(InExperienceSideSheetParent.Chrome)
local React = require(InExperienceSideSheetParent.React)

local function useNotificationCount(arg1)
    local var1, var2 = React.useState(not arg1:isEmpty())
    local var3, var4 = React.useBinding(arg1:get().value or 0)

    React.useEffect(function()
        arg1:connect(function(arg2)
            if arg1:isEmpty() then
                var2(false)
                return
            end
            var4(math.min(arg2.value, 99))
            var2(true)
        end)
    end, { arg1 })

    return var1, var3
end

return useNotificationCount
