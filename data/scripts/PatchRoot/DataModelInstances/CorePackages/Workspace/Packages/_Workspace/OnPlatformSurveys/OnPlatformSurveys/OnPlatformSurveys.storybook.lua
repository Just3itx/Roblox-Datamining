-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:51:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local OnPlatformSurveys = script:FindFirstAncestor("OnPlatformSurveys")
local OnPlatformSurveysParent = OnPlatformSurveys.Parent

local React = require(OnPlatformSurveysParent.React)
local ReactRoblox = require(OnPlatformSurveysParent.Dev.ReactRoblox)

local Foundation = require(OnPlatformSurveysParent.Foundation)
local FoundationProvider = Foundation.FoundationProvider
local ColorMode = Foundation.Enums.ColorMode
local Device = Foundation.Enums.Device

local MockProviders = require(OnPlatformSurveys.MockProviders)

local tbl1 = {
    Dark = ColorMode.Dark,
    Light = ColorMode.Light
}

local function union(tbl2, tbl3) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = table.clone(tbl2)
    if tbl3 then
        for value, value2 in tbl3 do
            var1[value] = value2
        end
    end
    return var1
end

return {
    roact = React,
    reactRoblox = ReactRoblox,
    mapStory = function(arg1)
        return function(arg2)
            local var1 = not arg2.definition and {} or arg2.definition.props or {}
            local var2 = union(arg2, false)
            if var1 then
                for value, value2 in var1 do
                    var2[value] = value2
                end
            end

            return React.createElement(MockProviders, {}, {
                FoundationProvider = React.createElement(FoundationProvider, {
                    colorMode = tbl1[arg2.theme] or ColorMode.Dark,
                    device = Device[arg2.platform] or Device.Phone,
                    preferences = arg2.settings,
                    overlayGui = arg2.focus
                }, {
                    story = React.createElement(arg1, var2)
                })
            })
        end
    end,
    storyRoots = { OnPlatformSurveys }
}
