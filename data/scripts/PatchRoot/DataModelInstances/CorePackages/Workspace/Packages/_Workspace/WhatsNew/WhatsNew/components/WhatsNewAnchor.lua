-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T23:00:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local WhatsNew = script:FindFirstAncestor("WhatsNew")
local WhatsNewParent = WhatsNew.Parent

local Foundation = require(WhatsNewParent.Foundation)
local React = require(WhatsNewParent.React)
local GetWhatsNewStore = require(WhatsNew.store.GetWhatsNewStore)

local View = Foundation.View

local function isGuiObjectReady(arg1): boolean -- Luacid: unused: defined but never referenced
    local absoluteSize = arg1.AbsoluteSize
    return absoluteSize.X > 0 and absoluteSize.Y > 0
end

return React.memo(function(tbl1) -- name: WhatsNewAnchor
    local whatsNewStore = GetWhatsNewStore()
    local anchorId = tbl1.anchorId
    local var1 = React.useRef(nil)

    local var2 = React.useCallback(function(arg1)
        if arg1 == nil then
            return
        end
        local setAnchorReady = whatsNewStore.setAnchorReady
        local var2 = anchorId
        local absoluteSize = arg1.AbsoluteSize

        setAnchorReady(var2, absoluteSize.X > 0 and absoluteSize.Y > 0, arg1)
    end, { whatsNewStore, anchorId })

    local ref = React.useCallback(function(current)
        if current == nil then
            local current2 = var1.current
            var1.current = nil
            if current2 ~= nil then
                whatsNewStore.unregisterAnchor(anchorId, current2)
            end
            return
        end
        var1.current = current
        whatsNewStore.registerAnchor(anchorId, current)
        if whatsNewStore.getAnchorRef(anchorId) == current then
            var2(current)
        end
    end, { whatsNewStore, anchorId, var2 })

    React.useEffect(function()
        return function()
            whatsNewStore.unregisterAnchor(anchorId, var1.current)
        end
    end, { whatsNewStore, anchorId })

    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        var2(arg1)
    end, { var2 })

    return React.createElement(View, {
        ref = ref,
        tag = tbl1.tag or "size-full-0 auto-y",
        LayoutOrder = tbl1.LayoutOrder,
        onAbsoluteSizeChanged = onAbsoluteSizeChanged
    }, tbl1.children)
end)
