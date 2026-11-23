-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:01:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local Roact = require(AppChatParent.Roact)

local RemoveUserDialogContainer = require(script.Parent.RemoveUserDialogContainer)
local Logger = require(script.Parent.Logger)

local var1 = Roact.PureComponent:extend("RemoveUserDialog")
var1.defaultProps = { navigation = nil }

function var1.init(arg1)
    function arg1.onRemoveUserDialogClose()
        arg1.props.navigation.goBack()
    end
end

function var1.render(arg1)
    local navigation = arg1.props.navigation
    assert(type(navigation) ~= "nil", "RemoveUserDialog should be wrapped with Roact Navigation")

    local conversationId = navigation.getParam("conversationId", nil)
    local participantId = navigation.getParam("participantId", nil)
    if conversationId == nil or participantId == nil then
        Logger:warning("ConversationId and participantId are required to open {screen}")
        return nil
    end

    return Roact.createElement(
        RemoveUserDialogContainer,
        {
            conversationId = conversationId,
            participantId = participantId,
            onModalClose = arg1.onRemoveUserDialogClose
        }
    )
end

function var1.didMount(_)
    Logger:info("{screen} mounted")
end

return var1
