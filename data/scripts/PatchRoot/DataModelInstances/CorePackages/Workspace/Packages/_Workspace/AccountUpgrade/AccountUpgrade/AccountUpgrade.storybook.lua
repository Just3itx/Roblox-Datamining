-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:31:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AccountUpgrade = script:FindFirstAncestor("AccountUpgrade")
local AccountUpgradeParent = AccountUpgrade.Parent

local Foundation = require(AccountUpgradeParent.Foundation)
local React = require(AccountUpgradeParent.React)
local ReactRoblox = require(AccountUpgradeParent.ReactRoblox)
local Http = require(AccountUpgradeParent.Dev.Http)
local mockHttpResponse = require(AccountUpgradeParent.Dev.UnitTestHelpers).mockHttpResponse
local Promise = require(AccountUpgradeParent.Promise)
local RoactNetworking = require(AccountUpgradeParent.RoactServiceTags).RoactNetworking
local mockServices = require(AccountUpgradeParent.Dev.AuthTestHelpers).TestHelpers.mockServices

local FoundationProvider = Foundation.FoundationProvider
local ColorMode = Foundation.Enums.ColorMode
local Device = Foundation.Enums.Device

local StatusCodes = Http.StatusCodes

local function validationEndpoint(str1: string)
    return Promise.resolve(mockHttpResponse.new(str1, { code = 0 }, 0, StatusCodes.OK))
end

local tbl1 = {
    Default = { themeName = "Dark", fontName = "Gotham" },
    Dark = { themeName = "Dark", fontName = "Gotham" },
    Light = { themeName = "Light", fontName = "Gotham" }
}

local tbl2 = {
    Default = ColorMode.Dark,
    Dark = ColorMode.Dark,
    Light = ColorMode.Light
}

local tbl3 = {
    Default = "Desktop",
    Desktop = "Desktop",
    Phone = "Phone",
    Tablet = "Tablet",
    Console = "Console"
}

return {
    name = "AccountUpgrade",
    roact = React,
    reactRoblox = ReactRoblox,
    mapStory = function(arg1)
        return function(arg2)
            local var1 = arg2 and tbl1[arg2.theme] or tbl1.Default
            local deviceType = arg2 and tbl3[arg2.platform] or "Desktop"
            local colorMode = arg2 and tbl2[arg2.theme] or tbl2.Default

            return mockServices({
                FoundationProvider = React.createElement(
                    FoundationProvider,
                    {
                        colorMode = colorMode,
                        device = arg2 and Device[arg2.platform] or Device.Desktop,
                        overlayGui = arg2 and arg2.focus
                    },
                    {
                        Story = React.createElement(arg1, arg2)
                    }
                )
            }, {
                includeStoreProvider = true,
                appStyle = {
                    themeName = var1.themeName,
                    fontName = var1.fontName,
                    deviceType = deviceType
                },
                extraServices = {
                    [RoactNetworking] = validationEndpoint
                }
            })
        end
    end,
    storyRoots = { AccountUpgrade }
}
