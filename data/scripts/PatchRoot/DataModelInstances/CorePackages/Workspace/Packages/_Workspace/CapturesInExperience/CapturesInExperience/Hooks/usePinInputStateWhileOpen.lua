-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:00:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local scriptParentParentParent = script.Parent.Parent.Parent

local React = require(scriptParentParentParent.React)

local Default = Enum.MouseBehavior.Default

return function(bool1: boolean?, bool2: boolean?)
    React.useEffect(function()
        if not bool1 then
            return
        end

        local var1 = if bool2 ~= nil then bool2 else UserInputService
        local tbl1 = {
            MouseBehavior = var1.MouseBehavior,
            MouseIconEnabled = var1.MouseIconEnabled,
            MouseIcon = var1.MouseIcon
        }

        local function pin(str1: string, arg1) -- Luacid: Inlined by compiler; 6 call sites recovered
            var1[str1] = arg1
        end

        pin("MouseBehavior", Default)
        pin("MouseIconEnabled", true)
        pin("MouseIcon", "")
        local mouseBehavior = Default
        local str1 = "MouseBehavior"

        local connection = var1:GetPropertyChangedSignal("MouseBehavior"):Connect(function()
            local var2 = var1[str1]
            if var2 ~= mouseBehavior then
                tbl1[str1] = var2
                pin(str1, mouseBehavior)
            end
        end)

        local str2 = "MouseIconEnabled"
        local bool3 = true

        local tbl2 = {
            connection,
            var1:GetPropertyChangedSignal("MouseIconEnabled"):Connect(function()
                local var2 = var1[str2]
                if var2 ~= bool3 then
                    tbl1[str2] = var2
                    pin(str2, bool3)
                end
            end),
            (function(str3: string, str4: string) -- name: watch
                return var1:GetPropertyChangedSignal(str3):Connect(function()
                    local var2 = var1[str3]
                    if var2 ~= str4 then
                        tbl1[str3] = var2
                        pin(str3, str4)
                    end
                end)
            end)("MouseIcon", "")
        }

        return function()
            for _, value in tbl2 do
                value:Disconnect()
            end
            var1.MouseBehavior = tbl1.MouseBehavior
            var1.MouseIconEnabled = tbl1.MouseIconEnabled
            var1.MouseIcon = tbl1.MouseIcon
        end
    end, { bool1, bool2 })
end
