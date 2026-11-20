-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:31:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local AppStartupParent = script:FindFirstAncestor("AppStartup").Parent
local React = require(AppStartupParent.React)
local ReactRoblox = require(AppStartupParent.ReactRoblox)
local useStartupMessageProps = require(script.Parent.useStartupMessageProps)
local StartupMessage = require(script.Parent.StartupMessage)

return React.memo(function() -- name: StartupMessageContainer
    local var1 = useStartupMessageProps()

    return ReactRoblox.createPortal({ React.createElement(
            "ScreenGui",
            {
                Enabled = true,
                IgnoreGuiInset = true,
                ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
                AutoLocalize = false,
                DisplayOrder = 100
            },
            {
                StartupMessage = var1.displayStartupMessage and React.createElement(StartupMessage, var1)
            }
        ) }, CoreGui)
end)
