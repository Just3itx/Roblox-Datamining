-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:40:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")

local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent

local FoundationProvider = require(scriptParentParentParent.Foundation).FoundationProvider

local Roact = require(scriptParentParentParent.Roact)

local dumpInstanceTree = require(scriptParent.dumpInstanceTree)

local function TestApp(arg1)
    return Roact.createElement("ScreenGui", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, arg1[Roact.Children])
end

local function testWithComponent(testComponent, callback)
    local element = Roact.createElement(
        TestApp,
        nil,
        {
            FoundationProvider = Roact.createElement(FoundationProvider, { theme = "Dark" }, { TestComponent = testComponent })
        }
    )
    local name = ("TestApp-%s"):format(HttpService:GenerateGUID(false))
    local var1 = Roact.mount(element, CoreGui, name)
    local str1 = ("game.CoreGui.%s.TestComponent"):format(name)

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

return testWithComponent
