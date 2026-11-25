-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:20:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCommon = script:FindFirstAncestor("SocialCommon")
local SocialCommonParent = SocialCommon.Parent

local React = require(SocialCommonParent.React)
local ReactRoblox = require(SocialCommonParent.Dev.ReactRoblox)
local RoactRodux = require(SocialCommonParent.RoactRodux)
local Rodux = require(SocialCommonParent.Rodux)
local Foundation = require(SocialCommonParent.Foundation)
local Localization = require(SocialCommonParent.Localization)
local UnitTestHelpers = require(SocialCommonParent.Dev.UnitTestHelpers)
local SocialTestHelpers = require(SocialCommonParent.Dev.SocialTestHelpers)

local FoundationProvider = Foundation.FoundationProvider
local LocalizationProvider = Localization.LocalizationProvider
local LocalizationRoactContext = Localization.LocalizationRoactContext
local createStyleProvider = UnitTestHelpers.createStyleProvider
local mockLocale = SocialTestHelpers.StoryHelpers.mockLocale

local store = Rodux.Store.new(function<T>(arg1: T): T
    return arg1
end, {
    ScreenSize = Vector2.new(390, 844)
}, { Rodux.thunkMiddleware })

local function withTolerantLocalization(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return function(arg2)
        local var1 = React.useContext(LocalizationRoactContext)

        local localization = React.useMemo(function()
            return (setmetatable({
                Format = function(_, arg3, arg4)
                    local success, result = pcall(function()
                        return var1:Format(arg3, arg4)
                    end)
                    if success then
                        return result
                    end

                    return `\194\171{arg3}\194\187`
                end
            }, { __index = var1 }))
        end, { var1 })

        return React.createElement(LocalizationProvider, { localization = localization }, { Story = React.createElement(arg1, arg2) })
    end
end

return {
    name = "SocialCommon",
    storyRoots = { SocialCommon },
    roact = React,
    reactRoblox = ReactRoblox,
    mapStory = function(arg1)
        local func1 = withTolerantLocalization(arg1)

        return function(arg2)
            return React.createElement(
                FoundationProvider,
                {
                    device = "Phone",
                    colorMode = if arg2 and arg2.theme == "Light" then "Light" else "Dark"
                },
                {
                    Store = React.createElement(
                        RoactRodux.StoreProvider,
                        { store = store },
                        {
                            Style = createStyleProvider({ Localization = mockLocale(func1, arg2) })
                        }
                    )
                }
            )
        end
    end
}
