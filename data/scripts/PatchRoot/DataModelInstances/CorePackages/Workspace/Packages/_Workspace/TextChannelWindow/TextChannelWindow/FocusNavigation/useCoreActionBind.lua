-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:00:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local ContextActionService = game:GetService("ContextActionService")

local TextChannelWindowParent = script:FindFirstAncestor("TextChannelWindow").Parent
local React = require(TextChannelWindowParent.React)

local _SelectionInputs = require(script.Parent.SelectionInputs)

local num1 = 0

local function useCoreActionBind(tbl1)
    local var1 = tbl1.contextActionService or ContextActionService

    local var2 = React.useRef(nil)
    if var2.current == nil then
        num1 += 1
        var2.current = num1
    end
    local var3 = tbl1.actionNamePrefix .. "_" .. tostring(var2.current)

    local enabled = tbl1.enabled
    local active = tbl1.active
    local inputs = tbl1.inputs
    local onAction = tbl1.onAction
    local shouldBind = tbl1.shouldBind
    local rebindSignal = tbl1.rebindSignal

    React.useEffect(function()
        if not enabled or not active then
            return
        end

        local function handler(_: string, arg1)
            return onAction(arg1)
        end

        local connection = nil
        if shouldBind then
            local function refresh() -- Luacid: Inlined by compiler; 1 call site recovered
                if shouldBind() then
                    var1:BindCoreAction(var3, handler, false, table.unpack(inputs))
                    return
                end
                var1:UnbindCoreAction(var3)
            end

            refresh()

            if rebindSignal then
                connection = rebindSignal:Connect(refresh)
            end
        else
            var1:BindCoreAction(var3, handler, false, table.unpack(inputs))
        end

        return function()
            if connection then
                connection:Disconnect()
            end
            var1:UnbindCoreAction(var3)
        end
    end, {
        enabled,
        active,
        inputs,
        onAction,
        shouldBind,
        rebindSignal,
        var1,
        var3
    })
end

return useCoreActionBind
