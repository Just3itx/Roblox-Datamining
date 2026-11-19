-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:21:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local _RobloxGui = CoreGui:WaitForChild("RobloxGui")

local React = require(CorePackages.Packages.React)
local UIBlox = require(CorePackages.Packages.UIBlox)
local withTooltip = UIBlox.App.Dialog.TooltipV2.withTooltip
local TooltipOrientation = UIBlox.App.Dialog.Enum.TooltipOrientation
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local Promise = require(CorePackages.Packages.Promise)

return function(arg1)
    local active, var2 = React.useState(true)

    local fallbackText = arg1.fallbackText
    pcall(function()
        fallbackText = RobloxTranslator:FormatByKey(arg1.translationKey)
    end)

    local tbl1 = {
        textAlignment = Enum.TextXAlignment.Left,
        bodyText = fallbackText
    }
    local tbl2 = {
        active = active,
        guiTarget = CoreGui,
        DisplayOrder = 10,
        preferredOrientation = TooltipOrientation.Left
    }

    local connection = nil
    local function func1() -- Luacid: Inlined by compiler; 2 call sites recovered
        var2(false)
        if connection then
            connection:Disconnect()
            connection = nil
        end
    end

    connection = UserInputService.InputBegan:Connect(function(input: InputObject)
        local userInputType = input.UserInputType
        if userInputType == Enum.UserInputType.MouseButton1 or userInputType == Enum.UserInputType.Touch then
            func1()
        end
    end)

    Promise.delay(arg1.tooltipLifetime):andThen(function()
        func1()
    end)

    return withTooltip(tbl1, tbl2, function(callback)
        local function func2(arg2)
            callback(arg2)
        end
        return React.createElement("Frame", {
            Visible = false,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            [React.Change.AbsoluteSize] = func2,
            [React.Change.AbsolutePosition] = func2
        })
    end)
end
