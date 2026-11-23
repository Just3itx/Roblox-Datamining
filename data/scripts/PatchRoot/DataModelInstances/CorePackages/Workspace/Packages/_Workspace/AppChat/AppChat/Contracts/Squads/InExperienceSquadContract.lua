-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:41:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)
local SocialExperiments = require(AppChatParent.SocialExperiments)
local SquadExternalContractProvider = require(AppChatParent.SquadsCore.SquadExternalContractProvider)
local Enums = require(AppChatParent.SquadsCore.Enums)

local SetSquadPrompt = require(AppChatParent.SquadsCore.Actions).SetSquadPrompt
local CloseSquadPrompt = require(AppChatParent.SquadsCore.Actions).CloseSquadPrompt

local SquadRootViewType = Enums.SquadRootViewType
local makeSquadContract = SquadExternalContractProvider.makeSquadContract

local InExperienceAppChatModal = require(AppChat.App.InExperienceAppChatModal)

local SquadCoordinationExperienceJoinExperimentation = SocialExperiments.SquadCoordinationExperienceJoinExperimentation

local SquadContract = require(script.Parent.SquadContract)

return (makeSquadContract(
    Cryo.Dictionary.union(SquadContract, {
        setSquadPrompt = function(arg1, arg2)
            arg1:dispatch(SetSquadPrompt(arg2))
        end,
        closeSquadPrompt = CloseSquadPrompt,
        useSquadRootView = function()
            local var1, var2 = React.useState(
                if SquadCoordinationExperienceJoinExperimentation.getIsSquadLobbySessionEnabled
                    and InExperienceAppChatModal.default:getVisible() then SquadRootViewType.InExperienceAppChatModal else SquadRootViewType.None
            )

            React.useEffect(function()
                local connection = InExperienceAppChatModal.default.visibilitySignal.Event:Connect(function(arg1)
                    if arg1 then
                        var2(SquadRootViewType.InExperienceAppChatModal)
                        return
                    end
                    var2(SquadRootViewType.None)
                end)

                return function()
                    if connection then
                        connection:Disconnect()
                    end
                end
            end, {})

            return var1
        end
    })
))
