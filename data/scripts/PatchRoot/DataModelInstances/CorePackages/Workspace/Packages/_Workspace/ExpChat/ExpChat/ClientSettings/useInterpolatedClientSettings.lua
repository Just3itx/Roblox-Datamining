-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:10:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local React = require(ExpChatParent.React)

local Parent = require(script.Parent)
local ClientSettingsUtility = require(script.Parent.ClientSettingsUtility)

local FFlagExpChatAddressFrame0Flash = require(ExpChatParent.ChatUIPrimitives).Flags.FFlagExpChatAddressFrame0Flash

return function(arg1)
    local var1 = React.useContext(Parent)

    local var2, var3 = React.useState({
        BackgroundColor3 = if FFlagExpChatAddressFrame0Flash then ClientSettingsUtility.getBackgroundColor(arg1, var1) else nil,
        BackgroundColor = if FFlagExpChatAddressFrame0Flash then nil else ClientSettingsUtility.getBackgroundColor(arg1, var1),
        BackgroundTransparency = ClientSettingsUtility.getBackgroundTransparency(arg1, var1)
    })

    React.useEffect(function()
        var3({
            BackgroundColor3 = ClientSettingsUtility.getBackgroundColor(arg1, var1),
            BackgroundTransparency = ClientSettingsUtility.getBackgroundTransparency(arg1, var1)
        })
    end, { arg1, var1 })

    return var2
end
