-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:01:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")

local React = require(CorePackages.Packages.React)

local function useSettingsHubCloseButton(func1: ((...any) -> (...any))?, bool1: boolean)
    local var1, var2 = React.useState(nil)
    local var3, var4 = React.useState(false)

    React.useEffect(function()
        local var5 = if func1 then func1() else nil
        var2(if var5 then var5.PageTitleCloseButton else nil)
    end, { func1, bool1 })

    React.useEffect(function()
        if not var1 then
            var4(false)
            return nil
        end

        local function updateIsSelected() -- Luacid: Inlined by compiler; 1 call site recovered
            var4(GuiService.SelectedCoreObject == var1)
        end

        updateIsSelected()
        local connection = GuiService:GetPropertyChangedSignal("SelectedCoreObject"):Connect(updateIsSelected)

        return function()
            connection:Disconnect()
        end
    end, { var1 })

    return var1, var3
end

return useSettingsHubCloseButton
