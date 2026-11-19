-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Packages.Roact)
local Rodux = require(CorePackages.Packages.Rodux)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local UIBlox = require(CorePackages.Packages.UIBlox)
local AppStyleProvider = UIBlox.App.Style.AppStyleProvider
local Constants = UIBlox.App.Style.Constants

local ColorMode = require(CorePackages.Packages.Foundation).Enums.ColorMode

local function dumpInstanceTree(arg1, arg2)
    arg2 = arg2 or ""
    if arg1 == nil then
        print(arg2 .. "[nil Instance]")
        return
    end

    print(arg2 .. arg1.Name)
    arg2 ..= "  "
    for _, child in ipairs(arg1:GetChildren()) do
        dumpInstanceTree(child, arg2)
    end
end

return function(callback, arg1, arg2, arg3, arg4)
    local store = Rodux.Store.new(arg2, arg3 or {}, { Rodux.thunkMiddleware })
    local element = Roact.createElement(RoactRodux.StoreProvider, { store = store }, {
        AppStyleProvider = Roact.createElement(
            AppStyleProvider,
            {
                style = {
                    themeName = ColorMode.Dark,
                    fontName = Constants.FontName.Gotham
                }
            },
            {
                Folder = Roact.createElement("Folder", {}, { Root = Roact.createElement(arg1, arg4 or {}) })
            }
        )
    })
    local str1 = tostring(arg1)

    local element2 = Roact.createElement("ScreenGui", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { [str1] = element })

    local name = "Test-" .. HttpService:GenerateGUID(false)
    local var1 = Roact.mount(element2, CoreGui, name)

    local str2 = ("game.CoreGui.%s.*[ClassName=Folder].*"):format(name)

    local success, result = pcall(function()
        callback(str2)
    end)

    if not success then
        print("Test instance tree:\n")
        dumpInstanceTree(CoreGui:FindFirstChild(name))
        print()
    end

    Roact.unmount(var1)
    if not success then
        error(result)
    end
end
