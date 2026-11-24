-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent

local React = require(CurrencyTransfersParent.React)
local GetFFlagCurrencyTransferFixTextBoxInput = require(CurrencyTransfers.Flags.GetFFlagCurrencyTransferFixTextBoxInput)

return function<T>(callback: (...any) -> (...any), callback2: (...any) -> (...any))
    local var1 = React.useRef(nil)

    local var2 = React.useRef(false)

    return React.useCallback(function(arg1)
        if var1.current then
            for _, value in ipairs(var1.current) do
                value:Disconnect()
            end
            var1.current = nil
        end

        if not arg1 then
            return
        end

        local current = {}

        local textChanged = arg1:GetPropertyChangedSignal("Text")

        table.insert(current, textChanged:Connect(function()
            local text = arg1.Text
            local var3 = text:gsub("%D", "")
            if var3 ~= text then
                arg1.Text = var3
            end

            if GetFFlagCurrencyTransferFixTextBoxInput() and var2.current and var3 == "" then
                return
            end

            callback(tonumber(var3))
        end))

        if callback2 then
            local focused = arg1.Focused

            table.insert(current, focused:Connect(function()
                if GetFFlagCurrencyTransferFixTextBoxInput() then
                    arg1.CursorPosition = #arg1.Text + 1
                    var2.current = true
                    task.delay(0.1, function()
                        var2.current = false
                    end)
                end
                callback2(true, false)
            end))

            local focusLost = arg1.FocusLost

            table.insert(current, focusLost:Connect(function(enterPressed: boolean)
                callback2(false, enterPressed)
            end))
        end

        var1.current = current
    end, { callback, callback2 })
end
