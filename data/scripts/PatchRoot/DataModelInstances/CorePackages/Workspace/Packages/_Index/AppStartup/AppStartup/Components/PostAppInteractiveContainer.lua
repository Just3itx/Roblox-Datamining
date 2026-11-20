-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppStartup = script:FindFirstAncestor("AppStartup")
local AppStartupParent = AppStartup.Parent

local _AppStartupSequence = require(AppStartup.AppStartupSequence)
local _AppCommonLib = require(AppStartupParent.AppCommonLib)
local React = require(AppStartupParent.React)

return function(tbl1)
    local var1, var2 = React.useState(tbl1.appStartupSequence.isInteractive)

    React.useEffect(function()
        local connection = nil

        if tbl1.appStartupSequence.isInteractive then
            var2(true)
        else
            connection = tbl1.appStartupSequence.changed:connect(function()
                var2(tbl1.appStartupSequence.isInteractive)
                if connection ~= nil and tbl1.appStartupSequence.isInteractive then
                    connection:disconnect()
                    connection = nil
                end
            end)
        end

        return if connection then connection.disconnect else nil
    end, { tbl1.appStartupSequence })
    return React.createElement(React.Fragment, nil, not var1 and {} or tbl1.children)
end
