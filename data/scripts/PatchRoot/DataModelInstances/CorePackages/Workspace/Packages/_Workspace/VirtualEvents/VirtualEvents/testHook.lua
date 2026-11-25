-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:11:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local React = require(VirtualEvents.Parent.React)
local ReactRoblox = require(VirtualEvents.Parent.ReactRoblox)
local withMockProviders = require(VirtualEvents.withMockProviders)

local function testHook(callback: (...any) -> (...any))
    local screenGui = Instance.new("ScreenGui")
    local root = ReactRoblox.createRoot(screenGui)

    local var1 = withMockProviders({
        HookTester = React.createElement(function() -- name: HookTester
            callback()
            return nil
        end)
    })
    ReactRoblox.act(function()
        root:render(var1)
    end)
end

return testHook
