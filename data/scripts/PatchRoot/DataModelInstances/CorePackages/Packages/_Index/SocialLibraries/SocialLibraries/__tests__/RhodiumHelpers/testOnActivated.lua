-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local Packages = script:FindFirstAncestor("Packages")
local Rhodium = require(Packages.Dev.Rhodium)
local Roact = require(Packages.Roact)
local Element = Rhodium.Element
local XPath = Rhodium.XPath
local mockStyle = require(script.Parent.Parent.UnitTestHelpers.mockStyle)

return function(arg1)
    local bool1 = false

    local element = Roact.createElement("ScreenGui", {}, {
        buttonElement = Roact.createElement(arg1, {
            onActivated = function()
                bool1 = true
            end
        })
    })

    local var1 = mockStyle(element)

    local var2 = Roact.mount(var1, CoreGui, "TestRoot")
    local xPath = XPath.new("game.CoreGui.Children.buttonElement")

    local element2 = Element.new(xPath)

    assert(element2:getRbxInstance() ~= nil, "button was nil")

    element2:click()

    wait(0)

    assert(bool1 == true, "button was not activated")

    Roact.unmount(var2)
end
