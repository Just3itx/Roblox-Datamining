-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:31:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SystemParent = script:FindFirstAncestor("System").Parent
local Signals = require(SystemParent.Signals)
local createSignal = Signals.createSignal
local createEffect = Signals.createEffect

local module = {}
module.__index = module

function module.new(tbl1)
    local self = (setmetatable({}, module))
    local defaultVisible, defaultEnabled

    if tbl1 then
        defaultVisible = tbl1.defaultVisible
        defaultEnabled = tbl1.defaultEnabled
    else
        defaultVisible = false
        defaultEnabled = false
    end

    local getVisible, setVisible = createSignal(defaultVisible)
    local getEnabled, setEnabled = createSignal(defaultEnabled)

    self.getVisible = getVisible
    self.setVisible = setVisible
    self.getEnabled = getEnabled
    self.setEnabled = setEnabled

    local tbl2 = {}
    local tbl3 = {}

    local effect = createEffect(function(arg1)
        local var5 = getVisible(arg1)
        if not self.getEnabled(false) then
            return
        end

        for _, value in tbl2 do
            local var6 = value(var5)
            if type(var6) == "boolean" and var6 ~= var5 then
                setVisible(var6)
                return
            end
        end
    end)

    local effect2 = createEffect(function(arg1)
        local var5 = getEnabled(arg1)
        for _, value in tbl3 do
            value(var5)
        end
    end)

    function self.dispose(_)
        effect()
        effect2()
    end

    function self.onVisibilityChanged(_, func1: (...any) -> (...any))
        table.insert(tbl2, func1)

        return function()
            local var5 = table.find(tbl2, func1)
            if var5 then
                table.remove(tbl2, var5)
            end
        end
    end

    function self.onEnabledChanged(_, callback: (...any) -> (...any))
        table.insert(tbl3, callback)
        callback(getEnabled(false))
        return function()
            local var5 = table.find(tbl3, callback)
            if var5 then
                table.remove(tbl3, var5)
            end
        end
    end

    return self
end

return module
