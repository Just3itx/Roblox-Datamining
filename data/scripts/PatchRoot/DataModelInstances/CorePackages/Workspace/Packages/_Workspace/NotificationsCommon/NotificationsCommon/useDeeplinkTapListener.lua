-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:21:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NotificationsCommon = script:FindFirstAncestor("NotificationsCommon")
local NotificationsCommonParent = NotificationsCommon.Parent
local React = require(NotificationsCommonParent.React)

local DeeplinkTapListeners = require(NotificationsCommon.DeeplinkTapListeners)

local function useDeeplinkTapListener(current)
    local var1 = React.useRef(current)

    React.useLayoutEffect(function()
        var1.current = current
    end, { current })

    React.useEffect(function()
        return DeeplinkTapListeners.connect(function(arg2)
            var1.current(arg2)
        end)
    end, {})
end

return useDeeplinkTapListener
