-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:21:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local Roact = require(AppChatParent.Roact)

local EmptyConversationPage = require(script.Parent.EmptyConversationPage)

local var1 = Roact.PureComponent:extend("EmptyConversationScreen")
var1.defaultProps = { navigation = nil }

function var1.render(arg1)
    local navigation = arg1.props.navigation
    assert(type(navigation) ~= "nil", "ChatConversationScreen should be wrapped with Roact Navigation")

    return Roact.createElement(EmptyConversationPage, { topBarHeight = navigation.getScreenProps("topBarHeight", 0) })
end

return var1
