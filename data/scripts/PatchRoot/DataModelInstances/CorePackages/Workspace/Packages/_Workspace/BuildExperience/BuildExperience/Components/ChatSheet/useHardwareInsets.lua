-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:41:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local GuiService = game:GetService("GuiService")
local React = require(BuildExperienceParent.React)

local function getHardwareSafeAreaInsets()
    local rect = GuiService:GetInsetArea(Enum.ScreenInsets.DeviceSafeInsets)
    local rect2 = GuiService:GetInsetArea(Enum.ScreenInsets.None)

    return {
        left = rect.Min.X - rect2.Min.X,
        top = rect.Min.Y - rect2.Min.Y,
        right = rect2.Max.X - rect.Max.X,
        bottom = rect2.Max.Y - rect.Max.Y
    }
end

local function useHardwareInsets(arg1)
    local var1, var2 = React.useState(getHardwareSafeAreaInsets)

    React.useEffect(function()
        local connection = if arg1 then arg1:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
            var2(function(arg2)
                local hardwareSafeAreaInsets = getHardwareSafeAreaInsets()

                return if hardwareSafeAreaInsets.bottom == arg2.bottom
                    and hardwareSafeAreaInsets.top == arg2.top
                    and hardwareSafeAreaInsets.left == arg2.left
                    and hardwareSafeAreaInsets.right == arg2.right then arg2 else hardwareSafeAreaInsets
            end)
        end) else nil

        return function()
            if connection then
                connection:Disconnect()
            end
        end
    end, { arg1 })

    return var1
end

return useHardwareInsets
