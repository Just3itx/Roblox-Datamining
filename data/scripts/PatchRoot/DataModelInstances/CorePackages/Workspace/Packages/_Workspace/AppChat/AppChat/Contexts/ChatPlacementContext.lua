-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local React = require(AppChatParent.React)

local Enum = {
    Unknown = "Unknown",
    ConnectTab = "ConnectTab",
    ChatTab = "ChatTab",
    InExperienceDefault = "InExperienceDefault",
    InExperienceFriendsTab = "InExperienceFriendsTab"
}

local Context = React.createContext({ chatPlacement = Enum.Unknown })

local Provider = Context.Provider
local Consumer = Context.Consumer

return {
    Provider = Provider,
    Consumer = Consumer,
    Context = Context,
    Enum = Enum,
    useChatPlacementContext = function()
        return React.useContext(Context)
    end,
    withChatPlacementContext = function(func1: (...any) -> (...any))
        return React.createElement(Consumer, {
            render = function(arg1)
                return func1(arg1)
            end
        })
    end,
    isPlacementInExperience = function(arg1): boolean
        return arg1 == Enum.InExperienceFriendsTab or arg1 == Enum.InExperienceDefault
    end
}
