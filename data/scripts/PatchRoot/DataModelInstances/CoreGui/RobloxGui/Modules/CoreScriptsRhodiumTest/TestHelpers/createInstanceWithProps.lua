-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:11:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)
local UIBlox = require(CorePackages.Packages.UIBlox)

return function(arg1, arg2, size)
    local screenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    local myElement = if size then Roact.createElement("Frame", { Size = size }, { testElement = Roact.createElement(arg1, arg2) }) else Roact.createElement(arg1, arg2)
    local fragment = Roact.createFragment({
        styleProvider = Roact.createElement(
            UIBlox.App.Style.AppStyleProvider,
            {
                style = { themeName = "Dark", fontName = "Gotham" }
            },
            { myElement = myElement }
        )
    })
    local var1 = Roact.mount(fragment, screenGui)

    return screenGui, function()
        Roact.unmount(var1)
        screenGui:Destroy()
    end
end
