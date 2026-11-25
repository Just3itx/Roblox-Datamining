-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:01:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local React = require(scriptParentParent.React)
local Signals = require(scriptParentParent.Signals)
local Foundation = require(scriptParentParent.Foundation)
local ChatUIPrimitives = require(scriptParentParent.ChatUIPrimitives)
local Message = require(script.Parent.Message)
local MessageWriterContext = require(script.Parent.MessageWriterContext)

local FFlagExpChatTextChannelWindowWelcomeAndSummary = require(script.Parent.Flags.FFlagExpChatTextChannelWindowWelcomeAndSummary)

local useInExperienceLocalization = ChatUIPrimitives.Hooks.useInExperienceLocalization

local var1 = (setmetatable({}, { __mode = "k" }))

local function useSummarySystemMessage(arg1, arg2)
    local var2 = MessageWriterContext.useMessageWriter()
    local var3 = useInExperienceLocalization()

    React.useEffect(function()
        if not FFlagExpChatTextChannelWindowWelcomeAndSummary or not var2 or arg1 == nil then
            return
        end

        local var4 = arg1
        if var4.Name ~= "RBXGeneral" then
            return
        end

        return (Signals.createEffect(function(arg3)
            if not arg2(arg3) or var1[var4] then
                return
            end
            local var5 = var3("CoreScripts.TextChat.ChatWindow.SummarySystemMessage")

            var1[var4] = true
            var2.write(
                Message.createExperienceSystemMessage(
                    if var5 == "" then "Roblox auto-generates summaries of players' messages." else var5,
                    "Roblox.Summary.Info:" .. var4.Name,
                    Foundation.Enums.IconName.Nebula
                )
            )
        end))
    end, {
        var2,
        var3,
        arg1,
        arg2
    })
end
return useSummarySystemMessage
