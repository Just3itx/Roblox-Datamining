-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarWorkshopParent = script:FindFirstAncestor("AvatarWorkshop").Parent

local _React = require(AvatarWorkshopParent.React)
local ReactTestingLibrary = require(AvatarWorkshopParent.Dev.ReactTestingLibrary)

local render = ReactTestingLibrary.render
local act = ReactTestingLibrary.act

local CoreGui = game:GetService("CoreGui")

local tbl1 = {}

return {
    render = function(arg1, num1: number?, num2: number?) -- name: renderOnScreen
        local screenGui = Instance.new("ScreenGui")
        screenGui.Parent = CoreGui
        table.insert(tbl1, screenGui)

        local frame = Instance.new("Frame")
        frame.Size = UDim2.fromOffset(num1 or 1000, num2 or 600)
        frame.Parent = screenGui

        local var1 = render(arg1, { container = frame })

        act(function()
            task.wait()
        end)
        act(function()
            task.wait()
        end)

        return var1
    end,
    cleanup = function()
        for _, value in tbl1 do
            value:Destroy()
        end
        table.clear(tbl1)
    end
}
