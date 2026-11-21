-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfileParent = script:FindFirstAncestor("EditProfile").Parent
local React = require(EditProfileParent.React)
local Foundation = require(EditProfileParent.Foundation)
local Snackbar = Foundation.Snackbar
local Enums = Foundation.Enums

local function EditProfileToast(tbl1)
    local var1, var2 = React.useState(true)

    local var3 = React.useRef(nil)
    React.useEffect(function()
        if var3.current then
            task.cancel(var3.current)
        end

        var3.current = task.delay(5, function()
            var2(false)
        end)

        return function()
            if var3.current then
                task.cancel(var3.current)
                var3.current = nil
            end
        end
    end, {})

    if not var1 then
        return nil
    end

    return React.createElement(Snackbar, {
        title = tbl1.text,
        icon = {
            name = Enums.IconName.CircleCheck,
            variant = Enums.IconVariant.Filled
        },
        Position = UDim2.new(0.5, 0, 0, 50),
        AnchorPoint = Vector2.new(0.5, 0)
    })
end

return EditProfileToast
