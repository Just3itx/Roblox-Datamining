-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:40:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SystemScrimParent = script:FindFirstAncestor("SystemScrim").Parent
local React = require(SystemScrimParent.React)
local SignalsReact = require(SystemScrimParent.SignalsReact)

local function SystemScrim(tbl1)
    local var1 = SignalsReact.useSignalState(tbl1.store.autoDismiss)

    local var2 = React.useCallback(function()
        tbl1.store.backgroundScrimActivated:Fire()

        if var1 then
            tbl1.store.setVisibility(false)
        end
    end, { var1 })

    local var3 = SignalsReact.useSignalState(tbl1.store.visible)
    local backgroundTransparency = SignalsReact.useSignalBinding(tbl1.store.transparency)

    if not var3 then
        return nil
    end

    return (React.createElement("TextButton", {
        Size = UDim2.fromScale(1, 1),
        Visible = true,
        BackgroundTransparency = backgroundTransparency,
        BackgroundColor3 = Color3.new(0, 0, 0),
        Text = "",
        AutoButtonColor = false,
        BorderSizePixel = 0,
        [React.Event.Activated] = var2
    }))
end

return SystemScrim
