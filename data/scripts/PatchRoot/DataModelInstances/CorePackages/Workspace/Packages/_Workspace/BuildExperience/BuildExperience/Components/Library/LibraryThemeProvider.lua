-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:51:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local useSelectedTheme = require(BuildExperienceParent.RoactUtils).Hooks.useSelectedTheme

local UserGameSettings = UserSettings():GetService("UserGameSettings")

local function useReducedMotion()
    local var1, var2 = React.useState(UserGameSettings.ReducedMotion)
    React.useEffect(function()
        var2(UserGameSettings.ReducedMotion)
        local connection = UserGameSettings:GetPropertyChangedSignal("ReducedMotion"):Connect(function()
            var2(UserGameSettings.ReducedMotion)
        end)
        return function()
            connection:Disconnect()
        end
    end, {})
    return var1
end

local function LibraryThemeProvider(tbl1)
    local var1 = useSelectedTheme()
    local reducedMotion = useReducedMotion()
    return React.createElement(Foundation.FoundationProvider, {
        colorMode = if var1 == "light" then Foundation.Enums.ColorMode.Light else Foundation.Enums.ColorMode.Dark,
        overlayGui = {
            DisplayOrder = tbl1.displayOrder
        },
        preferences = { reducedMotion = reducedMotion }
    }, tbl1.children)
end

return LibraryThemeProvider
