-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:11:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Wrappers = require(Foundation.Utility.Wrappers)
local isPluginSecurity = require(Foundation.Utility.isPluginSecurity)
local Connection = Wrappers.Connection
local Instance = Wrappers.Instance
local Signal = Wrappers.Signal
local GuiService = Wrappers.Services.GuiService
local UserInputService = Wrappers.Services.UserInputService

local function getGuiInset(): Rect
    local min, max = GuiService:GetGuiInset()

    return Rect.new(min, max)
end

local function useGuiInset()
    local var1, var2 = React.useState(function(): Rect
        return getGuiInset()
    end)

    local var3 = React.useCallback(function()
        var2(getGuiInset())
    end, {})

    React.useEffect(function()
        local tbl1 = {}

        tbl1 = isPluginSecurity()
            and { Signal.Connect(GuiService.SafeZoneOffsetsChanged, var3), Signal.Connect(Instance.GetPropertyChangedSignal(UserInputService, "BottomBarSize"), var3), Signal.Connect(Instance.GetPropertyChangedSignal(UserInputService, "RightBarSize"), var3) }
            or tbl1

        return function()
            for _, value in tbl1 do
                Connection.Disconnect(value)
            end
        end
    end, {})

    return var1
end

return useGuiInset
