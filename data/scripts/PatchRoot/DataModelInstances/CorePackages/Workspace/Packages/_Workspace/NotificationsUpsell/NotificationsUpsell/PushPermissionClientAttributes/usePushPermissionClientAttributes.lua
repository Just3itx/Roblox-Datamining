-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NotificationsUpsellParent = script:FindFirstAncestor("NotificationsUpsell").Parent

local React = require(NotificationsUpsellParent.React)

local buildPushPermissionClientAttributes = require(script.Parent.buildPushPermissionClientAttributes)

local function usePushPermissionClientAttributes()
    local var1, var2 = React.useState(nil)

    React.useEffect(function()
        local bool1 = true
        buildPushPermissionClientAttributes.build():andThen(function(tbl1)
            if bool1 then
                var2(tbl1)
            end
        end)

        return function()
            bool1 = false
        end
    end, {})

    return var1
end

return usePushPermissionClientAttributes
