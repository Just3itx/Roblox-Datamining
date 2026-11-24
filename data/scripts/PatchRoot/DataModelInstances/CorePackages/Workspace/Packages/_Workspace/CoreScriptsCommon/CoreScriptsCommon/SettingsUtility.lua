-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:10:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return {
    CreateSignal = function()
        local module = {}

        local bindableEvent = Instance.new("BindableEvent")

        local var1 = nil
        local var2 = nil

        function module.fire(_, ...)
            var1 = { ... }
            local select = select
            var2 = select("#", ...)
            bindableEvent:Fire()
        end

        function module.connect(_, callback): RBXScriptConnection
            if not callback then
                error("connect(nil)", 2)
            end
            return bindableEvent.Event:Connect(function()
                callback(unpack(var1, 1, var2))
            end)
        end

        return module
    end
}
