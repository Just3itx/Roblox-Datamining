-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:40:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")

local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Roact = require(scriptParentParentParent.Roact)
local dumpInstanceTree = require(scriptParent.dumpInstanceTree)

local mockStyleComponent = require(scriptParentParent.Utility.mockStyleComponent)

local function testWithStyledComponent(arg1, arg2, callback)
    local element = Roact.createElement(
        "ScreenGui",
        {
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        },
        {
            StyleProvider = mockStyleComponent({ TestComponent = Roact.createElement(arg1, arg2) })
        }
    )

    local name = ("TestApp-%s"):format(HttpService:GenerateGUID())
    local var1 = Roact.mount(element, CoreGui, name)
    local str1 = ("game.CoreGui.%s.Children.TestComponent"):format(name)

    local success, result = pcall(function()
        callback(str1)
    end)

    if not success then
        print("Test instance tree:")
        dumpInstanceTree(CoreGui:FindFirstChild(name))
        print("Test instance tree end\n")
    end

    Roact.unmount(var1)

    if not success then
        error(result)
    end
end

return testWithStyledComponent
