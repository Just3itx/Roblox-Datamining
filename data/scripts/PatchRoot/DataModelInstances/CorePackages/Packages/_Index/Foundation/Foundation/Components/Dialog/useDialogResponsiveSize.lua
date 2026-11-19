-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:50:58Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local React = require(FoundationParent.React)

local _DialogSize = require(Foundation.Enums.DialogSize)

local useOverlay = require(Foundation.Providers.Overlay.useOverlay)
local useTokens = require(Foundation.Providers.Style.useTokens)

local getResponsiveSize = require(script.Parent.getResponsiveSize)
local useDialog = require(script.Parent.useDialog)

local function useDialogResponsiveSize(arg1)
    local var1 = useTokens()
    local var2 = useOverlay()
    local var3 = useDialog()

    local var4 = React.useCallback(function()
        if not var2 then
            return
        end
        var3.setResponsiveSize(getResponsiveSize(var2.AbsoluteSize.X, arg1, var1))
    end, {
        var2,
        arg1,
        var1,
        var3.size
    })
    React.useLayoutEffect(function()
        if not var2 then
            return
        end

        var4()

        local connection = var2:GetPropertyChangedSignal("AbsoluteSize"):Connect(var4)

        return function()
            connection:Disconnect()
        end
    end, { var2, arg1, var4 })
end

return useDialogResponsiveSize
