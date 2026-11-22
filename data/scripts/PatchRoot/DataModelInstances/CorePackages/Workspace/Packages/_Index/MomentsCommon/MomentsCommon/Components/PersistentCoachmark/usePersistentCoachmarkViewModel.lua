-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:01:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _createCoachmarkImpressionCache = require(scriptParentParentParent.Utils.createCoachmarkImpressionCache)
local scriptParentParentParentParent = scriptParentParentParent.Parent
local React = require(scriptParentParentParentParent.React)

local function usePersistentCoachmarkViewModel(tbl1)
    local impressionCache = tbl1.impressionCache
    local onSessionHandled = tbl1.onSessionHandled
    local autoDismissSeconds = tbl1.autoDismissSeconds

    local var1 = React.useMemo(function(): boolean
        if tbl1.isSessionHandled then
            return false
        end
        local value = impressionCache.getValue()
        return value >= 0 and value < tbl1.maxImpressions
    end, {})

    local isOpen, var3 = React.useState(var1)
    local var4 = React.useRef(false)
    local var5 = React.useRef(nil)

    React.useEffect(function()
        if not var1 or var4.current then
            return
        end

        var4.current = true
        impressionCache.incrementValue()
        onSessionHandled()
        if tbl1.onImpression ~= nil then
            tbl1.onImpression()
        end
    end, {})

    React.useEffect(function()
        if not isOpen or autoDismissSeconds == nil then
            return
        end

        var5.current = task.delay(autoDismissSeconds, function()
            var3(false)
        end)

        return function()
            if var5.current ~= nil then
                task.cancel(var5.current)
                var5.current = nil
            end
        end
    end, { isOpen, autoDismissSeconds })

    return {
        isOpen = isOpen,
        onClose = React.useCallback(function()
            impressionCache.dismissValue()
            if tbl1.onDismissed ~= nil then
                tbl1.onDismissed()
            end
            var3(false)
        end, {})
    }
end

return usePersistentCoachmarkViewModel
