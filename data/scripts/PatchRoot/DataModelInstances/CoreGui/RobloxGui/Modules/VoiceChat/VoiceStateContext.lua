-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:40:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Ended = game:GetEngineFeature("VoiceChatSupported") and Enum.VoiceChatState.Ended or nil

local tbl1 = { voiceEnabled = false, voiceState = Ended }

local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local React = require(CorePackages.Packages.React)
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local default = require(RobloxGui.Modules.VoiceChat.VoiceChatServiceManager).default

local Context = React.createContext(tbl1)

return {
    Provider = function(arg1)
        local value, var2 = React.useState(tbl1)

        local function updateVoiceState(_, voiceState) -- Luacid: Inlined by compiler; 2 call sites recovered
            if voiceState == value.voiceState then
                return
            end

            local voiceEnabled = voiceState ~= Enum.VoiceChatState.Ended
            var2({ voiceEnabled = voiceEnabled, voiceState = voiceState })
        end

        React.useEffect(function()
            local bool1 = true
            local connection = nil
            if game:GetEngineFeature("VoiceChatSupported") then
                default:asyncInit():andThen(function()
                    if not bool1 then
                        return
                    end

                    default:SetupParticipantListeners()
                    local service = default:getService()
                    if service then
                        updateVoiceState(nil, service.VoiceChatState)
                        connection = service.StateChanged:Connect(updateVoiceState)
                    end
                end):catch(function()
                    updateVoiceState(nil, Ended)
                end)
            end

            return function()
                bool1 = false
                if connection then
                    connection:Disconnect()
                    connection = nil
                end
            end
        end, {})

        return React.createElement(Context.Provider, { value = value }, arg1.children)
    end,
    Consumer = Context.Consumer,
    Context = Context,
    withVoiceState = function(render)
        return React.createElement(Context.Consumer, { render = render })
    end
}
