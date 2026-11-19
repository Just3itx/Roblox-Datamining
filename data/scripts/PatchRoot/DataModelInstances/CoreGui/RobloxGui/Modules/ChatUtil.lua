-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:21:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.Signal()
    local module2 = {}

    local bindableEvent = Instance.new("BindableEvent")

    local var1 = nil
    local var2 = nil

    function module2.fire(_, ...)
        var1 = { ... }
        local select = select
        var2 = select("#", ...)
        bindableEvent:Fire()
    end

    function module2.connect(_, callback): RBXScriptConnection
        if not callback then
            error("connect(nil)", 2)
        end

        return bindableEvent.Event:connect(function()
            callback(unpack(var1, 1, var2))
        end)
    end

    function module2.wait(_)
        bindableEvent.Event:wait()
        assert(var1, "Missing arg data, likely due to :TweenSize/Position corrupting threadrefs.")
        return unpack(var1, 1, var2)
    end

    return module2
end

return module
