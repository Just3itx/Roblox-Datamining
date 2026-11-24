-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:51:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShopParent = script:FindFirstAncestor("InExperienceShop").Parent

local React = require(InExperienceShopParent.React)
local ReactRoblox = require(InExperienceShopParent.ReactRoblox)
local FoundationProvider = require(InExperienceShopParent.Foundation).FoundationProvider

local function renderHookWithProviders(func1: (...any) -> (...any))
    local tbl1 = ({})
    local screenGui = Instance.new("ScreenGui")
    local root = ReactRoblox.createRoot(screenGui)

    local function TestHarness()
        tbl1.current = func1()
        return nil
    end

    ReactRoblox.act(function()
        root:render(React.createElement(FoundationProvider, { colorMode = "Dark" }, React.createElement(TestHarness)))
    end)

    local function cleanup()
        ReactRoblox.act(function()
            root:unmount()
        end)
        screenGui:Destroy()
    end

    return tbl1, cleanup
end

return renderHookWithProviders
