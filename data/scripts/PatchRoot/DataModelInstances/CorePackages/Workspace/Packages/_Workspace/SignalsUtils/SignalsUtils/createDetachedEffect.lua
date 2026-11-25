-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local createEffect = require(scriptParentParent.Signals).createEffect

local function createDetachedEffect(callback: (...any) -> (...any))
    local bool1 = false
    local var1 = nil

    local function disposeEffect()
        if bool1 then
            return
        end

        bool1 = true
        if var1 ~= nil then
            var1:Fire()
        end
    end

    local effect = createEffect(function(arg1)
        callback(arg1, disposeEffect)
    end)

    if bool1 then
        effect()
        return
    end
    local bindableEvent = Instance.new("BindableEvent")
    var1 = bindableEvent
    bindableEvent.Event:Once(function()
        bindableEvent:Destroy()
        var1 = nil
        effect()
    end)
end

return createDetachedEffect
